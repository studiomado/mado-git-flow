#!/bin/bash

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]  || [[ -z "$1" ]]; then
    echo
    echo -e "\t\033[32m""feature:\033[33m"" crea un branch feature\033[0m"
    echo -e "\t\033[32m""hotfix:\033[33m"" crea un branch di hotfix\033[0m"
    echo -e "\t\033[32m""bugfix:\033[33m"" crea un branch di bugfix\033[0m"
    echo -e "\t\033[32m""release:\033[33m"" crea un branch di release\033[0m"
    echo -e "\t\033[32m""commit:\033[33m"" committa tutte le modifiche\033[0m"
    echo -e "\t\033[32m""finish:\033[33m"" mergia ed elimina il branch\033[0m"
    echo -e "\t\033[32m""published:\033[33m"" pusha il branch in remoto\033[0m"
    echo -e "\t\033[32m""delete:\033[33m"" elimina branch corrente\033[0m"
    echo -e "\t\033[32m""deleteRemoteBranch:\033[33m"" tool pulizia branch remoti\033[0m"
    echo -e "\t\033[32m""deleteLocalBranch:\033[33m"" tool pulizia branch locali\033[0m"
    echo
    exit
fi
actualBranch=$(git branch | grep \* | cut -d ' ' -f2)
actualBranchType=$(git branch | grep \* | cut -d ' ' -f2 | cut -d '/' -f1)
branchName=$(git branch | grep \* | cut -d ' ' -f2 | cut -d '/' -f2)

major=$(git describe --tags `git rev-list --tags --max-count=1` | cut -d '.' -f1)
major="${major//v/}"
minor=$(git describe --tags `git rev-list --tags --max-count=1` | cut -d '.' -f2)
patch=$(git describe --tags `git rev-list --tags --max-count=1` | cut -d '.' -f3)

if [[ -z "$major" ]]; then
    major=1
fi
if [[ -z "$minor" ]]; then
    minor=0
fi
if [[ -z "$patch" ]]; then
    patch=0
fi

prev=""
consoleTaskId="0"
releaseMajor="0"
pullRequest="0"

if [[ "$1" == "init" ]]; then
    git flow init -d
fi

for var in "$@"
do
    if [[ "$prev" == "-t" ]]; then
        consoleTaskId="$var"
    fi
    if [[ "$var" == "-m" ]]; then
        releaseMajor="1"
    fi
    prev="$var"
done
# create feature or hotfix branch
if [[ "$1" == "feature" ]] || [[ "$1" == "bugfix" ]]
then
    if [[ "$consoleTaskId" == "0" ]]; then
        printf "task id: "
        read -r taskId
        printf "nome $1: "
        read -r name
        newName="${name// /-}"
    else
        taskId="$consoleTaskId"
    fi
    if [[ "$taskId" != "" ]]; then
        branchName="#$taskId-$newName"
    else
        branchName="$newName"
    fi
    git flow "$1" start "$branchName"
fi

if [[ "$1" == "hotfix" ]]
then
    git flow "$1" start "v$major"."$minor"."$((patch + 1))"
fi

if [[ "$1" == "release" ]]
then
    releaseName="v$major"."$((minor +1))".0
    if [[ "$releaseMajor" == "1" ]]; then
        releaseName="v$((major + 1))".0.0
    fi
    git flow release start "$releaseName"
fi

if [[ "$1" == "finish" ]] || [[ "$1" == "publish" ]]; then
    git flow "$actualBranchType" "$1" "$branchName"
fi

if [[ "$1" == "delete" ]]; then
    git flow delete
fi

# menage commit
if [[ "$1" == "commit" ]]
then
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
fi

# menage delete remote branch
if [[ "$1" == "deleteRemoteBranch" ]]
then
    list=($(git branch -r))
    for branch in "${list[@]}"; do
        echo "delete $branch? [y/N]"
        read -r canBeDeleted
        if [[ "$canBeDeleted" == "y" ]]; then
            branchToDelete="${branch//origin\//}"
            git push -d origin "$branchToDelete"
            echo "$branchToDelete deleted"
            echo ""
            echo ""
        fi
    done
fi

# menage delete local branch
if [[ "$1" == "deleteLocalBranch" ]]
then
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
fi
