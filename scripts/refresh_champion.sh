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
echo "HTML page..."
raid-codex-cli champions page generate --champion-file $GOPATH/src/github.com/raid-codex/data/docs/champions/current/$1.json --data-directory $GOPATH/src/github.com/raid-codex/data --template-folder "$GOPATH/src/github.com/raid-codex/tools/templates/champion" --output-file "$GOPATH/src/github.com/raid-codex/data/generated/champions/$1.html" --no-page
echo "Small index..."
python $curdir/shrink-index.py
echo "OK"