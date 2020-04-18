#!/bin/bash

set -e

curdir=$(dirname "$0")

if [[ $# -ne 3 ]]
then
    echo "Usage: $0 champion-slug author video-id"
    exit 1
fi

raid-codex-cli champions video add --source youtube --author $2 --video-id $3 --champion-slug $1 --data-directory $GOPATH/src/github.com/raid-codex/data
raid-codex-cli champions sanitize --champion-file $file --data-directory $GOPATH/src/github.com/raid-codex/data
echo "Rebuilding champions index"
make rebuild_champions_index
echo "OK"