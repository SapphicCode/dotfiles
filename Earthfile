VERSION 0.7

FROM docker.io/library/alpine:3.18
RUN apk add git
WORKDIR /work
COPY . .
ARG --global git_rev=$(git rev-parse --short HEAD)

all:
    BUILD +test
    BUILD +all-cloud-shell

pre-commit:
    BUILD +test

format:
    FROM docker.io/library/node:alpine
    COPY . /work
    RUN npm install -g prettier
    RUN prettier -w '/work/**/*.yml'

test:
    RUN apk add chezmoi
    RUN chezmoi init . --dry-run --verbose

all-cloud-shell:
    WAIT
        BUILD --platform=linux/amd64 --platform=linux/arm64 +cloud-shell
    END
    BUILD --platform=linux/amd64 --platform=linux/arm64 +cloud-shell-python

cloud-shell:
    FROM DOCKERFILE -f .cloud-shell/Dockerfile .
    SAVE IMAGE --push quay.io/sapphiccode/cloud-shell:latest quay.io/sapphiccode/cloud-shell:g$git_rev

cloud-shell-python:
    FROM DOCKERFILE -f .cloud-shell/Dockerfile.python .
    SAVE IMAGE --push quay.io/sapphiccode/cloud-shell:latest-python quay.io/sapphiccode/cloud-shell:g$git_rev-python
