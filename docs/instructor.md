# Notas para facilitar el taller

## Agenda principal: 150 minutos, trabajo individual

| Minutos | Actividad | Checkpoint |
| --- | --- | --- |
| 0–15 | Objetivo y conceptos: modelo, agente y memoria | Cuenta y navegador preparados |
| 15–45 | Fork, Codespace y setup manual; incluye 15 min de margen | CLI, agentes y modelo disponibles |
| 45–90 | PRD y ToDo guiada: construir y verificar | Añadir/completar/filtrar; pytest verde |
| 90–125 | Miniapp individual: flashcards o quiz | Criterios verificados y tests |
| 125–150 | Retomar memoria, mostrar evidencia, guardar y cerrar | Evidencias guardadas y Codespace detenido |

**120 minutos:** 10 introducción + 25 preparación + 45 ToDo + 15 para PRD y criterios de la segunda app + 25 cierre. La implementación de la segunda app es opcional.
**180 minutos:** ruta de 150 + 10 de pausa + 20 de pruebas de borde y revisión entre compañeros.
Cada persona programa y prueba; la ayuda entre compañeros no sustituye la entrega
individual. No exigir cuentas de pago para terminar: ofrecer demo guiada si la
cuota gratuita disponible no alcanza.

Preferir un fork propio de `cursoia` para el Codespace. Crear las apps como repos
independientes en `/workspaces/todo-lab` y `/workspaces/study-lab` mediante `git init`
y `uv init --bare --python 3.12`. ToDo cubre añadir, completar y filtrar (sin eliminar);
la segunda app incluye al menos cinco flashcards o preguntas de quiz. Entrar al
flujo con `/lemoria`: el setup no cambia el agente predeterminado global.

## Ensayo previo obligatorio

- Pendientes de confirmar: **fecha exacta, aforo, cuentas y cuotas disponibles, apoyo y duración exacta dentro de 2–3 horas**. Nivel acordado: Python básico. La modalidad individual no presupone cuentas
  ya verificadas.
- Probar un Codespace nuevo con cuenta equivalente al alumnado; cronometrar imágenes,
  setup y primer prompt, revisar permisos del volumen `/workspaces`, hostname `db`,
  persistencia al parar/reanudar y comportamiento tras rebuild.
- Verificar OpenCode V2 real, menú Ctrl+P, `/lemoria`, modelo disponible sin pago,
  agentes globales, creación de proyecto/PRD/tarea y escritura del vault.
- Anotar versiones (`uv --version`, `opencode --version`, `lemoria --version`) y SHA
  de Lemoria. No actualizar el checkout justo antes del taller sin otro ensayo.
- Confirmar que los puertos siguen privados y PostgreSQL no está expuesto.
- Acordar límites de gasto: cuotas de Codespaces (cómputo y almacenamiento) y del
  proveedor LLM son independientes y cambian. Revisar paneles oficiales, detener
  Codespaces inactivos y no asegurar “gratis ilimitado”. Nunca compartir tokens.
- Preparar HTML descargado, capturas de cada checkpoint y demo del instructor.
  Sin red o sin cuota: analizar PRD/diff/tests con capturas y posponer ejecución.
- Si falla setup, conservar el error y revisar conectividad/credenciales. No borrar
  volúmenes ni reinstalar a ciegas; no dedicar toda la sesión a una sola máquina.

## Copias privadas de seguridad

Desde un **host con acceso a Docker Compose** y al proyecto correspondiente (la
terminal `app` no trae Docker), exportar usando el cliente PostgreSQL 16 de `db`:

```bash
mkdir -p backups
docker compose -f .devcontainer/compose.yaml exec -T db \
  sh -c 'pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" -Fc' \
  > "backups/lemoria-$(date +%Y%m%d-%H%M%S).pgdump"
```

En Codespaces, si no se dispone de ese host, usar un cliente PostgreSQL 16 externo
por un canal privado autorizado o acordar con el instructor una exportación; no
abrir 5432 a Internet ni instalar Docker dentro de `app` para improvisar un backup.
Descargar también el vault privado de `/workspaces/.lemoria-state/vault` y conservar
el trabajo de las miniapps. Una exportación del vault **no es una copia restaurable
de PostgreSQL**. Eliminar el Codespace antes del backup puede perder la memoria.

Ensayar restauración en una base desechable independiente con `pg_restore` antes
del curso. No ejecutar restauraciones sobre datos de alumnos. Nunca subir dumps,
conversaciones o secretos al repositorio. `docker compose down -v` destruye datos.

## Entrega mínima

Por persona en la ruta de 150–180 minutos: dos PRD pequeños, ambas miniapps ejecutables, pruebas pytest y una
explicación de un fallo detectado/reparado. Guardar código solo tras revisar que
no contiene secretos; guardar evidencias privadas aparte. El instructor valida
funcionalidad y comprensión, no volumen de código ni consumo de tokens. En la ruta de 120 minutos basta la ToDo funcionando y el PRD de la segunda app.
