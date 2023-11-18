# general utility
if type -q systemctl
    abbr -g -a userctl "systemctl --user"
end

if not type -q docker; and type -q podman
    abbr -g -a docker podman
end

# elevated commands
if [$(id -u) = 0]
    if type -q systemctl
        abbr -g -a systemctl "\$sudo systemctl"
    end
    if type -q zfs
        abbr -g -a zfs "\$sudo zfs"
        abbr -g -a zpool "\$sudo zpool"
    end
end

# rm -> trash
if type -q trash
    abbr -g -a rm trash
end
abbr -g -a rma rm

# kubernetes
if not type -q kustomize; and type -q kubectl
    abbr -g -a kustomize "kubectl kustomize"
end

# git
if type -q git
    function _git_main
        git rev-parse --abbrev-ref origin/HEAD | string split -r -m1 -f2 '/'
    end

    abbr -g -a ga "git add"
    abbr -g -a gc "git commit"
    abbr -g -a gca "git commit --amend"
    abbr -g -a gcan "git commit --amend --no-edit"
    abbr -g -a gch "git checkout"
    abbr -g -a gcm 'git checkout $(_git_main); and git pull'
    abbr -g -a gmm 'git fetch; and git merge origin/HEAD'
    abbr -g -a gp "git push"
    abbr -g -a gpf "git push --force"
end
