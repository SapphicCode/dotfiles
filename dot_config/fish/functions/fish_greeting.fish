function fish_greeting
    if status --is-interactive; and [ "$TERM_PROGRAM" != "vscode" ]; and [ -z "$SSH_CLIENT" ]
        if type -q task
            task next limit:page
        end
    end
end
