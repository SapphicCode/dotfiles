if type -q direnv
    direnv hook fish | source
end
if type -q zoxide
    zoxide init fish | source
end
if type -q atuin; and not begin
        # atuin and ZFS (more specifically, SQLite) do not play nice, disable it
        type -q findmnt; and findmnt --target $HOME | grep -q zfs; and type -q zfs
    end

    atuin init fish | source
end
