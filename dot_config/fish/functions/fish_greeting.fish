function fish_greeting
    if status --is-interactive; and [ "$TERM_PROGRAM" != "vscode" ]; and [ -z "$SSH_CLIENT" ]
        # Taskwarrior integration
        if type -q task
            set -l count (task +READY count 2> /dev/null)
            if [ $count -gt 0 ]
                echo $count "tasks ready."
            end
        end
    end
end
