#!/bin/bash

set -e

curdir=$(dirname "$0")

if [[ $# -ne 3 ]]
then
    echo "Usage: $0 champion-slug author video-id"
    exit 1
fi

file="$GOPATH/src/github.com/raid-codex/data/docs/champions/current/$1.json"
jq ".videos[.videos | length] |= {\"source\":\"youtube\",\"id\":\"$3\",\"author\":\"$2\"}" $file | sponge $file
echo "Rebuilding champion json"
raid-codex-cli champions sanitize --champion-file $file --data-directory $GOPATH/src/github.com/raid-codex/data
echo "Rebuilding champions index"
bash $curdir/rebuild_index.sh champions
echo "OK"