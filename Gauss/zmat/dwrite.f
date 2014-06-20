	subroutine dwrite
	include 'common'
	real v(100)
	integer n,iostatus,i,ch,multi,bl(100),al(100),dl(100),cl(100)
	character*3 atom(100),bs(100),as(100),ds(100),sym(100)
	open (unit=6,file='g09.com')
	write (6,*)'%chk=g09.chk'
	write (6,*)'#p am1'
	write (6,*)' '
	write (6,*)'g09 mcmc'
	write (6,*)' '
	write (6,*) ch,multi
	do 10 i=1,n
	if (i.eq.1) then
	write (6,*) atom(i)
	else if (i.eq.2) then
	write (6,*) atom(i),bl(i-1),bs(i-1)
	else if (i.eq.3) then
	write (6,*) atom(i),bl(i-1),bs(i-1),al(i-2),as(i-2)
	else
	write (6,*) atom(i),bl(i-1),bs(i-1),al(i-2),as(i-2),
     +	dl(i-3),ds(i-3),cl(i-3)
	endif
10	continue
	write (6,*)' '
	do 20 i=1,3*n-6
	write (6,*) sym(i),v(i)
20	continue
	write (6,*) ' '
	close (6)
100	format(A2,10X,f10.7,4X,f10.7,4X,f10.7)
	end
