	subroutine dwrite
	include 'common'
	real x(100),y(100),z(100)
	character*2 atom(100)
	integer N
!	print *,atom(1),atom(2),atom(3),x(1),y(1),z(1),x(2),y(2),z(2)
	open (unit=6,file='g09.dat')
	write (6,*)'  pm6 rhf singlet truste t=auto xyz geo-ok'
	write (6,*)'title'
	write (6,*)'comment'
	do 10 i=1,N
	write (6,*) atom(i),x(i),'0',y(i),'0',z(i),'0'
10	continue
!	write (6,*)' '
	close (6)
!100	format(A2,10X,f10.7,4X,f10.7,4X,f10.7)
	end
