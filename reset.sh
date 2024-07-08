#!/bin/bash

git fetch origin
git checkout dev && git reset --hard origin/dev && git cherry-pick --abort
git checkout test && git reset --hard origin/test && git cherry-pick --abort
git checkout pre && git reset --hard origin/pre && git cherry-pick --abort
git checkout master && git reset --hard origin/master && git cherry-pick --abort