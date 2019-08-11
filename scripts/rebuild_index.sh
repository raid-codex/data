#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 [what-to-rebuild]"
    exit 1
fi

case $1 in
    "champions")
        cmd_line="--champions-directory ./docs/$1/current"
        cmd=$1
        ;;
    "status-effects")
        cmd_line="--status-effect-directory ./docs/$1/current"
        cmd="status-effect"
        ;;
    "factions")
        cmd_line="--factions-directory ./docs/$1/current"
        cmd=$1
        ;;
    "fusions")
        cmd_line="--fusion-directory ./docs/$1/current"
        cmd=$1
        ;;
    esac
    raid-codex-cli $cmd rebuild-index $cmd_line
