#! /bin/bash
egrep 'Normal' g09.log
if [ $? -eq 0 ]; then
	awk '/SCF Done/ {print $5}' g09.log > eng
	exit 0
else
	echo 'gaussian software running error, please go back and check'
	exit 1
fi
exit
