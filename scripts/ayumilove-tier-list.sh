#!/bin/bash
set -e

for slug in $(python -c 'import sys, json; r = json.load(sys.stdin); print(" ".join([d["slug"] for d in r]));' < ./docs/champions/current/index.json)
do
    echo "doing $slug"
    raid-codex-cli scrap ayumilove champions --champion-slug $slug --data-directory . --with-ratings || true
done
make sanitize_champions
make rebuild_index_champions