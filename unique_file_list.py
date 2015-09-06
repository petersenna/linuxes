#!/usr/bin/python
# Peter Senna Tschudin <peter.senna@gmail.com>

"""Creates a text file containing a list of unique files with all the
files with same content."""

import subprocess

source_dir=r"./src/"
separator="|"

if __name__ == "__main__":

    find_command = "find . -type f -printf %i" + separator + "%p\\n"
    process = subprocess.Popen(find_command.split(), cwd=source_dir, stdout=subprocess.PIPE)
    output = process.communicate()[0]
    odict = {}
    for line in output.split("\n"):
        if not line:
            continue

        inode,file = line.split("|")
        if inode in odict:
            odict[inode] = odict[inode] + separator + file
        else:
            odict[inode] = file

    for value in odict.values():
        print value
