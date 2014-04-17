#! /bin/bash
for file in cluster_sv.rst.*
do
echo $file
ext=$(echo "$file"|awk -F . '{print $NF}')
ambpdb -p cluster.prmtop <$file>cluster_$ext.pdb
done
exit
