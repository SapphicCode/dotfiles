# unset macOS SSH_AUTH_SOCK
if string match -q "/private/tmp/com.apple.launchd*/Listeners" $SSH_AUTH_SOCK
    set -e -g SSH_AUTH_SOCK
end

# SSH agents: Secretive for regular SSH, 1Password for Git
if [ -z $SSH_CLIENT ] # check we're not remote
    set -x SSH_AUTH_SOCK $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    function git --wraps git
        set -f -x SSH_AUTH_SOCK $HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock
        command git $argv
        return $status
    end
end

# CLI application launchers
if type -q fd
    for app in (fd --max-depth 2 -t directory '\.app$' /Applications ~/Applications)
        set -l app_safe (string replace -r -a "[^\w.]" "" (basename $app))
        alias $app_safe "open -a '$app'"
    end
end
