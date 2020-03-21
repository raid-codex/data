#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 [what-to-rebuild]"
    exit 1
fi

function get_md5 {
    if [[ $(which md5sum) ]]
    then
        cat $1 | md5sum
    else
        cat $1 | md5
    fi
}

md5file=$(get_md5 ./docs/$1/current/index.json)

case $1 in
    "champions")
        cmd_line="--champions-directory ./docs/$1/current"
        cmd=$1
        ;;
    "status-effects")
        cmd_line="--status-effects-directory ./docs/$1/current"
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

if [[ "$1" = "champions" ]]
then
    newmd5=$(get_md5 ./docs/$1/current/index.json)
    if [[ "$newmd5" != "$md5file" ]]
    then
        python3 scripts/shrink-index.py
    fi
fi