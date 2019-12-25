#!/bin/bash

set -e

curdir=$(dirname "$0")

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 champion-slug"
    exit 1
fi

echo "Rebuilding champion json"
raid-codex-cli champions sanitize --champion-file $GOPATH/src/github.com/raid-codex/data/docs/champions/current/$1.json --data-directory $GOPATH/src/github.com/raid-codex/data
echo "Rebuilding champions index"
bash $curdir/rebuild_index.sh champions
python $curdir/shrink-index.py
echo "OK"