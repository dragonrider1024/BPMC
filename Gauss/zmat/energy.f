	subroutine energy
	include 'common'
	double precision ene
	call system('g09<g09.com>g09.log')
	call system('./reade.bash')
	open (unit=7,file='eng',status='old')
	read (7,*) ene
	close (7)
!	print *,ene
	call system('./clean.bash')
	end
