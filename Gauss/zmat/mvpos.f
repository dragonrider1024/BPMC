	subroutine mvpos
	include 'common'
	real v(100)
	integer n,iostatus,i,ch,multi,bl(100),al(100),dl(100),cl(100),
     +	pos
	character*3 atom(100),bs(100),as(100),ds(100),sym(100)
!	call random_seed(seed)
	call random_number(r)
	pos=int(r*(3*n-6))+1
	call random_number(r)
	if(pos.le.(n-1)) then
	v(pos)=v(pos)+(r-0.5)*0.2
	else if((pos.gt.(n-1)).and.(pos.le.(2*n-3))) then
	v(pos)=v(pos)+(r-0.5)*20.0
		if(v(pos).lt.0) then
		v(pos)=-v(pos)
		else if(v(pos).gt.180) then
		v(pos)=360-v(pos)
		else
		endif
	else
	v(pos)=v(pos)+(r-0.5)*20.0
		if(v(pos).lt.(-180.0)) then
		v(pos)=360+v(pos)
		else if(v(pos).gt.180.0) then
		v(pos)=v(pos)-360.0
		else
		endif
	endif
	end
