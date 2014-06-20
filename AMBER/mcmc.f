	subroutine mcmc
	include 'common'
	double precision ene,ene1,elow,eup,etil,etil1,ep
	real c(1000),la,lb,lc,aa,ab,ac,cp(1000),kb,T,epsi,bins,cmin(1000)
	integer n,iostatus,pos,M,k,H(1000),pos1
	character*3 u
	logical yes
	data elow,eup/-200.0,-100.0/
	data H/1000*0/
	bins=0.1
	M=10000
	kb=8.314
	T=298.15
	k=1
	epsi=0.1
	call dread
	call energy
	open (unit=8,file='nisomer.txt')
	write(8,*) 'nthisomer',k
	close(8)
	call system('./saverst.bash')
	ene1=ene
	ep=ene
	do 30 l=1,M
	pos1=int((ene1-elow)/bins)+1
	H(pos1)=H(pos1)+1
	etil1=ene1+epsi*H(pos1)
50	do 10 i=1,3*n
	cp(i)=c(i)
10	continue
	call mvpos
	call dwrite
	call energy
	call readmin(cmin,n)
	call checkcontact(cmin,n,yes)
	print *,yes
	if(yes.eq..true.) then
	c(pos)=cp(pos)
	goto 50
	else
	endif
	print *,'old e',ene1,'new e',ene
	pos1=int((ene-elow)/bins)+1
!	H(pos1)=H(pos1)+1
	etil=ene+epsi*H(pos1)
	if(ene.lt.ene1) then
	ene1=ene
		if(ene.lt.ep) then
		k=k+1
		ep=ene
		open(unit=8,file='nisomer.txt')
		write(8,*) 'nthisomer',k
		close(8)
		call system('./saverst.bash')
		else
		endif
	print *,'c(',pos,')',cp(pos),'--->',c(pos)
	else
	b=exp(-(etil-etil1)*2625.5*1000.0/(kb*T))
	a=min(b,1.0)
!	call random_seed(seed)
	call random_number(r)
	if(r.lt.a) then
!		if(ene.lt.ene1) then
!		k=k+1
!		open(unit=8,file='nisomer.txt')
!		write(8,*) 'nthisomer',k
!		close(8)
!		call system('./saverst.bash')
!		else
!		endif
	ene1=ene
	print *,'c(',pos,')',cp(pos),'--->',c(pos)
	else
	do 20 i=1,3*n-6
	c(i)=cp(i)
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
