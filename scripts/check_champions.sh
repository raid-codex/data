#!/bin/bash

exit_code=0

function check()
{
    # just keep stderr
    raid-codex-cli champions schema validate --schema-file file://`pwd`/schemas/$1 --champion-file file://`pwd`/$2 > /dev/null
    if [[ $? -ne 0 ]]
    then
        echo $2
        echo "------------------"
        exit_code=1
    fi
}

for file in $(ls ./export/current/*.json | grep -v index.json)
do
    check champion.json $file
done

check champion-index.json "./export/current/index.json"

exit $exit_code