# Go
set -x GOPATH $HOME/dev/go
set -x CGO_ENABLED 0

# Editors
if type -q micro
    set -x EDITOR micro
end
if [ "$TERM_PROGRAM" = "vscode" ]
    set -x EDITOR "code -w"
end

# gcloud
if type -q gcloud; and type -q python3.9
    set -x CLOUDSDK_PYTHON (type --path python3.9)
end

# macOS python
if [ -d $HOME/Library/Python ]
    for path in $HOME/Library/Python/*/bin
        fish_add_path -g -m $path
    end
end

# brew
if string match -q -e Darwin (uname); and path is -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
else if string match -q -e Linux (uname); and path is -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
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
