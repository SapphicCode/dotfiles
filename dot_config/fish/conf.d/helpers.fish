if type -q direnv
    direnv hook fish | source
end
if type -q zoxide
    zoxide init fish | source
end
if type -q atuin
    atuin init fish | source
end
