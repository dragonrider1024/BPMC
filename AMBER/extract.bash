#!/bin/bash
for file in mcmc.txt
do
echo $file
awk 'BEGIN {i=1;e1=100.0}
     /0/ {ene=$1;
          if(ene<e1)
          {printf("%6d      %12.6f\n",i,ene);
           e1=ene;
           i=i+1;
           }
          }'  $file
done
exit
