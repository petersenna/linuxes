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

mod_file_count=$(git status |grep "modified: "|wc -l)
if [ $mod_file_count -gt 0 ];then
	echo Git is not clean, there are changes to clean or commit
	echo Fix that and run me again
	exit
fi

# rdfind is probably available on your software repository
cd $DIR
rdfind -makehardlinks true .

# This is a text file created by rdfind, thanks to git
# it is not that important...
rm -f results.txt

# This is needed as some scripts and text files has different
# permissions on different versions
echo Fixing minor issues caused by hard linking dupes...
for file in $(git status |grep modified|grep "src/v"|tr -s " "|cut -d " " -f 2);do
	echo $file
	git checkout -- $file
done
cd ..
