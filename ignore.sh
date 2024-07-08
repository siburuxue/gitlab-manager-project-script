#!/bin/bash
if [ $# -lt 1 ]; then
  echo "the file name cannot be empty"
  exit
fi
echo "$1" >> ../.git/info/exclude
