# Yummy Retail — Contexto y continuidad del proyecto

Última actualización: 2026-09-24 (America/Santiago)

## RESET DE BASE APROBADO — 2026-09-24

Por instrucción del usuario, se abandonó temporalmente la estrategia de reconstruir Retail módulo por módulo.

El nuevo punto de partida es:

- Copiar el panel de `jorge2610g/yummy-restaurante/panel/index.html` **sin recortar módulos**.
- Retail debe abrir primero con la misma base visual y funcional que Restaurante.
- Solo después de confirmar que abre correctamente se eliminarán, uno por uno, los módulos que Retail no necesita.
- Los archivos anteriores `pos.html`, `scanner.html` y `supply.html` se conservan en el historial/repositorio, pero **no son la base activa del panel raíz** en esta etapa.
- Se copiaron también las dependencias PWA necesarias y `panel/professional.js`.
- El `CNAME` de Retail se conserva como `retail.yummypro.online`.

Commit base de sincronización completa:
- `13e7836b3c5f58253d2d8b6f5a14e9231facc235` — Sync full restaurant panel as baseline.

### Próximo paso

No agregar ni rediseñar módulos todavía. Revisar el panel copiado y comenzar a quitar únicamente lo que no corresponde a Retail, manteniendo intacto lo común con Restaurante y Profesionales.

## CLON COMPLETO DE RESTAURANTE — 2026-09-24

Se amplió el punto de partida: Retail ya no contiene solo una copia del panel. También se copió la landing page y el árbol de archivos de `yummy-restaurante` necesario para reproducir exactamente la aplicación de Restaurante antes de personalizarla.

Validación:
- 30 archivos del repositorio fuente (todos salvo `CNAME`) coinciden por SHA con Retail.
- `index.html` de Retail ahora es la landing page original de Restaurante.
- `panel/index.html` es idéntico al panel original de Restaurante.
- Se copiaron PWA, service worker, iconos, offline, documentación, configuración, pruebas y `panel/professional.js`.
- El `CNAME` propio se conserva como `retail.yummypro.online`.
- Se mantienen temporalmente `pos.html`, `scanner.html` y `supply.html` del trabajo anterior. No forman parte del clon del panel/landing y no deben eliminarse hasta recibir instrucción.

Commits de sincronización completa:
- `706b709e117fc483835a2987f5b9a76d5b367967` — landing y archivos base.
- `68f750c13724e26b83ecac0d906bf7e78cc96f37` — panel, runtime y pruebas.
- `7bb8e6cafe068c41849e5ebe1d52995a1bbb2249` — assets PWA.

Regla actual: desplegar/revisar primero esta copia completa y solo después ocultar o eliminar módulos según instrucción explícita.

## Propósito de este archivo

Este documento es el punto de continuidad oficial para retomar el trabajo de `jorge2610g/yummy-retail` cuando una conversación se corte, cambie el agente o se abra un chat nuevo.

Al retomar, pedir al agente:

> Abre `PROJECT_CONTEXT.md` del repositorio `jorge2610g/yummy-retail`, revisa los commits recientes y continúa desde el último pendiente sin rehacer lo ya terminado.

## Repositorio actual

- Repositorio: `jorge2610g/yummy-retail`
- Rama principal: `main`
- Dominio configurado: `retail.yummypro.online`
- Repositorio origen del que se separó Retail: `jorge2610g/yummy-restaurante`

## Objetivo de la separación

Extraer la operación Retail del panel general de Restaurante para que supermercados, minimarkets y otros negocios retail tengan un panel independiente, manteniendo la lógica ya aprobada y evitando romper los flujos existentes.

## Estrategia de arquitectura aprobada

- Restaurante, Retail y Profesionales deben compartir el mismo panel base: encabezado, navegación, tema, responsive, tamaños, colores, sesión, notificaciones y suscripción.
- Solo deben variar los módulos específicos del tipo de negocio.
- El trabajo se hará módulo por módulo y en paralelo para evitar terminar un vertical y luego rehacer el siguiente desde cero.
- Lo común debe quedar visual y funcionalmente idéntico; lo específico del negocio puede vivir en módulos separados.

## Estado actual

La separación ya está avanzada. En el repositorio Retail existen actualmente:

- `index.html` — panel principal Retail
- `pos.html` — POS Retail
- `scanner.html` — productos/inventario y escáner aislado
- `supply.html` — proveedores y compras
- `manifest.webmanifest` — PWA
- `CNAME` — dominio `retail.yummypro.online`

## Funcionalidades ya migradas o trabajadas

- Panel Retail independiente.
- POS Retail separado.
- Escaneo de productos por cámara/código de barras.
- Flujo de cobro del POS.
- Módulo de proveedores y compras.
- Carga diferida de módulos Retail.
- Restauración del flujo POS aprobado del panel original.
- Restauración del menú lateral y estructura visual del panel original.
- Ajustes de escritorio para ocupar correctamente el ancho disponible.
- Alineación visual del shell Retail con el diseño original aprobado.

## Auditoría minuciosa en curso — 2026-09-23

Se está comparando `yummy-retail` contra `yummy-restaurante/panel/index.html` módulo por módulo, incluyendo lógica, responsive, colores, tamaños y comportamiento móvil/escritorio.

### Panel base / shell

- La paleta principal del shell Retail conserva los tokens base del panel original: fondo, tarjetas, campos, texto, líneas, amarillo principal y azul activo.
- VALIDADO 2026-09-24: el shell de escritorio quedó alineado con el panel aprobado usando sidebar fija de 234 px y contenido a ancho completo.
- VALIDADO 2026-09-24: se restauró el modo colapsado de escritorio a 68 px, con iconos centrados y estado persistente por navegador.
- VALIDADO 2026-09-24: el drawer móvil usa la geometría aprobada (izquierda 0, alto completo, ancho máximo 310 px / 86vw) y el botón hamburguesa solo aparece en móvil.
- Commit de esta corrección: `c4e85681ec618a6c38686efa247a26e7ed81888a`.

### POS Retail — validado y corregido

- El POS separado conserva carrito, caja, historial, descuento, métodos de pago, ticket automático, control de stock y RPC de venta.
- El sonido de confirmación al escaneo exitoso sigue presente.
- El ticket automático sigue persistente por negocio y apagado por defecto salvo que el usuario lo active.
- CORREGIDO: se eliminó el foco automático que podía abrir el teclado antes que la cámara en móvil.
- CORREGIDO: el cobro vuelve a permanecer integrado dentro de la ventana del escáner y permite “Seguir escaneando” sin perder el carrito.
- CORREGIDO: colores, radios, controles y tamaños principales del POS se normalizaron con los tokens del panel base.
- Commit de la corrección: `b67b857da79d3da1149c9be2ad899daf657fbafe`.

### Productos / escáner aislado

- `scanner.html` prioriza automáticamente la cámara al crear un producto nuevo cuando el navegador lo permite.
- Mantiene ingreso manual como respaldo.
- VALIDADO 2026-09-24: los campos principales coinciden con el módulo Retail aprobado: código de barra, SKU, nombre, marca, categoría, costo, precio, stock, mínimo, unidad, fraccionado, activo e imagen.
- RESTAURADO 2026-09-24: selección de imagen desde Galería, Tomar foto con cámara y vista previa.
- RESTAURADO 2026-09-24: subida de imágenes al bucket `restaurant-assets` con validación JPG/PNG/WEBP y máximo 5 MB.
- RESTAURADO 2026-09-24: lector alternativo con `html5-qrcode` cuando `BarcodeDetector` no está disponible o falla, conservando además el ingreso manual.
- ALINEADO 2026-09-24: métricas de productos activos, stock bajo y valor de inventario.
- Commit de estas correcciones: `2dbb4adb30c0caccfaa77bb7695575da24658ee2`.
- PENDIENTE CONFIRMADO: el módulo original también ofrece carga masiva de catálogo (Excel/CSV/JSON/XML y foto/IA beta); esta función todavía no está migrada a `scanner.html`.

### Proveedores / compras

- `supply.html` contiene proveedores, compras, historial y suma de stock.
- Su CSS es una versión simplificada independiente; todavía no puede considerarse visualmente idéntica al panel principal hasta terminar la comparación responsive y de componentes.

### Regla para corregir

No corregir de forma masiva hasta cerrar la comparación del bloque actual. Las correcciones deben aplicarse por módulo, con commit claro, validación y actualización de este documento.

## Commits importantes recientes

- `c24b3017a3f7c07974775947edb4d5ec6cf149ec` — migrar flujo POS Retail independiente.
- `7d868f8b798bc2b1286c95a940d8fcc99c9277bc` — integrar POS Retail completo y lazy-load de módulos.
- `19237a7066d4f6e201a0a2befa085b80d72464aa` — agregar proveedores y compras Retail.
- `d81846dc9cf36cb0c720dcd13b05813ae51b6d53` — integrar proveedores y compras en el panel Retail.
- `f7d0a65a44eb9b4e47107cf8c1dea9ec86f37c38` — restaurar flujo POS para coincidir con el panel original.
- `82522cc3f2bb8817c202767455eefb5c7dbeddb1` — restaurar layout aprobado del panel YummyPro.
- `384b212261349c103d266b164ec8e466093f6267` — restaurar POS y escáner aprobados.
- `d2db5c9c3f5c48339275c68f0f361c7a9437826d` — restaurar sidebar agrupado y shell del panel.
- `d2fc9c34966deda31fbd6aec79489b39f1826b49` — ajustar layout desktop Retail.
- `e43d43b40d34ad2472b07ab35f4bdb2abcafc078` — alinear shell Retail con el panel original aprobado.
- `778f61056d2bacfabe4957057b95ffeafd7e036c` — crear contexto persistente del proyecto.
- `58ec7d23a6d36e163529a6f269336b7aed6ec890` — documentar auditoría y regresiones Retail.
- `b67b857da79d3da1149c9be2ad899daf657fbafe` — corregir flujo scanner-first, cobro integrado y estilos del POS Retail.
- `c4e85681ec618a6c38686efa247a26e7ed81888a` — alinear shell responsive Retail con el panel aprobado.
- `2dbb4adb30c0caccfaa77bb7695575da24658ee2` — restaurar fotos de producto y lector compatible alternativo.

## Comportamientos aprobados que deben conservarse

- No rehacer Retail desde cero.
- Mantener el diseño y flujo aprobado del POS original como referencia.
- El escáner debe priorizar cámara en móvil.
- La interfaz móvil no debe abrir teclado antes que cámara cuando la cámara está disponible.
- El flujo de escaneo, carrito y cobro debe permanecer integrado.
- Al cobrar desde el escáner debe existir la posibilidad de volver a seguir escaneando sin perder el carrito.
- Evitar regresiones visuales del panel lateral, encabezado y contenido principal.
- No modificar módulos ajenos cuando se corrige una incidencia localizada.

## Siguiente trabajo recomendado

1. Migrar o cerrar explícitamente la paridad de la carga masiva de catálogo en `scanner.html` (Excel/CSV/JSON/XML y foto/IA beta).
2. Comparar y normalizar `supply.html` (proveedores/compras) contra el módulo original, incluyendo responsive y componentes.
3. Validar en HTTPS/dispositivo real cámara nativa, fallback `html5-qrcode`, carga desde Galería/Tomar foto y almacenamiento.
4. Aplicar el mismo panel base a Profesionales en paralelo, habilitando solo sus módulos correspondientes.
5. Documentar cada commit antes de cerrar la sesión.

## Regla de continuidad

Después de cada cambio importante:

1. Hacer commit con un mensaje claro.
2. Actualizar este archivo con:
   - qué se cambió;
   - qué quedó validado;
   - commit correspondiente;
   - qué queda pendiente.
3. No borrar el historial de decisiones importantes; resumirlo y conservar la referencia del commit.

## Nota sobre memoria de conversación

La memoria de una conversación no debe considerarse la fuente única de continuidad. Este archivo en GitHub debe tratarse como la referencia canónica del estado del proyecto Retail.

## AUDITORÍA DE LIMPIEZA — 2026-09-24

Se comparó el árbol completo contra `jorge2610g/yummy-restaurante`.

Resultado final:
- 0 archivos de código extra.
- 0 archivos copiados con SHA distinto.
- 0 archivos faltantes de la copia original, excluyendo el `CNAME` que debe ser propio del dominio.
- `PROJECT_CONTEXT.md` se conserva solo como documentación de continuidad; no forma parte del runtime.
- Se eliminaron los archivos heredados del intento anterior: `pos.html`, `scanner.html` y `supply.html`.

Regla: cualquier personalización futura debe partir de esta copia limpia y hacerse solo por instrucción explícita.
