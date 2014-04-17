#! /bin/bash
echo please give the reagent ion mass in amu
read amu
echo please give the temperature in Kelvin
read Temp
#echo $rmass,$T
echo species,reduced mass,alpha,ud,ud/sqrtalpha,C,k
for file in *.log; do
filename=${file%.log}
echo -n "$filename"
awk -v rmass="$amu" -v T="$Temp" '/Exact/ {Exaver=($3+$5+$8)/3.0}
     /Approx/ {Appaver=($3+$5+$8)/3.0; alpha=(Appaver+Exaver)/2.0*0.529117**3}
    /Molecular mass/ {mass=$3;u=mass*rmass/(mass+rmass)}
    /X=/&&/Y=/&&/Z=/&&/Tot=/ {dipole=$8}
END {case=dipole/sqrt(alpha)
     if(case<0.082)
     C=0.0
     else
     { if( case<0.163)
       C=0.02
       else
       {if (case<0.250)
         C=0.045
        else
         {if (case<0.327)
          C=0.084
          else
           {if(case<0.408)
            C=0.115
            else
            { if(case<0.490)
              C=0.137
              else
              { if(case<0.572)
                C=0.156
                else
                 {if(case<0.653)
                  C=0.172
                  else
                   {if(case<0.735)
                    C=0.185
                    else
                     if(case<0.817)
                      C=0.196
                      else
                       {if(case<0.898)
                         C=0.205
                        else
                         { if(case<0.980)
                          C=0.213
                           else
                           {if(case<1.061)
                            C=0.220
                            else
                             {if(case<1.143)
                            C=0.226
                              else
                            C=0.231
                             }
                           }
                         }
                        }
                       }
                     }
              }
             }
           }
          }
         }
        }
q=1.602176487E-19*0.1*29979245800
pi=3.14159
k=2*pi*q/sqrt(u/6.0221415E23)*(sqrt(alpha*1E-24)+C*dipole*1E-18*sqrt(2/(pi*1.3806503E-16*T)))/(1E-9)
printf("%12.6f%12.6f%12.6f%12.6f%12.6f%12.2f\n",u,alpha,dipole,dipole/sqrt(alpha),C,k)}' $file
done
#k is in unit of 1E-9 cm3/(moleclue*sec)
