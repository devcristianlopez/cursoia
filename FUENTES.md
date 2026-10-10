# Fuentes y alcance de la investigación

Consulta: 9 de octubre de 2026. Las ofertas gratuitas y versiones pueden cambiar.

## OpenCode V2

- [Instalación oficial](https://opencode.ai/v2/docs/): `curl -fsSL https://opencode.ai/v2/install | bash`.
- [Cuentas y proveedores](https://opencode.ai/v2/docs/cli/providers/): `/connect` para conectar y `/models` para elegir modelo; las credenciales V2 se guardan en SQLite, no en el antiguo `auth.json`.
- [Catálogo, precios y modelos gratuitos](https://opencode.ai/v2/docs/console/models/): Big Pickle y Space Bunny Free figuran como gratuitos por tiempo limitado. Big Pickle también figuró activo con coste de entrada/salida cero en el catálogo consultado desde esta sesión. Esto no constituye una prueba de inferencia en la cuenta de cada alumno.

## GitHub Codespaces

- [Descripción del servicio](https://docs.github.com/en/codespaces/overview): entorno Linux remoto accesible desde el navegador; no depende del sistema operativo del notebook.
- [Cuotas y facturación](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces): GitHub Free personal incluye 120 horas de cómputo ponderadas por núcleos y 15 GB-mes. Una máquina de dos núcleos consume dos horas de cuota por hora real. Detener el entorno detiene cómputo, pero no elimina su almacenamiento.
- [Persistencia](https://docs.github.com/en/codespaces/developing-in-a-codespace/persisting-environment-variables-and-temporary-files): `/workspaces` persiste al detener y reconstruir; las instalaciones y cambios en `$HOME` requieren atención al reconstruir.
- [Reconstrucción](https://docs.github.com/en/codespaces/developing-in-a-codespace/rebuilding-the-container-in-a-codespace): conservar respaldo independiente de la memoria antes de un full rebuild; no tratar un volumen Docker como respaldo.
- [Puertos](https://docs.github.com/en/codespaces/developing-in-a-codespace/forwarding-ports-in-your-codespace): abrir Streamlit desde Ports, puerto 8501. Puede permanecer privado para uso individual.

## Lemoria

- [Repositorio](https://github.com/devcristianlopez/lemoria).
- [Instalación](https://github.com/devcristianlopez/lemoria/blob/main/INSTALL.md).
- Revisión investigada: `807c918` del remoto `main`. La guía y el código deben contrastarse: el instalador usa una instalación editable, así que debe conservarse el checkout.
- Dependencias: Python 3.11+, uv y PostgreSQL 14+; el compose del proyecto usa PostgreSQL 16. Docker es una alternativa para ejecutar la base.
- Hallazgo: el comando `/lemoria` fija `openai/gpt-5.5` y `agent: build` en esa revisión. Para este taller se adapta la copia instalada para usar `orchestrator` y heredar el modelo de la sesión. Seleccionar un modelo gratuito sin corregir ese pin no basta.
- Hallazgo: el CLI busca agentes relativos al directorio actual por defecto. Para instalación global, definir `LEMORIA_OPENCODE_AGENTS_DIR` con el directorio global.
- La memoria en PostgreSQL es distinta al código Git y al estado de la app Streamlit. Un commit del proyecto no respalda automáticamente la base de Lemoria.

## Miniapps Python

- [Streamlit Session State](https://docs.streamlit.io/develop/concepts/architecture/session-state): conserva datos entre reejecuciones dentro de una sesión; no es persistencia permanente. El MVP del taller explicita esa limitación.
- [uv y versiones de Python](https://docs.astral.sh/uv/guides/install-python/): permite elegir Python 3.12 sin cambiar el intérprete del sistema.

## Qué falta ensayar

La investigación documental no equivale a ejecutar el taller. Antes de impartirlo: crear un Codespace limpio con este material, instalar el stack, completar una petición con un modelo gratuito, ejecutar la ToDo y sus pruebas, comprobar acceso al puerto 8501 y recuperar la memoria. El número de asistentes y sus cuentas GitHub aún no están confirmados.
