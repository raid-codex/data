#!/bin/bash

files=$(git diff-tree --name-only --no-commit-id -r HEAD | grep "docs/champions/curr" | grep -v index.json)
for file in $files
do
    echo "Processing $file"
    raid-codex-cli champions page create --champion-file $file --template-folder $GOPATH/src/github.com/raid-codex/tools/templates/champion/ --data-directory $GOPATH/src/github.com/raid-codex/data
done

files=$(git diff-tree --name-only --no-commit-id -r HEAD | grep "docs/status-effects/curr" | grep -v index.json)
for file in $files
do
    echo "Processing $file"
    raid-codex-cli status-effect page create --status-effect-file $file --template-folder $GOPATH/src/github.com/raid-codex/tools/templates/status-effect/ --data-directory $GOPATH/src/github.com/raid-codex/data
done

files=$(git diff-tree --name-only --no-commit-id -r HEAD | grep "docs/factions/curr" | grep -v index.json)
for file in $files
do
    echo "Processing $file"
    raid-codex-cli factions page create --faction-file $file --template-folder $GOPATH/src/github.com/raid-codex/tools/templates/faction/ --data-directory $GOPATH/src/github.com/raid-codex/data
done

# raid-codex-cli website cache clear --cache-token $WP_CACHE_TOKEN

echo "Updated, don't forget to refresh cache"
