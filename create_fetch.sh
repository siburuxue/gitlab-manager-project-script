#!/bin/bash
git co dev
/bin/bash ./rebase.sh
if [ $# -lt 1 ]; then
  echo "the branch name cannot be empty"
  exit
fi
git fetch origin dev:feature/$1
git checkout feature/$1
git push --set-upstream origin feature/$1