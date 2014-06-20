	subroutine checkcontact(c,n,yes)
	logical yes
	real c(1000),d
	integer n
	do 10 i=1,n
		do 20 j=i+1,n
		d=sqrt((c(3*j-2)-c(3*i-2))**2+
     +		(c(3*j-1)-c(3*i-1))**2+
     +		(c(3*j)-c(3*i))**2)
		if(d.lt.0.8) then
		yes=.true.
		goto 30
		else
		yes=.false.
		endif
20	continue
10	continue
30	continue
	end
