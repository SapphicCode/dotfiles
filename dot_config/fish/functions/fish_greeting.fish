function fish_greeting
    if not status --is-login; and status --is-interactive
        if type -q task; and test -d ~/.task/
            task next limit:page
        end
    end
end
