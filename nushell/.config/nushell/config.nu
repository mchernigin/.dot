source theme.nu

$env.EDITOR = "hx"
$env.TERM = "xterm-256color"

# XDG Paths config
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local" "state")

# XDG Specific configs
$env.GNUPGHOME = $"($env.XDG_DATA_HOME)/gnupg"
$env.DOCKER_CONFIG = $"($env.XDG_CONFIG_HOME)/docker"
$env.IPYTHONDIR = $"($env.XDG_CONFIG_HOME)/ipython"
$env.JUPYTER_CONFIG_DIR = $"($env.XDG_CONFIG_HOME)/ipython"
$env.NPM_CONFIG_USERCONFIG = $"($env.XDG_CONFIG_HOME)/npm/npmrc"
$env.NODE_REPL_HISTORY = $"($env.XDG_DATA_HOME)/node_repl_history"
$env.LESSKEY = $"($env.XDG_CONFIG_HOME)/less/lesskey"
$env.LESSHISTFILE = "-"
$env.WGETRC = $"($env.XDG_CONFIG_HOME)/wget/wgetrc"

# Homebrew
$env.PATH = ($env.PATH | prepend "/opt/homebrew/bin")

# NPM
$env.PATH = ($env.PATH | append $"($env.XDG_DATA_HOME)/npm/bin")

# Rust
$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"
$env.PATH = ($env.PATH | append $"($env.CARGO_HOME)/bin")

# Go
$env.GOPATH = $"($env.XDG_DATA_HOME)/go"
$env.PATH = ($env.PATH | append $"($env.GOPATH)/bin")

$env.config = {
  buffer_editor: $env.EDITOR,
  color_config: $flexoki_dark,
  show_banner: false,
  table: {
    mode: 'none'
  }
}

$env.PROMPT_COMMAND = { ||
  let cur_dir = if $env.PWD == $env.HOME { "~" } else { $env.PWD | path basename }
  let git_branch = (gstat | get branch)
  let git_str = if $git_branch != "no_branch" { $" \(($git_branch)\)" } else { "" }
  $"(ansi green)($cur_dir)(ansi white)($git_str) (ansi reset)"
}
$env.PROMPT_COMMAND_RIGHT = ""

