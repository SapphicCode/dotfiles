# general utility
if type -q systemctl
    abbr -g -a userctl "systemctl --user"
end

if not type -q docker; and type -q podman
    abbr -g -a docker podman
end

# elevated commands
if type -q doas
    abbr -g -a sudo doas
    abbr -g -a systemctl "doas systemctl"
else
    abbr -g -a systemctl "sudo systemctl"
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
    function _git_primary_branch
        git symbolic-ref refs/remotes/origin/HEAD | string split -r -m1 -f2 '/'
    end

    abbr -g -a ga "git add"
    abbr -g -a gc "git commit"
    abbr -g -a gch "git checkout"
    abbr -g -a gcm 'git checkout $(_git_primary_branch); and git pull'
    abbr -g -a gmm 'git fetch; and git merge origin/$(_git_primary_branch)'
end
