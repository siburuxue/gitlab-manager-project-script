#!/bin/bash

if [ $# -lt 1 ]; then
  echo "the branch name cannot be empty"
  exit
fi


/bin/bash reset.sh
/bin/bash all_rebase.sh

git co master
git pull --rebase
branch=${1/feature\//}
# shellcheck disable=SC2006
datetime=`date "+%Y%m%d%H%M%S"`
branch_name="${branch}_${datetime}"
git fetch origin master:feature/"$branch_name"
git checkout feature/"$branch_name"
git push --set-upstream origin feature/"$branch_name"
git log origin/pre --oneline --reverse --grep="$branch" | awk 'BEGIN{printf " "} {printf $1" "}' | xargs git cherry-pick
git push origin HEAD
