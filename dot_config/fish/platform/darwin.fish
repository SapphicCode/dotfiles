# Attempt to find macOS' native SSH agent (for non-GUI contexts)
if not set -q SSH_AUTH_SOCK
    for path in /private/tmp/com.apple.launchd.*
        if [ -S $path/Listeners ]
            set -f -x SSH_AUTH_SOCK $path/Listeners

            # see if it works
            if not ssh-add -l &>/dev/null
                continue
            end

            # found it
            set -g -x SSH_AUTH_SOCK $SSH_AUTH_SOCK
            break
        end
    end
end

# iTerm shell integration
if status is-interactive; and [ "$TERM_PROGRAM" = "iTerm.app" ]; and [ -f "$HOME/.config/fish/iterm_integration.fish" ]
    source "$HOME/.config/fish/iterm_integration.fish"
end

# CLI application launchers
function fish_command_not_found
    if string match -q -r '\.app$' $argv[1]
        open -a $argv[1] $argv[2..]
    else
        echo "fish: command not found: $argv[1]"
    end
end
