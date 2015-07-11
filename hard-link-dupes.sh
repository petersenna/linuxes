#!/bin/bash
# Peter Senna Tschudin <peter.senna@gmail.com>
#
# USING THIS SCRIPT IS A BAD IDEA IF YOU PLAN TO EDIT THE SOURCE CODE
#
# This script can save 10GB+ of disk space by replacing 1.5M+
# duplicated files with hard links. This would be dangerous without
# git, as changing one of the files that are hard linked will affect
# all others. But git status will show you when this happens and it
# is easy to fix the mess.

# Where the source code will be
DIR=$PWD/src

# Linus tree
GIT=$PWD/linux

# rdfind is probably available on your software repository
rdfind -makehardlinks true .

# This is a text file created by rdfind, thanks to git
# it is not that important...
rm -f results.txt

# This is needed as some scripts and text files has different
# permissions on different versions
git checkout -- .

cd $GIT
git checkout -- .
