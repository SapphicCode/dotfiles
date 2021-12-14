# general utility
abbr --add userctl "systemctl --user"
if not type -q docker; and type -q podman
    abbr --add docker podman
end
if type -q doas
    abbr --add sudo doas
end

# kubernetes
if not type -q kustomize; and type -q kubectl
    abbr --add kustomize "kubectl kustomize"
end

# git
if type -q git
    abbr --add add "git add"
    abbr --add commit "git commit"
end
