#!/usr/bin/env bash
set -e
command -v zsh >/dev/null || { echo "zsh not installed"; exit 1; }
mkdir -p ~/.local/bin ~/.zsh
export PATH="$HOME/.local/bin:$PATH"

command -v jq >/dev/null || { curl -sSL -o ~/.local/bin/jq https://github.com/jqlang/jq/releases/latest/download/jq-linux-amd64 && chmod +x ~/.local/bin/jq; }
command -v starship >/dev/null || curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin

for p in zsh-autosuggestions zsh-syntax-highlighting; do
  [ -d ~/.zsh/$p ] || git clone --depth 1 https://github.com/zsh-users/$p ~/.zsh/$p
done

grep -qs '.local/bin' ~/.zshenv || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshenv
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc

grep -qs 'default-shell' ~/.tmux.conf || echo "set -g default-shell $(command -v zsh)" >> ~/.tmux.conf
tmux source-file ~/.tmux.conf 2>/dev/null || true

f=~/.claude/settings.json; mkdir -p ~/.claude; [ -f "$f" ] || echo '{}' > "$f"
jq '.statusLine = {"type":"command","command":"~/dotfiles/claude/statusline.sh"}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
echo "done. run: exec zsh"
