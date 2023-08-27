# Nushell Environment Config File

# Set up extra PATHs
$env.PATH = ($env.PATH | prepend (do {
    mut paths = []

    # /etc/paths
    if ("/etc/paths" | path exists) {
        $paths = ($paths | prepend (open /etc/paths | str trim | split row "\n" | where (not $it in $env.PATH)))
    }

    # homebrew
    let brew = "/opt/homebrew"
    if (
        ($brew | path exists) and
        ((uname) == "Darwin") and
        (not ([$brew, "bin"] | path join) in $env.PATH)
    ) {
        $paths = ($paths | prepend [
            ([$brew, "bin"] | path join),
            ([$brew, "sbin"] | path join)
        ])
    }

    # ~/.local/bin
    let local_bin = ([$env.HOME, ".local", "bin"] | path join)
    if (($local_bin | path exists) and (not $local_bin in $env.PATH)) {
      $paths = ($paths | prepend $local_bin)
    }

    $paths
}))

def _external_exists [binary] {
    return ((do { type $binary } | complete).exit_code == 0)
}

$env.EDITOR = (do {
    mut candidates = ([
        hx
        nvim
        vim
        vi
        nano
    ] | where { _external_exists $in })

    if ($env.TERM_PROGRAM == "vscode") {
        $candidates = ($candidates | prepend "code -w")
    }

    $candidates | first
})

# Install starship
if (_external_exists starship) {
    starship init nu | save -f ~/.cache/starship/init.nu
}
