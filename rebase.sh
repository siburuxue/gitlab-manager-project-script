#!/bin/bash
git fetch origin
if [ $# -lt 1 ]; then
  # shellcheck disable=SC2006
  branch=`git st|grep "On branch "|awk -F" " '{printf $3}'`
  git rebase origin/$branch
else
  git rebase origin/$1
fi