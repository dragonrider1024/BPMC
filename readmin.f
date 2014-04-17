	subroutine readmin(cmin,n)
	real cmin(1000)
	integer n,iostatus
	character*3 u
	open (unit=12,file="cluster.rst",status='old')
	read (12,*,iostat=iostatus) u
!	unit symbol
	if(iostatus.gt.0) then
	print *,"there is something wrong"
	goto 10
	else if(iostatus.lt.0) then
!	print *,"reached end-of-file"
	goto 20
	else
	read (12,*,iostat=iostatus) n
!	read total number of atoms
	do 30 i=1,(n-1)/2+1
	read (12,*,iostat=iostatus) cmin(6*i-5),cmin(6*i-4),cmin(6*i-3),
     +	cmin(6*i-2),cmin(6*i-1),cmin(6*i)
!	read coordinates
30	continue
	if(mod(n,2).ne.0) then
	read (12,*,iostat=iostatus) cmin(3*n-2),cmin(3*n-1),cmin(3*n)
	else
	endif
!	read (12,*,iostat=iostatus) la,lb,lc,aa,ab,ac
!	read lattice parameter
	endif
20	continue
	close (12)
10	continue
	end
