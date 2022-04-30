function fish_greeting
    if status --is-interactive; and [ "$TERM_PROGRAM" != "vscode" ]
        if type -q task; and test -d ~/.task/
            if [ (date '+%u') -lt 6 ]
                task next limit:page
            else
                task next limit:page project.not:Work
            end
        end
    end
end
