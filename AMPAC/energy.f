	subroutine energy
	include 'common'
	double precision ene
	call system('ampac g09.dat')
	call system('./reade.bash')
	open (unit=7,file='eng',status='old')
	read (7,*) ene
	close (7)
!	print *,ene,'test'
	call system('./clean.bash')
	end
