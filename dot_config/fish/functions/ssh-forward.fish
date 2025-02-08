function ssh-forward --description "forwards a specific port from a remote to local"
    if test (count $argv) -lt 2
        echo "Usage: ssh-forward HOST PORT..." >&2
        return 1
    end

    set -f host $argv[1]
    set -f ports
    for port in $argv[2..]
        set -a ports -L "$port:127.0.0.1:$port"
    end
    ssh -vN $ports "$host"
end
