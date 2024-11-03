#!/usr/bin/env bash

if type -p starship &> /dev/null; then
    starship init nu > $HOME/.cache/starship.nu
else
    echo "" > $HOME/.cache/starship.nu
fi
