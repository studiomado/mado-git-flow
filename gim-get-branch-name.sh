#!/bin/bash
taskId="$1"
if [[ -z "$taskId" ]]; then
    printf "task id: "
    read -r taskId
    printf "nome $1: "
    read -r name
    newName="${name// /-}"
fi
if [[ "$taskId" != "" ]]; then
    branchName="#$taskId-$newName"
else
    branchName="$newName"
fi
echo "$branchName"
