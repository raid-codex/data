#!/bin/bash

exit_code=0

function check()
{
    # just keep stderr
    raid-codex-cli schema validate --schema-file file://`pwd`/schemas/$1 --file file://`pwd`/$2 > /dev/null
    if [[ $? -ne 0 ]]
    then
        echo $2
        echo "------------------"
        exit_code=1
    fi
}

function checkDirectory()
{
    for file in $(ls ${2}/*.json | grep -v index.json)
    do
        check "${1}.json" $file
    done
    check "${1}-index.json" "${2}/index.json"
}

checkDirectory champion ./docs/champions/current
checkDirectory status-effect ./docs/status-effects/current


exit $exit_code