	subroutine dwrite
	include 'common'
	real c(1000),la,lb,lc,aa,ab,ac
	integer n,iostatus
	character*3 u
	open (unit=7,file='cluster.prmcrd')
	write (7,300) u
	write (7,400) n
	do 10 i=1,n/2
	write (7,100) c(6*i-5),c(6*i-4),c(6*i-3),
     +	c(6*i-2),c(6*i-1),c(6*i)
10	continue
	if(mod(n,2).ne.0) then
	write (7,200) c(3*n-2),c(3*n-1),c(3*n)
	else
	endif
	write (7,100), la,lb,lc,aa,ab,ac
	close (7)
100	format(6(f12.7))
200	format(3(f12.7))
300	format(A3)
400	format(I6)
	end
