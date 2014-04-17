	subroutine mvpos
	include 'common'
	real c(1000),la,lb,lc,aa,ab,ac,co
	integer n,iostatus,pos,k,j
	character*3 u
	logical yes
!	call random_seed(seed)
10	continue
	call random_number(r)
	pos=int(r*(3*n-6))+1
	k=int(pos/3)+1
	call random_number(r)
	co=c(pos)
	c(pos)=c(pos)+(r-0.5)*2.0
	call checkcontact(c,n,yes)
	if(yes.eq..true.) then
	c(pos)=co
	goto 10
	else
	endif
	end
