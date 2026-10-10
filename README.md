# Taller: de la idea a una miniapp con IA

**Cristian López · Python Chile**
**Duoc UC · Sede Valparaíso** · Python básico · Trabajo individual · 2–3 horas

Primera versión de una presentación HTML offline y guía práctica individual de
**OpenCode V2 + Lemoria + Python/Streamlit**. Sin Astro, npm ni build.
La infraestructura necesita Internet; la presentación no.

## Ver la presentación

Abre `index.html` directamente o, desde este repositorio:

```bash
python -m http.server 8080
```

Visita <http://localhost:8080>. No requiere instalar las herramientas del taller.

28 diapositivas: flechas o espacio para navegar, **N** para notas del instructor,
**F** para pantalla completa y **P** para imprimir/guardar PDF. El índice permite
saltar a cualquier sección. Las notas se muestran en la misma pantalla: ocúltalas
al proyectar si quieres conservarlas como guía privada.

Fuentes y límites de la investigación: [FUENTES.md](FUENTES.md).

## Preparar el Codespace (ejercicio manual)

1. En GitHub, crea preferiblemente un **fork propio** de `devcristianlopez/cursoia`
   y abre ese fork → **Code → Codespaces → Create**. La práctica es individual;
   confirmar antes del taller que cada participante dispone de cuenta y cuota.
2. Espera la creación del contenedor Python 3.12 y el servicio PostgreSQL 16.
   Nada instala agentes automáticamente. Desde la terminal del Codespace:

   ```bash
   cd /workspaces/cursoia
   bash scripts/setup-taller.sh
   source /workspaces/.lemoria-state/env.sh
   uv --version
   opencode --version
   lemoria agent list
   opencode
   ```

3. En OpenCode selecciona un modelo disponible en tu cuenta; comprueba precio y
   cuota antes de enviar prompts. No se garantiza un modelo gratuito concreto.
   Usa `/lemoria` para empezar: el comando instalado apunta a `orchestrator` y
   no fija `openai/gpt-5.5`. Si ya tenías OpenCode V1, actualiza manualmente según
   la [guía oficial V2](https://opencode.ai/v2/docs/); el script no reemplaza un
   ejecutable existente. Reinicia OpenCode si estaba abierto durante el setup.

El setup no modifica tu configuración global `default_agent`: entra siempre con
`/lemoria` (o selecciona explícitamente `orchestrator`). Copiar agentes y configurar
el menú no cambia el agente predeterminado de OpenCode.

El script ejecuta instaladores oficiales de uv y OpenCode V2 descargados por HTTPS:
revísalos antes de usarlo. Clona Lemoria en `/workspaces/lemoria`, fija inicialmente
la revisión `807c918a72e675c3a760e963a39b6d42c759030f` y usa
`uv tool install --editable '/workspaces/lemoria[dev]'`. **No borres ese checkout**:
el comando global depende de él. Si ya existe, no lo actualiza ni lo resetea.
Reejecutar el setup vuelve a copiar agentes/skills/comandos globales: conserva una
copia de tus personalizaciones antes. El helper oficial instala el menú de Lemoria.

### Por qué no ejecutamos `install.sh` directamente

La revisión consultada detecta y verifica PostgreSQL en `localhost`, incluso si
Pydantic recibe `LEMORIA_DB_HOST=db`. Nuestro Compose conecta `app` y `db` por su
red privada; no publica 5432. El adaptador evita crear una segunda base: inicializa
con la CLI oficial, copia artefactos globales y reutiliza
`install_opencode_lemoria_menu` de `installer/lib.sh`. No modifica modelos de datos.

Las variables reales de Lemoria son `LEMORIA_DB_HOST`, `LEMORIA_DB_PORT`,
`LEMORIA_DB_USER`, `LEMORIA_DB_PASSWORD`, `LEMORIA_DB_NAME`, `LEMORIA_VAULT_PATH` y
`LEMORIA_OPENCODE_AGENTS_DIR`. Los valores didácticos son `db:5432`, usuario/base/
contraseña `lemoria`. **No son credenciales de producción**. Compose usa las mismas
variables de credenciales para ambos servicios. Para personalizarlas, configúralas
en el entorno que lanza Compose o su `.env` antes de crear la base; cambiar variables
no cambia la contraseña de un volumen PostgreSQL ya inicializado.

El archivo `/workspaces/.lemoria-state/env.sh` exporta defaults sin pisar variables
existentes del contenedor; se carga desde `.bashrc`. Lemoria solo busca `.env` en el
directorio actual: no dependemos del `.env` del checkout. Los agentes son globales
en `~/.config/opencode/agents`; el vault queda fuera del repo, en
`/workspaces/.lemoria-state/vault`. Los volúmenes de Compose conservan DB, checkout
y vault al reiniciar; **no sustituyen un backup ni garantizan sobrevivir a borrar
el Codespace**. Un rebuild puede requerir repetir el setup para las herramientas
instaladas en `$HOME`.

## Miniapps: son ejercicios, no soluciones incluidas

Crear dos repositorios independientes, `/workspaces/todo-lab` y
`/workspaces/study-lab`, fuera del repo de la presentación. En cada uno, pedir al
orquestador un PRD corto con criterios de aceptación, tareas, implementación pequeña
y pruebas. Para la primera app:

```bash
mkdir -p /workspaces/todo-lab
cd /workspaces/todo-lab
git init
uv init --bare --python 3.12
uv add streamlit
uv add --dev pytest
opencode
# Dentro de OpenCode, usar /lemoria.
# Tras generar y revisar app.py y las pruebas:
uv run pytest
uv run streamlit run app.py --server.address 0.0.0.0 --server.port 8501
```

Abrir 8501 en la pestaña **Ports** y mantener visibilidad **Private**; no publicar
OpenCode ni la base de datos. Detener Streamlit con Ctrl+C antes de la segunda app.
Para la segunda, repetir la preparación en `/workspaces/study-lab` con `git init`,
`uv init --bare --python 3.12`, las mismas dependencias y `/lemoria`.
Las miniapps pueden guardar datos en memoria durante la sesión: PostgreSQL sirve
a la trazabilidad de Lemoria, no es un requisito extra para los ejercicios.

- **ToDo:** añadir tarea no vacía, completar y filtrar; pytest sobre
  validación y transiciones de estado, sin depender de la interfaz Streamlit.
- **Flashcards/quiz:** al menos cinco tarjetas o preguntas, mostrar respuesta, registrar acierto
  y reiniciar; pytest sobre puntuación, reinicio y casos límite. Usar solo contenido
  público o inventado; sin claves API embebidas ni datos personales.

Checkpoint común: PRD aceptado → app mínima visible → pruebas verdes → revisión
del diff y de la trazabilidad. Nunca aprobar cambios solo porque “lo dijo la IA”.

## Instructor y verificaciones

Ver [notas del instructor](docs/instructor.md) para agenda, alternativas de duración,
ensayo, backup, cuotas y pendientes. Esta base **no está ensayada en Codespaces**.
Las comprobaciones estáticas no prueban descarga, permisos, red, plugin ni modelos.

```bash
bash -n scripts/setup-taller.sh
python -m json.tool .devcontainer/devcontainer.json >/dev/null
# Opcional, en un host con Docker Compose; solo valida configuración:
docker compose -f .devcontainer/compose.yaml config --quiet
```
