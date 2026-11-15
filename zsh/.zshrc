export STARSHIP_CONFIG="$HOME/dotfiles/starship.toml"
HISTFILE=~/.zsh_history HISTSIZE=50000 SAVEHIST=50000
setopt share_history hist_ignore_all_dups

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zsrc() { for d in /opt/homebrew/share /usr/local/share /usr/share ~/.zsh; do [[ -f $d/$1 ]] && { source $d/$1; return; }; done; }
zsrc zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"
zsrc zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
