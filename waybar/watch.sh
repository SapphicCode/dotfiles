#!/bin/bash
while inotifywait -e close_write config.yml; do
    ./build.sh
done
