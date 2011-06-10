#!/usr/bin/env python3

import datetime
import os
import sys

memoirDir = os.path.expanduser("~/.memoir/")
memoirFile = memoirDir + "today"
timeFormat = "%a %b  %d %H:%M:%S %Y"
fileTimeFormat = "%Y-%m-%d"

if not os.path.exists(memoirDir):
    os.mkdir(memoirDir)

# add the current local time to the entry header
lines = [ datetime.datetime.now().strftime(timeFormat) + '\n']

if len(sys.argv) > 1:
    lines.append(' '.join(sys.argv[ 1: ]))
    lines[-1] += '\n'
else:
    while 1:
        line = input()

        # get more user input until an empty line
        if len(line) == 0:
            break
        else:
            lines.append('    ' + line + '\n')


# only write the entry if the user entered something
if len(lines) > 1:
    fRead = open(memoirFile, 'r')
    strDate = fRead.readline()
    dtDate = datetime.datetime.strptime(strDate.replace("\n", ""), timeFormat)
    fRead.close()

    if dtDate.day != datetime.datetime.now().day:
        os.rename(memoirFile, memoirDir + "memoir-" + dtDate.strftime(fileTimeFormat))
    else:
        lines.insert(0, '--------------------\n')

    with open(memoirFile, 'a') as f:
        f.writelines(lines)
