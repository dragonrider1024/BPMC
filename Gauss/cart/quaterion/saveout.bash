#! /bin/bash
i=$(awk '/nthisomer/ {print $2}' nisomer.txt)
cp g09.log_copy g09_$i.log
exit
