if [[ -z "$PROFILE_SOURCED" ]]; then
    source "$ZDOTDIR/.zprofile"
fi

# Aliases
alias ls="exa --icons --sort Name"
alias l="ls"
alias la="ls -a"
alias ll="ls -lh"
alias lla="la -lh"
export EXA_ICON_SPACING=2

alias lg="lazygit"

# Setup prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '
setopt PROMPT_SUBST
PROMPT='%F{blue}%1~%f %F{red}${vcs_info_msg_0_}%f󰅂 '

# History settings
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=10000
SAVEHIST=10000

# Case insensitive search
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' rehash true

# Search history with up and down arrows
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Better tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Enable syntax highlighting
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable fzf support in ZSH
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

# Enable zoxide
eval "$(zoxide init zsh)"
