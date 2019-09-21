#!/bin/bash

dir="$GOPATH/src/github.com/raid-codex/data"

for slug in $(cat "$dir/docs/champions/current/index.json" | jq -r '.[].slug')
do
    raid-codex-cli champions page generate --champion-file "$dir/docs/champions/current/$slug.json" --data-directory . --template-folder "$GOPATH/src/github.com/raid-codex/tools/templates/champion" --output-file "$dir/generated/champions/$slug.html" --no-page
done