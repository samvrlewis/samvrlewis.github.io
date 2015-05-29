#!bin/bash

#report to console
set -e

#make the website
pelican  content -o output -s pelicanconf.py

git clone https://${GH_TOKEN}@github.com/samvrlewis/samvrlewis.github.io.git master

#clean old master dir
rm -rf master

#copy to master
cp -R output/* master

cd master
git config user.email "sam.vr.lewis@gmail.com"
git config user.name "Sam Lewis"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"

#hide the output so token isn't leaked
git push --quiet origin master > dev/null 2>&1