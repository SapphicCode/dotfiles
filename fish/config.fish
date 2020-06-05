alias dc="docker-compose"
alias dkr="docker"
alias zt="sudo zerotier-cli"
alias cs="sudo cryptsetup"
alias rmq="sudo rabbitmqctl"

if [ -d $HOME/.local/bin ]
    set PATH $PATH $HOME/.local/bin
end

set -x GOPATH ~/dev/go
if [ -d $GOPATH/bin ]
    set PATH $PATH $GOPATH/bin
end
if type -q qt5ct
    export QT_QPA_PLATFORMTHEME=qt5ct
end

# pacman helpers
if type -q pacman
    alias install="sudo pacman -S"
    alias remove="sudo pacman -Rs"
end

# quick mastodon poster
if type -q toot
    function post
        toot post $argv
    end
end

# prompt
if type -q starship
    eval (starship init fish)
else
    function fish_prompt
        # username / user description detection
        set_color cyan
        echo -n $USER;
        set_color normal
        echo -n '@'

        set_color purple
        echo -n $hostname
        echo -n ' '

        set_color green
        echo -n (prompt_pwd)

        set_color red
        echo -n (__fish_git_prompt)

        set_color normal
        echo -n ' > '
    end
end
