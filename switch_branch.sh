#!/bin/bash
if [ $# -lt 1 ]; then
  echo "the branch name cannot be empty"
  exit
fi
branch=${1/feature\//}
branch=${branch/TOERP-/}
git co feature/TOERP-$branch
