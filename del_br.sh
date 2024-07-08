#!/bin/bash

if [ $# -lt 1 ]; then
  echo "the branch name cannot be empty"
  exit
fi
git co dev
git br|grep feature/TOERP-"$1"|xargs git br -D
