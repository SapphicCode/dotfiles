# unset macOS SSH_AUTH_SOCK
if string match -q "/private/tmp/com.apple.launchd*/Listeners" "$SSH_AUTH_SOCK"
    set -e -g SSH_AUTH_SOCK
end

# iTerm shell integration
if status is-interactive; and [ "$TERM_PROGRAM" = "iTerm.app" ]
    source ~/.config/fish/iterm_integration.fish
end

# CLI application launchers
function fish_command_not_found
    if string match -q -r '\.app$' $argv[1]
        open -a $argv[1] $argv[2..]
    else
        echo "fish: command not found: $argv[1]"
    end
end
