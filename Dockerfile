FROM docker.io/library/alpine:latest AS base

RUN echo "@edgec https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache \
    mandoc docs \
    please@testing \
    git chezmoi \
    bash fish nushell@edgec starship \
    uutils@edgec curl jq yq ncdu \
    htop btop \
    neovim micro

RUN echo -e "[please]\nname=^(root|sapphiccode)$\ntarget=.*\nrule=.*\nrequire_pass=false\nsyslog=false" > /etc/please.ini && \
    please whoami

COPY --chown=root:root . /root/.local/share/chezmoi
RUN chezmoi apply -v && \
    test -d "${HOME}/.age"

RUN adduser -D -s /usr/bin/fish sapphiccode
COPY --chown=sapphiccode:sapphiccode . /home/sapphiccode/.local/share/chezmoi
USER sapphiccode
RUN chezmoi apply

CMD [ "fish", "-l" ]

# ---

FROM base AS python

USER root

RUN apk add --no-cache \
    python3 py3-pip py3-requests ipython pipx \
    build-base python3-dev libffi-dev

USER sapphiccode

RUN for pkg in poetry pdm; do pipx install $pkg; done && \
    pip cache purge
