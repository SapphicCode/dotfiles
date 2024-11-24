#!/usr/bin/env bash

set -euo pipefail

file="$HOME/.config/git/attributes"
rm -rf "$file"
touch "$file"

if type mergiraf &> /dev/null; then
    mergiraf languages --gitattributes >> "$file"
fi
