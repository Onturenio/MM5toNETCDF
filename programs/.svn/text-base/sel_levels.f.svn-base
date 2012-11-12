
	character(len=200) :: fileh,flev1,flev2,fp1,fp2
	integer :: nlevels
	real :: heigh
	integer ia(1:4)
	real, allocatable, dimension(:,:) :: h
	real, allocatable, dimension (:) :: lev1,lev2
	real, allocatable, dimension (:) :: p1,p2

	write(*,*)'fichero extra con alturas de los niveles'
	read(*,'(a)')fileh
	write(*,*)'numero de niveles'
	read(*,*)nlevels
	write(*,*)'altura que quieres'
	read(*,*)heigh
	write(*,*)'fichero para guardar en extra primer nivel seleccionado'
	read(*,'(a)')flev1
	write(*,*)'fichero para guardar en extra segundo nivel seleccionado'
	read(*,'(a)')flev2
	write(*,*)'fichero para guardar en extra pesos para primer nivel'
	read(*,'(a)')fp1
	write(*,*)'fichero para guardar en extra pesos para segundo nivel'
	read(*,'(a)')fp2

	open(50,file=fileh, status='old', form='unformatted', action='read')
	open(10,file=flev1, status='new', form='unformatted', action='write')
	open(11,file=fp1, status='new', form='unformatted', action='write')
	open(20,file=flev2, status='new', form='unformatted', action='write')
	open(21,file=fp2, status='new', form='unformatted', action='write')

	read(50)ia(1:4)
	nptos=ia(4)

	allocate(h(nlevels,nptos))
	allocate(lev1(nptos),lev2(nptos),p1(nptos),p2(nptos))

	do i=1,nlevels
	  if(i.gt.1)read(50) ia(1:4)
	  read(50)h(i,1:nptos)
	enddo

	do i=1,nptos
	  do j=1,nlevels	
	    if(h(j,i).gt.heigh)then
	      lev1(i)=j-1
	      lev2(i)=j
	      p1(i)=(heigh-h(j-1,i))/(h(j,i)-h(j-1,i))
	      p2(i)=(h(j,i)-heigh)/(h(j,i)-h(j-1,i))
	      goto 100
	    endif
	  enddo
100	continue
	enddo

	write(10)ia(1:4)
	write(10)lev1(1:nptos)

	write(20)ia(1:4)
	write(20)lev2(1:nptos)

	write(11)ia(1:4)
	write(11)p1(1:nptos)

	write(21)ia(1:4)
	write(21)p2(1:nptos)

	end






