#! /bin/bash
i=$(awk '/nthisomer/ {print $2}' nisomer.txt)
cp g09.out_copy g09_$i.out
exit
