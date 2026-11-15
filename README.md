# dotfiles

zsh + starship prompt + claude code status line. same setup on mac (ghostty) and the linux dev vm (windows terminal → ssh → tmux).

| file | what |
|---|---|
| `zsh/.zshrc` | history, completion, autosuggestions, syntax highlighting, starship init |
| `starship.toml` | prompt: path, worktree, branch, git status, python, duration |
| `claude/statusline.sh` | claude code status line, reuses the starship modules + model and context % |
| `install.sh` | one-off setup for the vm |

## prompt

```
~/code/repo of: parent-repo b: branch ?! py 3.12 3s
```

- `of:` only shows inside a git worktree and names the parent repo
- git status: `?` untracked, `!` modified, `+` staged, `✘` deleted, `$` stashed, `⇡⇣` ahead/behind
- edit `starship.toml` and press enter to see changes

## mac

`~/.zshrc` symlinks to `zsh/.zshrc`. deps:

```sh
brew install starship zsh-autosuggestions zsh-syntax-highlighting jq
```

## vm

from inside the tmux session:

```sh
git clone <your-repo> ~/dotfiles && ~/dotfiles/install.sh
exec zsh
```

installs zsh, plugins, jq and starship, symlinks `.zshrc`, sets tmux `default-shell` to zsh (new panes only, `exec zsh` in existing ones) and adds the status line to `~/.claude/settings.json`. run once.

## notes

- worktree segment needs git 2.31+
- zsh is for the interactive shell only; scripts stay `#!/usr/bin/env bash`
