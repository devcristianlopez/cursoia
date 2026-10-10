#!/usr/bin/env bash
set -euo pipefail

if [[ ! -d /workspaces || ! -d /workspaces/cursoia ]]; then
    echo 'Ejecuta este script DENTRO del Codespace de cursoia.' >&2
    exit 1
fi
for tool in python3 git curl; do
    command -v "$tool" >/dev/null || { echo "Falta requisito: $tool" >&2; exit 1; }
done

export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"
if ! command -v uv >/dev/null; then
    curl --fail --silent --show-error --location https://astral.sh/uv/install.sh | sh
fi
if ! command -v opencode >/dev/null; then
    curl --fail --silent --show-error --location https://opencode.ai/v2/install | bash
fi
opencode --version

repo=/workspaces/lemoria
revision=807c918a72e675c3a760e963a39b6d42c759030f
if [[ ! -d "$repo/.git" ]]; then
    # git clone acepta el directorio vacío preparado por Compose, nunca lo borra.
    git clone https://github.com/devcristianlopez/lemoria.git "$repo"
    git -C "$repo" checkout --detach "$revision"
else
    echo "Se conserva checkout existente: $(git -C "$repo" rev-parse HEAD)"
fi
[[ -f "$repo/installer/lib.sh" ]] || { echo 'Checkout Lemoria incompleto.' >&2; exit 1; }

# Este archivo se puede cargar también desde shells nuevos. No guarda secretos.
mkdir -p /workspaces/.lemoria-state
cat > /workspaces/.lemoria-state/env.sh <<'ENV'
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"
export LEMORIA_DB_HOST="${LEMORIA_DB_HOST:-db}"
export LEMORIA_DB_PORT="${LEMORIA_DB_PORT:-5432}"
export LEMORIA_DB_USER="${LEMORIA_DB_USER:-lemoria}"
export LEMORIA_DB_PASSWORD="${LEMORIA_DB_PASSWORD:-lemoria}"
export LEMORIA_DB_NAME="${LEMORIA_DB_NAME:-lemoria}"
export LEMORIA_VAULT_PATH="${LEMORIA_VAULT_PATH:-/workspaces/.lemoria-state/vault}"
export LEMORIA_OPENCODE_AGENTS_DIR="${LEMORIA_OPENCODE_AGENTS_DIR:-$HOME/.config/opencode/agents}"
ENV
source /workspaces/.lemoria-state/env.sh
startup='[ ! -f /workspaces/.lemoria-state/env.sh ] || source /workspaces/.lemoria-state/env.sh'
grep -qxF "$startup" "$HOME/.bashrc" 2>/dev/null || printf '\n%s\n' "$startup" >> "$HOME/.bashrc"

uv tool install --editable '/workspaces/lemoria[dev]'
export PATH="$(uv tool dir --bin):$PATH"
lemoria init

# install.sh comprueba localhost: no sirve sin cambios para nuestro host `db`.
# Reutilizamos su helper de menú y sus artefactos, sin iniciar otro PostgreSQL.
global="$HOME/.config/opencode"
mkdir -p "$LEMORIA_OPENCODE_AGENTS_DIR" "$global/skills" "$global/commands"
cp "$repo"/.opencode/agents/*.md "$LEMORIA_OPENCODE_AGENTS_DIR/"
cp -R "$repo"/.opencode/skills/. "$global/skills/"
cp "$repo"/.opencode/commands/*.md "$global/commands/"
source "$repo/installer/lib.sh"
install_opencode_lemoria_menu "$repo" "$global" "$LEMORIA_OPENCODE_AGENTS_DIR"

# Parche SOLO sobre el comando instalado, no sobre el checkout editable.
python3 - "$global/commands/lemoria.md" <<'PY'
import sys
from pathlib import Path

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")
parts = text.split("---", 2)
if len(parts) != 3 or parts[0].strip():
    raise SystemExit("Formato inesperado en commands/lemoria.md; revisar manualmente")
metadata = [line for line in parts[1].splitlines()
            if not line.startswith(("agent:", "model:"))]
metadata.append("agent: orchestrator")
path.write_text("---\n" + "\n".join(metadata).strip() + "\n---" + parts[2], encoding="utf-8")
PY
lemoria agent sync
lemoria agent list
echo 'Preparado. Ejecuta: source /workspaces/.lemoria-state/env.sh'
echo 'Después: cd /workspaces/cursoia && opencode; selecciona modelo y usa /lemoria.'
