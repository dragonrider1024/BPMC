	subroutine dread
	include 'common'
	real x(100),y(100),z(100),amass(100)
	integer N,iostatus,i,nc,nci(10)
	character*2 atom(100)
	character*6 coltil(100)
	open (unit=5,file="wat.inp",status='old')
	read (5,*,iostat=iostatus) 
     +	coltil(1),coltil(2),coltil(3),coltil(4)
!	print *,coltil(1),coltil(2),coltil(3),coltil(4)
	read (5,*,iostat=iostatus) nc
	read (5,*,iostat=iostatus) nci(1),nci(2),nci(3),nci(4) 
	i=1
20	continue
	if(iostatus.gt.0) then
	print *,"there is something wrong"
	goto 30
	else if(iostatus.lt.0) then
!	print *,"reached end-of-file"
	goto 10
	else
	read (5,*,iostat=iostatus) N,atom(i),amass(i),x(i),y(i),z(i)
	i=i+1
	endif
	goto 20
10	continue
	close (5)
!	print *,N,x(1),x(2),x(3),nc
!	print *,N,x(1),x(2),x(3),amass(1),amass(2),amass(3)
30	continue
	nci(nc+1)=N+1
!	print *,nci(nc+1)
	end
