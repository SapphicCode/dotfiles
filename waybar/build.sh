#!/bin/bash
if yq . config.yml &> /dev/null; then
    yq . config.yml > config
fi
