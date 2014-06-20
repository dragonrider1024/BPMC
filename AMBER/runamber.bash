#! /bin/bash
while [ 1 -eq 1 ]
do
sander -O -i mini.in -o mini.out -p cluster.prmtop -c cluster.prmcrd -r cluster.rst
egrep 'Run   done' mini.out
if [ $? -eq 0 ];then
awk 'BEGIN {ene=0}
     /NSTEP/{getline;ene=$2}
     END {printf("%12.6f",ene)}' mini.out >eng
exit 0
break
else
echo 'sander minimization/energy calculation wrong'
cp cluster.rst cluster.prmcrd
#exit 1
fi
done
exit
