-- Retail scalability: paginated catalog + indexed server lookup
create index if not exists retail_products_search_trgm_idx
on public.retail_products
using gin (
  (coalesce(name,'') || ' ' || coalesce(brand,'') || ' ' || coalesce(category,'') || ' ' || coalesce(barcode,'') || ' ' || coalesce(sku,'')) gin_trgm_ops
);

create or replace function public.retail_product_directory_page(
  p_restaurant_id bigint,
  p_limit integer default 50,
  p_offset integer default 0,
  p_search text default null
)
returns jsonb
language sql
security invoker
set search_path = ''
as $$
with scoped as (
  select p.* from public.retail_products p where p.restaurant_id = p_restaurant_id
),
filtered as (
  select * from scoped
  where nullif(btrim(coalesce(p_search,'')),'') is null
     or (coalesce(name,'') || ' ' || coalesce(brand,'') || ' ' || coalesce(category,'') || ' ' || coalesce(barcode,'') || ' ' || coalesce(sku,'')) ilike '%' || btrim(p_search) || '%'
),
page as (
  select * from filtered
  order by active desc, name asc, id asc
  offset greatest(coalesce(p_offset,0),0)
  limit least(greatest(coalesce(p_limit,50),1),100)
),
metrics as (
  select
    count(*) filter (where active) as active_count,
    count(*) filter (where active and current_stock <= minimum_stock) as low_stock_count,
    coalesce(sum(current_stock * cost),0) as inventory_value
  from scoped
)
select jsonb_build_object(
  'total',(select count(*) from filtered),
  'active_count',(select active_count from metrics),
  'low_stock_count',(select low_stock_count from metrics),
  'inventory_value',(select inventory_value from metrics),
  'rows',coalesce((select jsonb_agg(to_jsonb(page) order by active desc,name,id) from page),'[]'::jsonb)
)
$$;

revoke all on function public.retail_product_directory_page(bigint,integer,integer,text) from public, anon;
grant execute on function public.retail_product_directory_page(bigint,integer,integer,text) to authenticated;

create or replace function public.retail_product_lookup_code(
  p_restaurant_id bigint,
  p_code text
)
returns jsonb
language sql
security invoker
set search_path = ''
as $$
select to_jsonb(p)
from public.retail_products p
where p.restaurant_id = p_restaurant_id
  and p.active = true
  and (
    p.barcode = btrim(p_code)
    or p.sku = btrim(p_code)
    or (p.barcode is not null and ltrim(p.barcode,'0') = ltrim(btrim(p_code),'0'))
  )
order by case when p.barcode=btrim(p_code) then 0 when p.sku=btrim(p_code) then 1 else 2 end, p.id
limit 1
$$;

revoke all on function public.retail_product_lookup_code(bigint,text) from public, anon;
grant execute on function public.retail_product_lookup_code(bigint,text) to authenticated;

analyze public.retail_products;
