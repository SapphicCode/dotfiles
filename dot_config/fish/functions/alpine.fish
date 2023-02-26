function alpine --wraps='podman run --rm -it docker.io/library/alpine:3.17' --description 'alias alpine podman run --rm -it docker.io/library/alpine:3.17'
  podman run --rm -it docker.io/library/alpine:3.17 $argv
        
end
