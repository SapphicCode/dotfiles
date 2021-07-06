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

# aliases
alias userctl="systemctl --user"
alias dc="docker-compose"
if type -q micro
    alias vi=micro
    alias vim=micro
end

# # SSH agents
# set -x SSH_AUTH_SOCK /run/user/(id -u)/ssh-agent.sock
# ## yubikey-agent
# if type -q yubikey-agent && [ ! -S $SSH_AUTH_SOCK ]
    # yubikey-agent -l $SSH_AUTH_SOCK > /dev/null ^ /dev/null &; disown
# end
# ## GPG agent
# if type -q gpgconf && [ ! -S $SSH_AUTH_SOCK ]
    # set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    # gpgconf --launch gpg-agent
# end

# prompt
if type -q starship
    eval (starship init fish)
end
