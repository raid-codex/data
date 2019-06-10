#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 [what-to-rebuild]"
    exit 1
fi

raid-codex-cli champions rebuild-index --champions-directory "./docs/$1/current"
