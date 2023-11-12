set -l platform (uname | string lower)

# sudo
set sudo "sudo"
if type -q please
    set sudo "please"
else if type -q doas
    set sudo "doas"
end

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

# Go
if type -q go
    set -x GOPATH $HOME/dev/go
    set -x CGO_ENABLED 0
end

# Editors
if type -q hx
    set -x EDITOR hx
else if type -q nvim
    set -x EDITOR nvim
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
    fish_add_path -g -m $PNPM_HOME
end

# local binaries
if [ -d $GOPATH/bin ]
    fish_add_path -g -m $GOPATH/bin
end
if [ -d $HOME/.local/bin ]
    fish_add_path -g -m $HOME/.local/bin
end
if [ -d $HOME/dev/scripts ]
    fish_add_path -g -m $HOME/dev/scripts
end

# source platform-specific scripts
set -l platform_script $HOME/.config/fish/platform/$platform.fish
if test -f $platform_script
    source $platform_script
end

