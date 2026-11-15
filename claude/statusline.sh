#!/bin/sh
input=$(cat)
cd "$(echo "$input" | jq -r '.workspace.current_dir')" 2>/dev/null || exit 0
model=$(echo "$input" | jq -r '.model.display_name')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
export STARSHIP_SHELL=   # plain ansi, no zsh prompt escapes
s() { starship module "$1"; }
printf '%s%s%s%s%s\033[90m%s ctx %s%%\033[0m\n' \
  "$(s directory)" "$(s custom.worktree)" "$(s git_branch)" "$(s git_status)" "$(s python)" "$model" "$pct"
