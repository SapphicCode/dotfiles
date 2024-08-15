# unset macOS SSH_AUTH_SOCK
if string match -q "/private/tmp/com.apple.launchd*/Listeners" $SSH_AUTH_SOCK
    set -e -g SSH_AUTH_SOCK
end

# iTerm shell integration
if status is-interactive; and [ $TERM_PROGRAM = "iTerm.app" ]
    source ~/.config/fish/iterm_integration.fish
end

# CLI application launchers
if type -q fd
    for app in (fd --max-depth 2 -t directory '\.app$' /Applications ~/Applications)
        set -l app_safe (string replace -r -a "[^\w.]" "" (basename $app))
        alias $app_safe "open -a '$app'"
    end
end
