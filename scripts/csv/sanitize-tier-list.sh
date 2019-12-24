#!/bin/bash

cat $1 | \
    sed "s/Ma´Shalled/Ma'Shalled/g" | \
    sed "s/Big´Un/Big'Un/g" | \
    sed "s/Bonekepper/Bonekeeper/g" | \
    sed "s/Skartosis/Skartorsis/g" | \
    sed "s/Support/Assist/g" | \
    sed "s/Drexthar Bloodtwin,Legendary,Force,Def/Drexthar Bloodtwin,Legendary,Force,HP/g" | \
    sed "s/Armantine Skeleton/Amarantine Skeleton/g" | \
    sponge $1