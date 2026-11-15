#!/usr/bin/env bash
set -e
sudo apt-get update && sudo apt-get install -y zsh zsh-autosuggestions zsh-syntax-highlighting jq
curl -sS https://starship.rs/install.sh | sh -s -- -y

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
echo "set -g default-shell $(command -v zsh)" >> ~/.tmux.conf
tmux source-file ~/.tmux.conf || true

f=~/.claude/settings.json; mkdir -p ~/.claude; [ -f "$f" ] || echo '{}' > "$f"
jq '.statusLine = {"type":"command","command":"~/dotfiles/claude/statusline.sh"}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
