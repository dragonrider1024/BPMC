	subroutine dwrite
	include 'common'
	real x(100),y(100),z(100)
	character*2 atom(100)
	integer N
!	print *,atom(1),atom(2),atom(3),x(1),y(1),z(1),x(2),y(2),z(2)
	open (unit=6,file='g09.com')
	write (6,*)'%chk=g09.chk'
	write (6,*)'#p opt pw91pw91/3-21g*'
	write (6,*)' '
	write (6,*)'g09 mcmc'
	write (6,*)' '
	write (6,*)'0  1'
	do 10 i=1,N
	write (6,100) atom(i),x(i),y(i),z(i)
10	continue
	write (6,*)' '
	close (6)
100	format(A2,10X,f10.7,4X,f10.7,4X,f10.7)
	end
