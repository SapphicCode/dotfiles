function alpine --wraps='docker run --rm -it quay.io/sapphiccode/alpine-cicd:latest'
    set -f runtime podman
    if type -q docker && [ (docker context show 2> /dev/null) = orbstack ]
        set -f runtime docker
    end
    $runtime run --rm -it $argv quay.io/sapphiccode/alpine-cicd:latest
end
