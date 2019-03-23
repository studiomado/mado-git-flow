#!/bin/bash
actualBranchType="$1"
branchName="$2"

start="fix"
if [[ "$actualBranchType" == "feature" ]]; then
    start="feat"
elif [[ "$actualBranchType" == "release" ]]; then
    start="release"
fi
printf "tipo di commit attuale: $start, mantenere?[Y/n] "
read -r accept
if [[ "$accept" == "n" ]]; then
    printf "specifica tipo di commit: "
    read -r start
fi
printf "task: "
read -r taskId
task=""
if [[ ! -z "$taskId" ]]; then
    task="(#$taskId)"
fi
printf "ambito $actualBranchType (1 parola): "
read -r zone
title="${branchName//-/ }"
echo "descrizione $actualBranchType:"
read -r description
git add -A
git commit -m "$start($zone): $title $task" -m "$description"
