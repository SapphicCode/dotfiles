# environment
## Go
set -x GOPATH $HOME/dev/go
set -x CGO_ENABLED 0

# local binaries
if [ -d $GOPATH/bin ]
    set -x -p PATH $GOPATH/bin
end
if [ -d $HOME/.local/bin ]
    set -x -p PATH $HOME/.local/bin
end

# fish MOTD
function fish_greeting
    if not status --is-login; and status --is-interactive
        if type -q task; and [ -d ~/.task/ ]
            task next
        end
    end
end

# aliases
alias userctl="systemctl --user"
alias dc="docker-compose"
if not type -q docker; and type -q podman
    abbr --add docker podman
end
if type -q doas
    abbr --add sudo doas
end

# editor
if type -q micro
    alias vi=micro
    alias vim=micro
    set -x EDITOR micro
end

# prompt
if type -q starship
    eval (starship init fish)
end
