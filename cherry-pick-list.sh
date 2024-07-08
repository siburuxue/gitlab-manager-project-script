#!/bin/bash
# branch name/jira 通过第一个commitID来确定
# ./cherry-pick-list.sh test xxxx xxxx xxxx
if [ $# -lt 2 ]; then
  echo "the branch name cannot be empty"
  exit
fi

num=0
commit=""
for i in "$@";
do
  num=$((num+1))
  if [ $num -gt 1 ]; then
    commit="$commit $i"
  fi
done

git fetch origin
git checkout dev && git reset --hard origin/dev && git cherry-pick --abort
git checkout test && git reset --hard origin/test && git cherry-pick --abort
git checkout pre && git reset --hard origin/pre && git cherry-pick --abort
git checkout master && git reset --hard origin/master && git cherry-pick --abort

# shellcheck disable=SC2006
branch=`git show $2|grep "TOERP"|HEAD -1|awk -F: '{printf $1}'|awk '$1=$1'`

# shellcheck disable=SC2034
father=$1
git checkout "$father"
git pull --rebase
# shellcheck disable=SC2006
datetime=`date "+%Y%m%d%H%M%S"`
branch_name="${branch}_${datetime}"
git fetch origin "$father":feature/"$branch_name"
git checkout feature/"$branch_name"
git push --set-upstream origin feature/"$branch_name"
git cherry-pick $commit
git push origin HEAD
