# Go
set -x GOPATH $HOME/dev/go
set -x CGO_ENABLED 0

# Editors
if type -q micro
    set -x EDITOR micro
end

# gcloud
if type -q gcloud; and type -q python3.9
    set -x CLOUDSDK_PYTHON (type --path python3.9)
end

# brew
if [ -d /opt/homebrew ]
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR $HOMEBREW_PREFIX/Cellar
    set -gx HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
    fish_add_path -m $HOMEBREW_PREFIX/bin
    fish_add_path -m $HOMEBREW_PREFIX/sbin
end

# macOS python
if [ -d $HOME/Library/Python ]
    for path in $HOME/Library/Python/*/bin
        fish_add_path -m $path
    end
end

# local binaries
if [ -d $GOPATH/bin ]
    fish_add_path -m $GOPATH/bin
end
if [ -d $HOME/.local/bin ]
    fish_add_path -m $HOME/.local/bin
end
if [ -d $HOME/dev/scripts ]
    fish_add_path -m $HOME/dev/scripts
end
