	subroutine dread
	include 'common'
	real c(1000),la,lb,lc,aa,ab,ac
	integer n,iostatus,k
	character*3 u
	open (unit=5,file="cluster.prmcrd",status='old')
	read (5,*,iostat=iostatus) u
!	unit symbol
	if(iostatus.gt.0) then
	print *,"there is something wrong"
	goto 10
	else if(iostatus.lt.0) then
!	print *,"reached end-of-file"
	goto 20
	else
	read (5,*,iostat=iostatus) n
!	read total number of atoms
	do 30 i=1,(n-1)/2+1
	read (5,*,iostat=iostatus) c(6*i-5),c(6*i-4),c(6*i-3),
     +	c(6*i-2),c(6*i-1),c(6*i)
!	read coordinates
30	continue
	if(mod(n,2).ne.0) then
	read (5,*,iostat=iostatus) c(3*n-2),c(3*n-1),c(3*n)
	else
	endif
	read (5,*,iostat=iostatus) la,lb,lc,aa,ab,ac
!	read lattice parameter
	endif
20	continue
	close (5)
10	continue
	end
