#!/bin/bash
# Peter Senna Tschudin <peter.senna@gmail.com>
# This script clones Linus tree and checkout each main version in a separate folder
#

# Where the source code will be
DIR=$PWD/src

# Linus tree
GIT=$PWD/linux

# Folder to save SLOCCount statistics
SLC=$PWD/sloccount

if [ -f $GIT/MAINTAINERS ];then
	git submodule update
else
	git submodule init
	git submodule update
fi

cd $GIT
for tag in $(git tag |cut -d "-" -f 1|sort -u);do
        echo $tag

        if [ -d $DIR/$tag ];then
                echo Skipping $tag...
        else
                echo Getting $tag...

                mkdir -p $DIR/$tag

                git --work-tree=$DIR/$tag checkout $tag -- .
                if [ $? == 0 ];then
			echo Running sloccount for $tag
			sloccount $DIR/$tag > $SLC/$tag
		else
                        echo Something went wrong with $tag. This may be normal for the last tag...
                        echo Deleting $DIR/$tag
                        rm -rf $DIR/$tag
                fi
        fi
done
