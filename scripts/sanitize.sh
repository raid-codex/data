#!/bin/bash

set -e

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 [what-to-sanitize]"
    exit 1
fi

base_path="./docs/$1/current/"

data_directory="${GOPATH}/src/github.com/raid-codex/data"
for file in $(ls ./docs/$1/current/ | grep -v index.json)
do
    fullpath_file="${base_path}${file}"
    case $1 in
    "champions")
        cmd_line="--champion-file ${fullpath_file} --data-directory ${data_directory}"
        ;;
    "status-effects")
        cmd_line="--status-effect-file ${fullpath_file}"
        ;;
    "factions")
        cmd_line="--faction-file ${fullpath_file}"
        ;;
    esac
    raid-codex-cli $1 sanitize $cmd_line
done
