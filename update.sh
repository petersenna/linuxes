#!/bin/bash
# Peter Senna Tschudin <peter.senna@gmail.com>
# This script clones Linus tree and checkout each main version in a separate folder
#
# Linus tree will be at ../linux


DIR=$PWD
GIT=$PWD/../linux

if [ ! -d $GIT ];then

	# This assumes that the Linux main git is/will be at ../linux
	cd ..

        git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
fi

cd $GIT
git remote update

for tag in $(git tag |cut -d "-" -f 1|sort -u);do
        echo $tag

        if [ -d $DIR/$tag ];then
                echo Skipping $tag...
        else
                echo Getting $tag...

                mkdir -p $DIR/$tag
                git --work-tree=$DIR/$tag checkout $tag -- .
                ret=$?
                if [ $ret != 0 ];then
                        echo Something went wrong for the tag $tag. This may be normal for the last tag...
                        echo Deleting $DIR/$tag
                        rm -rf $DIR/$tag
                fi
        fi
done
