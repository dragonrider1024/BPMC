#! /bin/bash
i=$(awk '/nthisomer/ {print $2}' nisomer.txt)
cp cluster.rst cluster_sv.rst.$i
exit
