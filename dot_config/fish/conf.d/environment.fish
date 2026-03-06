# don't modify environment in non-login shells
if not begin
        status is-login; or [ "$TERM_PROGRAM" = vscode ]
    end
    return
end

# auto-attach zellij in SSH if session present
if test "$SSH_CONNECTION"; and status is-interactive; and test -z "$ZELLIJ"; and test "$TERM_PROGRAM" != vscode; and type -q zellij
    set -l start (date '+%s')
    if zellij list-sessions --no-formatting | grep --invert-match EXITED | grep -q ssh
        zellij attach ssh
    end
    set -l stop (date '+%s')
    set -l duration (math $stop - $start)
    # escape hatch if quickly quit
    if test $duration -gt 10
        exit
    end
end

set -l platform (uname | string lower)

# sudo
set sudo sudo
if type -q please
    set sudo please
else if type -q doas
    set sudo doas
end

# add nix profile to PATH early (so we can find nu)
if path is -d $HOME/.nix-profile/bin
    fish_add_path -g -m $HOME/.nix-profile/bin
end

# source universal environment setup
if type -q nu; and test -x $HOME/.local/bin/_env-setup
    $HOME/.local/bin/_env-setup fish | source
end

# brew: source shellenv for additional env vars (HOMEBREW_PREFIX, etc.)
if string match -q -e $platform darwin; and path is -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
else if string match -q -e $platform linux; and path is -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# fix $SHELL
if type -q fish
    set -g -x SHELL (type -p fish)
end

# gcloud
if type -q gcloud; and type -q python3.9
    set -g -x CLOUDSDK_PYTHON (type --path python3.9)
end

# podman socket for docker
if type -q podman; and type -q docker; and not docker context list --format '{{ .Name }}' 2>/dev/null | grep -q podman; and [ $USER != root ]
    for path in /run/user/(id -u)/podman/podman.sock $HOME/.local/share/containers/podman/machine/qemu/podman.sock
        if [ -S $path ]
            docker context create podman --docker="host=unix://$path" &>/dev/null
            break
        end
    end
end

# git: fix edge-cases with reattached shells after SSH reconnects
if [ $SSH_CLIENT ]
    function git --wraps git
        if not ssh-add -l &>/dev/null
            set -l potential_agent (fd -1 --full-path 'ssh-.+/agent.\d+' /tmp)
            if [ $potential_agent ]
                set -f -x SSH_AUTH_SOCK $potential_agent
            end
        end
        command git $argv
        return $status
    end
end

# source platform-specific scripts
set -l platform_script $HOME/.config/fish/platform/$platform.fish
if test -f $platform_script
    source $platform_script
end
