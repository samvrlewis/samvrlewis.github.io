#!/bin/bash

#report to console
set -e

#make the website
pelican  content -o output -s pelicanconf.py

#clean old master dir
rm -rf master

git clone https://${GH_TOKEN}@github.com/samvrlewis/samvrlewis.github.io.git master

#copy to master
cp -R output/* master

cd master
git config user.email "sam.vr.lewis@gmail.com"
git config user.name "Sam Lewis"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"

#hide the output so token isn't leaked
git push origin master
