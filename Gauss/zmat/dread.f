	subroutine dread
	include 'common'
	real v(100)
	integer n,iostatus,i,ch,multi,bl(100),al(100),dl(100),cl(100)
	character*3 atom(100),bs(100),as(100),ds(100),sym(100)
	open (unit=5,file="wat.inp",status='old')
	read (5,*,iostat=iostatus) n
!	read total number of atoms
	if(iostatus.gt.0) then
	print *,"there is something wrong"
	goto 10
	else if(iostatus.lt.0) then
!	print *,"reached end-of-file"
	goto 20
	else
	read (5,*,iostat=iostatus) ch,multi
!	read charge and multiplicity
	do 30 i=1,n
	if(i.eq.1) then
	read (5,*,iostat=iostatus)atom(i)
	else if (i.eq.2) then
	read (5,*,iostat=iostatus)atom(i),bl(i-1),bs(i-1)
	else if (i.eq.3) then
	read (5,*,iostat=iostatus)atom(i),bl(i-1),bs(i-1),al(i-2),as(i-2)
	else
	read (5,*,iostat=iostatus)atom(i),bl(i-1),bs(i-1),al(i-2),as(i-2),
     +	dl(i-3),ds(i-3),cl(i-3)
	endif
!	read zmatrix and variable symbols
30	continue
	read (5,*,iostat=iostatus)
!	read blank line
	do 40 i=1,3*n-6
	read (5,*,iostat=iostatus) sym(i),v(i)
40	continue
	endif
20	continue
	close (5)
10	continue
	end
