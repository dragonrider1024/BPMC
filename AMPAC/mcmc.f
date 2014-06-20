	subroutine mcmc
	include 'common'
	real x(100),y(100),z(100),xp(100),yp(100),zp(100)
	real kb,T0,a,b,T
	double precision ene,ene1,ep
	integer seed,i,M,N,l,kk
	character*2 atom(100)
	M=3000
	kb=8.314
!	T=298.15
!	T=1000.0
	T=100.0
	kk=1
	call dread
	call dwrite
	call energy
	open (unit=8,file='nisomer.txt')
	write (8,*) 'nthisomer',kk
	close(8)
	call system('./saveout.bash')
	ene1=ene
	ep=ene
	do 30 l=1,M-1
!	T=T0*(l-M)*1.0/(1-M)
!	print *,'ene',ene1
	do 10 i=1,N
	xp(i)=x(i)
	yp(i)=y(i)
	zp(i)=z(i)
10	continue
	call mvpos
	call dwrite
	call energy
	print *,'old e',ene1,'new e',ene
	if(ene.lt.ep) then
	kk=kk+1
	ep=ene
	open(unit=8,file='nisomer.txt')
	write(8,*) 'nthisomer',kk
	close(8)
	call system('./saveout.bash')
	else
	endif
	b=exp(-(ene-ene1)*4.12*1000.0/(kb*T))
	a=min(b,1.0)
!	call random_seed(seed)
	call random_number(r)
	if(r.lt.a) then
	ene1=ene
!	if(mod(j,3).eq.0) then
!	print *,'x(',k,'):',xp(k),'->',x(k)
!	else if(mod(j,3).eq.1) then
!	print *,'y(',k,'):',yp(k),'->',y(k)
!	else
!	print *,'z(',k,'):',zp(k),'->',z(k)
!	endif
	else
	do 20 i=1,N
	x(i)=xp(i)
	y(i)=yp(i)
	z(i)=zp(i)
20	continue
	endif
30	continue
	end
