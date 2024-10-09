# don't modify environment in non-login shells
if not status is-login
    return
end

set -l platform (uname | string lower)

# sudo
set sudo sudo
if type -q please
    set sudo please
else if type -q doas
    set sudo doas
end

# global PATHs
## brew
if string match -q -e $platform darwin; and path is -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
else if string match -q -e $platform linux; and path is -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
## nix
### global default profile
# don't add path if we're on, say, NixOS and path is already properly configured
if not type -q nix; and path is -d /nix/var/nix/profiles/default/bin
    fish_add_path -g -m /nix/var/nix/profiles/default/bin
end
### local profile
if path is -d $HOME/.nix-profile/bin
    fish_add_path -g -m $HOME/.nix-profile/bin
end
## bump security wrappers to the front again on NixOS
if grep -q ID=nixos /etc/os-release &>/dev/null; and path is -d /run/wrappers/bin
    fish_add_path -g -m /run/wrappers/bin
end

# fix $SHELL
if type -q fish
    set -x SHELL (type -p fish)
end

# Go
set -x GOPATH $HOME/dev/go
set -x CGO_ENABLED 0

# Editors
if type -q nvim
    if not set -U -q EDITOR &>/dev/null
        set -U -x EDITOR nvim
    end
    set -x MANPAGER "nvim +Man!"
end
# prefer universal over global variable in this case
if set -g -q EDITOR &>/dev/null
    set -g --erase EDITOR
end

if [ "$TERM_PROGRAM" = vscode ]
    set -x EDITOR "code -w"
end

# gcloud
if type -q gcloud; and type -q python3.9
    set -x CLOUDSDK_PYTHON (type --path python3.9)
end

# pnpm
if type -q pnpm
    set -x PNPM_HOME $HOME/.local/share/pnpm
    mkdir -p $PNPM_HOME
end

# modify local PATH
if [ -d $GOPATH/bin ]
    fish_add_path -g -m $GOPATH/bin
end
if [ -d $PNPM_HOME ]
    fish_add_path -g -m $PNPM_HOME
end
if [ -d $HOME/.bun/bin ]
    fish_add_path -g -m $HOME/.bun/bin
end
if [ -d $HOME/.local/bin ]
    fish_add_path -g -m $HOME/.local/bin
end
if [ -d $HOME/dev/scripts ]
    fish_add_path -g -m $HOME/dev/scripts
end
if [ -d $HOME/dev/1p/sandbox/scripts ]
    fish_add_path -g -m $HOME/dev/1p/sandbox/scripts
end

# rclone
if type -q rclone
    set -x RCLONE_FAST_LIST 1
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
