#! /bin/bash
#ampac g09.dat
while [ ! -f g09.out ]; do
sleep 10
done
egrep 'HEAT' g09.out
if [ $? -eq 0 ]; then
	awk '/HEAT OF FORMATION/ {ene=$6}END {printf("%12.6f",ene)}' g09.out > eng
	exit 0
else
	echo 'ampac run error, please go back and check'
	exit 1
fi
exit
