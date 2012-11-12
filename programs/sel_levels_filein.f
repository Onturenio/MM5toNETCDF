
	character(len=200) :: filein,flev1,flev2,file1,file2
	integer :: nlevels
	integer ia(1:4)
	real, allocatable, dimension(:,:) :: dat
	real, allocatable, dimension (:) :: lev1,lev2,dato1,dato2
	integer, allocatable, dimension (:) :: ilev1,ilev2

	write(*,*)'fichero extra de entrada con los datos'
	read(*,'(a)')filein
	write(*,*)'numero de niveles'
	read(*,*)nlevels
	write(*,*)'fichero con primer nivel a seleccionar'
	read(*,'(a)')flev1
	write(*,*)'fichero con segundo nivel a seleccionar'
	read(*,'(a)')flev2
	write(*,*)'fichero donde escribir datos de primer nivel'
	read(*,'(a)')file1
	write(*,*)'fichero donde escribir datos de segundo nivel'
	read(*,'(a)')file2

	open(50,file=filein,form='unformatted',status='old',action='read')
	open(10,file=flev1,form='unformatted',status='old',action='read')
	open(20,file=flev2,form='unformatted',status='old',action='read')
	open(11,file=file1,form='unformatted',status='new',action='write')
	open(21,file=file2,form='unformatted',status='new',action='write')

	read(10)ia(1:4)
	read(20)ia(1:4)

	nptos=ia(4)

	allocate(dat(nlevels,nptos))
	allocate(lev1(nptos),lev2(nptos),ilev1(nptos),ilev2(nptos),dato1(nptos),dato2(nptos))

	read(10)lev1(1:nptos)
	read(20)lev2(1:nptos)

	ilev1=int(lev1)
	ilev2=int(lev2)

	do while (.not.EOF(50))
	  do j=1,nlevels
	    read(50)ia(1:4)
	    read(50)dat(j,1:nptos)
	  enddo
	  do j=1,nptos
	    dato1(j)=dat(ilev1(j),j)
	    dato2(j)=dat(ilev2(j),j)
	  enddo
	  write(11)ia(1:4)
	  write(11)dato1(1:nptos)
	  write(21)ia(1:4)
	  write(21)dato2(1:nptos)
	enddo

	end