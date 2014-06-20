#! /bin/bash
egrep 'Normal' g09.log
if [ $? -eq 0 ]; then
	awk 'BEGIN {ene=0}
	/SCF Done/ {ene=$5}
	END {printf("%12.6f\n",ene)}' g09.log > eng
	exit 0
else
	echo 'gaussian software running error, please go back and check'
	exit 1
fi
exit
