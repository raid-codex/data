#!/bin/bash

set -e

curdir=$(dirname "$0")

if [[ $# -ne 2 ]]
then
    echo "Usage: $0 champion-slug tag"
    exit 1
fi

file="$GOPATH/src/github.com/raid-codex/data/docs/champions/current/$1.json"
jq ".tags += [\"$2\"]" $file | sponge $file
echo "Rebuilding champion json"
raid-codex-cli champions sanitize --champion-file $file --data-directory $GOPATH/src/github.com/raid-codex/data
echo "Rebuilding champions index"
bash $curdir/rebuild_index.sh champions
python $curdir/shrink-index.py
echo "OK"