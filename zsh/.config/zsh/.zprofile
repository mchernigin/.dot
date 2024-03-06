export SHELL="/bin/zsh"
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export TERM="xterm-256color"

# Bin
export PATH="$HOME/.local/bin:$PATH"
# Scripts
export PATH="$HOME/.local/scripts":$PATH
# Homebrew
export PATH="/opt/homebrew/bin":$PATH
export HOMEBREW_NO_AUTO_UPDATE=1
# Bun
export PATH="$HOME/.bun/bin:$PATH"

# XDG Paths config
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# XDG Specific configs
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/ipython"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/lesshst"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export STACK_ROOT="$XDG_DATA_HOME/stack"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"

# ncurses
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# Go
export GOPATH="$XDG_DATA_HOME/go"

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
source "$CARGO_HOME/env"
export PATH="$PATH:$CARGO_HOME/bin"

# Javascript
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Rye
export RYE_HOME="$XDG_DATA_HOME/rye"
source "$RYE_HOME/env"

