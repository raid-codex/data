#!/bin/bash

if [[ $# -ne 7 ]]
then
    echo "Usage: $0 name slug rarity affinity type faction-slug faction-name"
    exit 1
fi

champion_file="$GOPATH/src/github.com/raid-codex/data/docs/champions/current/$2.json"
echo "{\"name\": \"$1\", \"slug\": \"$2\", \"rarity\": \"$3\", \"type\": \"$5\", \"faction_slug\": \"$6\", \"element\": \"$4\", \"faction\":{\"name\": \"$7\"}}" > $champion_file

raid-codex-cli champions sanitize --champion-file $champion_file --data-directory $GOPATH/src/github.com/raid-codex/data