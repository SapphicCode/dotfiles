function fish_greeting
    if status --is-interactive; and [ "$TERM_PROGRAM" != "vscode" ]; and [ -z "$SSH_CLIENT" ]
        if type -q task; and test -d ~/.task/
            if type -q timew; and timew :quiet
                task next limit:page -major
            else
                task next limit:page project.not:Work -major
            end
        end
    end
end
