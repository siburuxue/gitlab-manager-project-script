#!/bin/bash
# shellcheck disable=SC2006
branch=`git st|grep "On branch"|awk -F" " '{printf $3}'`
git co dev
/bin/bash ./rebase.sh
git co pre
/bin/bash ./rebase.sh
git co test
/bin/bash ./rebase.sh
git co master
/bin/bash ./rebase.sh
git co "$branch"

