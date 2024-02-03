set -l platform (uname | string lower)

# sudo
set sudo "sudo"
if type -q please
    set sudo "please"
else if type -q doas
    set sudo "doas"
end

# global PATHs
if status is-login
    # brew
    if string match -q -e $platform darwin; and path is -d /opt/homebrew
        eval (/opt/homebrew/bin/brew shellenv)
    else if string match -q -e $platform linux; and path is -d /home/linuxbrew/.linuxbrew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end

    # nix
    ## global default profile
    # don't add path if we're on, say, NixOS and path is already properly configured
    if not type -q nix; and path is -d /nix/var/nix/profiles/default/bin
        fish_add_path -g -m /nix/var/nix/profiles/default/bin
    end
    ## local profile
    if path is -d $HOME/.nix-profile/bin
        fish_add_path -g -m $HOME/.nix-profile/bin
    end
end

# Go
if type -q go
    set -x GOPATH $HOME/dev/go
    set -x CGO_ENABLED 0
end

# Editors
if type -q hx
    set -x EDITOR (type -p hx)
end

if type -q nvim
    set -x EDITOR (type -p nvim)
    set -x MANPAGER "nvim +Man!"
end

if [ "$TERM_PROGRAM" = "vscode" ]
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
if status is-login
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
end

# rclone
if type -q rclone
    set -x RCLONE_FAST_LIST 1
end

# podman socket for docker
if type -q podman; and type -q docker; and test -z $DOCKER_HOST; and [ $USER != "root" ]
    set -x DOCKER_HOST unix:///run/user/(id -u)/podman/podman.sock
end

# source platform-specific scripts
set -l platform_script $HOME/.config/fish/platform/$platform.fish
if test -f $platform_script
    source $platform_script
end

