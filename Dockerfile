FROM docker.io/library/alpine:3.18

RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache \
    mandoc docs \
    please@testing \
    git chezmoi \
    fish starship \
    jq yq ncdu \
    btop \
    neovim

RUN echo -e "[please]\nname=^(root|sapphiccode)$\ntarget=.*\nrule=.*\nrequire_pass=false\nsyslog=false" > /etc/please.ini && \
    please whoami

COPY --chown=root:root . /root/.local/share/chezmoi
RUN chezmoi apply -v && \
    test -d "${HOME}/.age"

RUN adduser -D -s /usr/bin/fish sapphiccode
COPY --chown=sapphiccode:sapphiccode . /home/sapphiccode/.local/share/chezmoi
USER sapphiccode
RUN chezmoi apply

CMD [ "fish" ]
