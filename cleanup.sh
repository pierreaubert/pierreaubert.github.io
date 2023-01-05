#!/bin/bash

REPO=$(git config --get remote.origin.url)

rm -fr ../backup.git
mv .git ../backup.git
echo "Cleaning repository: $REPO"

#recreate the repos from the current content only
git init
git branch -m master
git add -A .

git commit -m "Last generated files from https://github.com/pierreaubert/spinorama"

#push to the github remote repos ensuring you overwrite history
git remote add origin $REPO
git push -u --force origin master
