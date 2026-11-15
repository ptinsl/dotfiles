#!/usr/bin/env bash
set -e
mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

command -v jq >/dev/null || { curl -sSL -o ~/.local/bin/jq https://github.com/jqlang/jq/releases/latest/download/jq-linux-amd64 && chmod +x ~/.local/bin/jq; }
command -v starship >/dev/null || curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin

grep -q 'starship init bash' ~/.bashrc || cat >> ~/.bashrc <<'B'
export PATH="$HOME/.local/bin:$PATH"
export STARSHIP_CONFIG="$HOME/dotfiles/starship.toml"
eval "$(starship init bash)"
B

f=~/.claude/settings.json; mkdir -p ~/.claude; [ -f "$f" ] || echo '{}' > "$f"
jq '.statusLine = {"type":"command","command":"~/dotfiles/claude/statusline.sh"}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
echo "done. run: exec bash"
