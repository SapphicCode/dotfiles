if status is-interactive
    if type -q starship
        eval (starship init fish)
    end

    function _jj_check --on-variable PWD
        if type -q jj; and jj root --ignore-working-copy &>/dev/null
            set -gx STARSHIP_CONFIG "$HOME/.config/starship-jj.toml"
        else
            set -e STARSHIP_CONFIG
        end
    end

    _jj_check
end
