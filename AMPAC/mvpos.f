	subroutine mvpos
	include 'common'
	parameter (pi=3.1415926)
	real x(100),y(100),z(100),r,r1,r2,xcc,ycc,zcc,
     +	xc(100),yc(100),zc(100),amass(100),mtot,q(4),
     +	qinv(4),v(4),
     +	vp(4),theta,alpha,phi,qv(4)
	integer i,seed,N,nc,nci(10),pos
!	call random_seed(seed)
	call random_number(r)
!	print *,int(r/(1.0/(3*N)))
!	call random_number(r)
!	print *,r
!	print *,int(r/(1.0/(3*N)))
!	j=int(r/(1.0/(3*N)))
!	k=int(j/3)+1
!	print *,'r',r,'j',j,'k',k
!	call random_number(r)
!	if(mod(j,3).eq.0) then
!	x(k)=x(k)+(r-0.5)*1.0
!	else if(mod(j,3).eq.1) then
!	y(k)=y(k)+(r-0.5)*1.0
!	else
!	z(k)=z(k)+(r-0.5)*1.0
!	end if
	pos=int(r*nc)+1
	print *,"do coordinate transformation to",pos,"th cluster"
	call random_number(r)
	r1=r
	if (r1.lt.0.5) then
	print *,"do translation"
	call random_number(r)
	r2=r
	if((3.0*r2).lt.1.0) then
	print *, "do x direction translation"
	call random_number(r)
	do 10 i=nci(pos),nci(pos+1)-1
	x(i)=x(i)+(r-0.5)*4.0
10	continue
	else if (((3.0*r2).ge.1.0).and.((3.0*r2).lt.2.0)) then
	print *," do y direction translation"
	call random_number(r)
	do 20 i=nci(pos),nci(pos+1)-1
	y(i)=y(i)+(r-0.5)*4.0
20	continue
	else
	print *,"do z direction translation"
	call random_number(r)
	do 30 i=nci(pos),nci(pos+1)-1
	z(i)=z(i)+(r-0.5)*4.0
30	continue
	endif
	else
	print *,"do rotation"
	xcc=0
	ycc=0
	zcc=0 !zero the center of mass coordinate
	mtot=0 !zero the total mass of the cluster
	! calculate center of mass coordinates
	do 40 i=nci(pos),nci(pos+1)-1
	xcc=xcc+x(i)*amass(i)
	ycc=ycc+y(i)*amass(i)
	zcc=zcc+z(i)*amass(i)
	mtot=mtot+amass(i)
40	continue
	xcc=xcc/mtot
	ycc=ycc/mtot
	zcc=zcc/mtot
	!transform into center of mass coordinates
	do 50 i=nci(pos),nci(pos+1)-1
	x(i)=x(i)-xcc
	y(i)=y(i)-xcc
	z(i)=z(i)-xcc
50	continue
	! do actuall rotation
	call random_number(r)
	theta=(r-0.5)*6.0  !random rotation angle
	q(1)=cos(theta/2.0) !first component of quaternion
	call random_number(r)
	alpha=r*pi !axis direction angle
	call random_number(r)
	phi=r*2.0*pi !axis direction angle
	q(2)=sin(theta/2.0)*cos(alpha)*sin(phi) !second
	q(3)=sin(theta/2.0)*sin(alpha)*sin(phi) !third
	q(4)=sin(theta/2.0)*cos(phi) !fourth
	call inverse(q,qinv)
	! do quaternion rotation of individual atom one by one
	do 60 i=nci(pos),nci(pos+1)-1
	v(1)=0
	v(2)=x(i)
	v(3)=y(i)
	v(4)=z(i)
	call multi(q,v,qv)
	call multi(qv,qinv,vp)
!	if(abs(vp(1)).gt.1E-4) then
!	print *,"quaternion calculation error"
!	stop
!	else
	x(i)=vp(2)
	y(i)=vp(3)
	z(i)=vp(4)
	 !finish quaternion rotation
	x(i)=x(i)+xcc
	y(i)=y(i)+ycc
	z(i)=z(i)+zcc
!	endif
	! transforming from center of mass coordinates to original coordinates
60	continue
	endif
	end
