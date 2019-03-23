#!/bin/bash
list=($(git branch | grep -v '*'))
for branch in "${list[@]}"; do
    echo "delete $branch? [y/N]"
    read -r canBeDeleted
    if [[ "$canBeDeleted" == "y" ]]; then
        git branch -D "$branch"
        echo "$branch deleted"
        echo ""
        echo ""
    fi
done
