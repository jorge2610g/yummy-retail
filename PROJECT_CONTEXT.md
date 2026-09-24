# Yummy Retail — Contexto y continuidad del proyecto

Última actualización: 2026-09-23 (America/Santiago)

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
- El menú lateral Retail usa 234 px en escritorio, coincidiendo con el ancho final aprobado del panel principal.
- Aún se debe terminar la comparación de todos los breakpoints, estados colapsado/expandido y encabezado.

### POS Retail — hallazgos confirmados

- El POS separado conserva carrito, caja, historial, descuento, métodos de pago, ticket automático, control de stock y RPC de venta.
- El sonido de confirmación al escaneo exitoso sigue presente.
- El ticket automático sigue persistente por negocio y apagado por defecto salvo que el usuario lo active.
- REGRESIÓN: al entrar al POS separado se hace foco automático en `retailBarcodeInput`; en móvil esto puede abrir el teclado antes que la cámara.
- REGRESIÓN: desde el escáner, el botón Cobrar actualmente cierra la cámara y abre el modal de cobro aparte. El flujo aprobado del panel original mantiene el cobro dentro de la misma ventana del escáner y permite volver a “Seguir escaneando”.
- DIFERENCIA VISUAL: `pos.html` usa una paleta/tamaños propios (`--card:#16283c`, `--line:#2b4058`, radios de 22 px, botones y cámara más grandes) que no son idénticos al shell principal aprobado. Debe normalizarse con los tokens del panel base.

### Productos / escáner aislado

- `scanner.html` sí intenta abrir automáticamente la cámara al crear un producto nuevo cuando el navegador lo permite.
- Mantiene ingreso manual como respaldo.
- Aún falta comparar exactamente estilos, galería/foto, campos y responsive contra el módulo Retail del panel original.

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

1. Terminar comparación del shell y breakpoints responsive.
2. Corregir POS Retail: cámara primero y cobro dentro del escáner.
3. Normalizar colores, tamaños, radios y controles del POS al panel base.
4. Comparar productos/escáner aislado campo por campo contra el original.
5. Comparar proveedores/compras y responsive.
6. Aplicar el mismo panel base a Profesionales en paralelo, habilitando solo sus módulos correspondientes.
7. Documentar cada commit antes de cerrar la sesión.

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
