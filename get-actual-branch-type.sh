#!/bin/bash
actualBranchType=$(git branch | grep \* | cut -d ' ' -f2 | cut -d '/' -f1)
echo "$actualBranchType"