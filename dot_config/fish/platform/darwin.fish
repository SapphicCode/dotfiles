# CLI application launchers
if type -q fd
    for app in (fd --max-depth 2 -t directory '\.app$' /Applications ~/Applications)
        set -l app_safe (string replace -a " " "" (basename $app))
        alias $app_safe "open -a '$app'"
    end
end
