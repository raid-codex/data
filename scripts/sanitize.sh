#!/bin/bash

set -e

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 [what-to-sanitize]"
    exit 1
fi

data_directory="${GOPATH}/src/github.com/raid-codex/data"
cmd_line=""
cmd=$1
case $1 in
"champions")
    cmd_line=" --data-directory ${data_directory} --champion-file"
    cmd=$1
    ;;
"status-effects")
    cmd_line="--status-effect-file"
    cmd="status-effect"
    ;;
"factions")
    cmd_line="--data-directory ${data_directory} --faction-file"
    cmd=$1
    ;;
"fusions")
    cmd_line=" --data-directory ${data_directory} --fusion-file"
    cmd=$1
    ;;
esac
parallel -j 10 raid-codex-cli $cmd sanitize $cmd_line -- `ls ./docs/$1/current/*.json | grep -v index.json`
