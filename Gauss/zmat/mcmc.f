	subroutine mcmc
	include 'common'
	double precision ene,ene1
	real v(100),vp(100),T,kb,r
	integer n,iostatus,i,ch,multi,bl(100),al(100),dl(100),cl(100),
     +	M,seed,pos
	character*3 atom(100),bs(100),as(100),ds(100),sym(100)
	M=10000
	kb=8.314
	T=298.15
	call dread
	call dwrite
	call energy
	ene1=ene
	do 30 l=1,M
	do 10 i=1,3*n-6
	vp(i)=v(i)
10	continue
	call mvpos
	call dwrite
	call energy
	print *,'old e',ene1,'new e',ene
	b=exp(-(ene-ene1)*2625.5*1000.0/(kb*T))
	a=min(b,1.0)
!	call random_seed(seed)
	call random_number(r)
	if(r.lt.a) then
	ene1=ene
	print *,sym(pos),'v(',pos,')',vp(pos),'--->',v(pos)
	else
	do 20 i=1,3*n-6
	v(i)=vp(i)
20	continue
	endif
30	continue
	end
