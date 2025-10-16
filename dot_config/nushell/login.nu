# Set up PATH
$env.GOPATH = ([$env.HOME, "dev", "go"] | path join)
$env.PATH = (
    $env.PATH
    | split row (char esep)
    # system PATHs
    | prepend (try { open /etc/paths | str trim -r | split row "\n" } catch { [] })
    | prepend [
        "/opt/homebrew/bin"
        "/nix/var/nix/profiles/default/bin"
    ]
    # user PATHs
    | prepend [
        ([$env.HOME, "dev", "1p", "sandbox", "script"] | path join)
        ([$env.HOME, "dev", "scripts"] | path join)
        ([$env.HOME, ".local", "bin"] | path join)
        ([$env.GOPATH, "bin"] | path join)
        ([$env.HOME, ".nix-profile", "bin"] | path join)
    ]
    # special setuid / setgid binaries
    | prepend [
        "/run/wrappers/bin"
    ]
    | uniq
)

# Set up EDITOR
$env.EDITOR = (do {
    mut candidates = ([
        micro
        nvim
        hx
        vim
        vi
        nano
    ] | where { (which $in | length) != 0 })

    if (($env | get --optional TERM_PROGRAM) == "vscode") {
        $candidates = ($candidates | prepend "code -w")
    }

    $candidates | first
})

$env.SHELL = which nu | first | get path
