import platform

# Environment variables #######################################################

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

# Aliases #####################################################################

aliases['ls'] = "exa --icons --sort Name"
aliases['l'] = "ls"
aliases['la'] = "ls -a"
aliases['ll'] = "ls -lh"
aliases['lla'] = "la -lh"
$EXA_ICON_SPACING = 2

aliases['gs'] = "git status"
aliases['ga'] = "git add"
aliases['gaa'] = "git add -A"
aliases['gd'] = "git diff"
aliases['gds'] = "git diff --staged"
aliases['gc'] = "git checkout"
aliases['gb'] = "git branch"

@aliases.register
def _gl(args):
    hash = "%C(always,yellow)%h%C(always,reset)"
    relative_time = "%C(always,green)%ar%C(always,reset)"
    author = "%C(always,bold blue)%an%C(always,reset)"
    refs = "%C(always,red)%d%C(always,reset)"
    subject = "%s"
    format = f"tformat:{hash}${relative_time}${author}${subject}{refs}"

    args = " ".join(args) if args else "."

    git log --graph --pretty=@(format) \
        | column -t -s '$' \
        | less -XRS --quit-if-one-screen

# Extensions ##################################################################

xontrib load coconut
xontrib load fzf-completions

from xonsh.built_ins import XSH

XSH.env['fzf_history_binding'] = "c-r"
XSH.env['fzf_ssh_binding'] = "c-s"
XSH.env['fzf_file_binding'] = "c-t"
XSH.env['fzf_dir_binding'] = "c-g"
