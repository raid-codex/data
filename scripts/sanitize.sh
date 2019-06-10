#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 [what-to-sanitize]"
    exit 1
fi

base_path="./docs/$1/current/"

for file in $(ls ./docs/$1/current/ | grep -v index.json)
do
    raid-codex-cli champions sanitize --champion-file "${base_path}${file}"
done
