	subroutine mcmc
	include 'common'
	real x(100),y(100),z(100),xp(100),yp(100),zp(100)
	real kb,T0,a,b,T,epsi,bins,cmin(1000)
	double precision ene,ene1,ep,elow,eup,etil,etil1
	integer seed,i,M,N,l,kk,h(1000),pos1
	character*2 atom(100)
	data elow,eup/-50,50/
	data h/1000*0/
!	call system('source /usr/local/Ampac/init_ampac.sh')
!	call system('source /usr/local/Ampac/bin/ld_env.sh')
	call init_random_seed( )
	bins=0.1
	epsi=0.0
	M=10000
	kb=8.314
!	T=298.15
!	T=1000.0
	T=600.0
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
	pos1=int((ene1-elow)/bins)+1
	H(pos1)=H(pos1)+1
	etil1=ene1+epsi*H(pos1)
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
	print *, 'old e',ene1,'new e',ene
!	call system('cat fort.6>>etraj.txt')
	pos1=int((ene-elow)/bins)+1
	etil=ene+epsi*H(pos1)
	if(ene.lt.ene1) then
	ene1=ene
	  if(ene.lt.ep) then
	  kk=kk+1
	  ep=ene
	  open(unit=8,file='nisomer.txt')
	  write(8,*) 'nthisomer',kk
	  close(8)
	  call system('./saveout.bash')
	  else
	  endif
	else
	b=exp(-(etil-etil1)*4.12*1000.0/(kb*T))
	a=min(b,1.0)
!	call init_random_seed( )
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
	endif
	open (unit=10,file='h.his')
	do 40 i=1,1000
	write(10,100) i,H(i)
40	continue
	close(10)
30	continue
100	format(I6,4X,I6)
	end
