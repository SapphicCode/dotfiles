FROM docker.io/library/alpine:3.18

RUN apk add --no-cache \
    git chezmoi \
    fish starship \
    jq yq ncdu \
    htop \
    helix tree-sitter-grammars

COPY --chown=root:root . /root/.local/share/chezmoi
RUN chezmoi apply

CMD [ "fish" ]
