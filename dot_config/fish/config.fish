# environment
## Go
set -x GOPATH $HOME/dev/go
set -x CGO_ENABLED 0
## Editors
if type -q micro
    set -x EDITOR micro
end
## gcloud
if type -q gcloud; and type -q python3.9
    set -x CLOUDSDK_PYTHON (type --path python3.9)
end

# local binaries
if [ -d $GOPATH/bin ]
    fish_add_path -m $GOPATH/bin
end
if [ -d $HOME/.local/bin ]
    fish_add_path -m $HOME/.local/bin
end

# aliases
## misc
abbr --add userctl "systemctl --user"
if not type -q docker; and type -q podman
    abbr --add docker podman
end
if type -q doas
    abbr --add sudo doas
end
## kubernetes
if not type -q kustomize; and type -q kubectl
    abbr --add kustomize "kubectl kustomize"
end
## git
if type -q git
    abbr --add add "git add"
    abbr --add commit "git commit"
end

# prompt
if type -q starship
    eval (starship init fish)
end
