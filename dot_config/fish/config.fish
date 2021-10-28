# environment
## Go
set -x GOPATH $HOME/dev/go
set -x CGO_ENABLED 0
## Editors
if type -q micro
    set -x EDITOR micro
end

# local binaries
if [ -d $GOPATH/bin ]
    fish_add_path -m $GOPATH/bin
end
if [ -d $HOME/.local/bin ]
    fish_add_path -m $HOME/.local/bin
end

# aliases
abbr --add userctl "systemctl --user"
abbr --add ctx "task context"
if not type -q docker; and type -q podman
    abbr --add docker podman
end
if type -q doas
    abbr --add sudo doas
end
if not type -q kustomize; and type -q kubectl
    abbr --add kustomize "kubectl kustomize"
end

# prompt
if type -q starship
    eval (starship init fish)
end
