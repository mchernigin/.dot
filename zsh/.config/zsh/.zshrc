# Aliases
alias ls="exa --icons"
alias l="ls"
alias la="ls -a"
alias ll="ls -lh"
alias lla="la -lh"
alias lg="lazygit"

# Setup prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '
setopt PROMPT_SUBST
PROMPT='%F{blue}%1~%f %F{red}${vcs_info_msg_0_}%f󰅂 '

# History settings
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000

# Case insensitive search
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

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
