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

## Estado actual

La separación ya está avanzada. En el repositorio Retail existen actualmente:

- `index.html` — panel principal Retail
- `pos.html` — POS Retail
- `scanner.html` — escáner/cámara para códigos de barra
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

## Comportamientos aprobados que deben conservarse

- No rehacer Retail desde cero.
- Mantener el diseño y flujo aprobado del POS original como referencia.
- El escáner debe priorizar cámara en móvil.
- La interfaz móvil no debe abrir teclado antes que cámara cuando la cámara está disponible.
- El flujo de escaneo, carrito y cobro debe permanecer integrado.
- Evitar regresiones visuales del panel lateral, encabezado y contenido principal.
- No modificar módulos ajenos cuando se corrige una incidencia localizada.

## Siguiente trabajo recomendado

1. Comparar el POS Retail separado con el POS original de `yummy-restaurante`.
2. Confirmar que cámara, lectura, sonido de confirmación, carrito y cobro siguen iguales al flujo aprobado.
3. Verificar responsividad móvil y escritorio.
4. Revisar que proveedores/compras estén conectados correctamente al panel principal.
5. Documentar aquí cualquier cambio nuevo antes de cerrar la sesión.

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
