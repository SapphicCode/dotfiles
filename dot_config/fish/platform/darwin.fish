# CLI application launchers
for app in IINA.app iTerm.app
    set -l app_safe (string match --regex '[a-zA-Z]+' $app | string lower)
    if test -d /Applications/$app; or test -d $HOME/Applications/$app
        alias $app_safe "open -a $app"
    end
end
