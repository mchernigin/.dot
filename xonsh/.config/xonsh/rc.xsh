import platform

$PATH.append($HOME + "/.local/bin")

if platform.system() == "Darwin":
    $PATH.append("/opt/homebrew/bin")

$XDG_CONFIG_HOME = $HOME + "/.config"
$XDG_CACHE_HOME  = $HOME + "/.cache"
$XDG_DATA_HOME   = $HOME + "/.local/share"

$GNUPGHOME = $XDG_DATA_HOME + "/gnupg"
$WGETRC = $XDG_CONFIG_HOME + "/wget/wgetrc"

# Rust
$RUSTUP_HOME = $XDG_DATA_HOME + "/rustup"
$CARGO_HOME = $XDG_DATA_HOME + "/cargo"
$PATH.append($CARGO_HOME + "/bin")

# Go
$GO_HOME = $XDG_DATA_HOME + "/go"
$GOPATH = $GO_HOME
$PATH.append($GO_HOME + "/bin")

aliases['ls'] = "exa --icons --sort Name"
aliases['l'] = "ls"
aliases['la'] = "ls -a"
aliases['ll'] = "ls -lh"
aliases['lla'] = "la -lh"
$EXA_ICON_SPACING = 2

