#!/usr/bin/env bash
set -e
sudo apt-get update && sudo apt-get install -y jq
curl -sS https://starship.rs/install.sh | sh -s -- -y

grep -q 'starship init bash' ~/.bashrc || cat >> ~/.bashrc <<'B'
export STARSHIP_CONFIG="$HOME/dotfiles/starship.toml"
eval "$(starship init bash)"
B

f=~/.claude/settings.json; mkdir -p ~/.claude; [ -f "$f" ] || echo '{}' > "$f"
jq '.statusLine = {"type":"command","command":"~/dotfiles/claude/statusline.sh"}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
