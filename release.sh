#!/usr/bin/env bash
set -eux

git remote update
export LATEST=$(git tag -l | sort -V | tail -n1)
echo "version?"
read NEXT
git checkout $LATEST
git fetch origin develop:develop master:master
git checkout master
git merge --no-ff -m "release/$NEXT" develop || return $?
git tag -a $NEXT
git checkout develop
git merge $NEXT -m "release $NEXT"
