      subroutine calcthe(q,t,prs,i1,j1,k1,thetae)
      implicit none
      integer i1,j1,k1
      real q(i1,j1,k1),t(i1,j1,k1),prs(i1,j1,k1),thetae(i1,j1,k1)

      integer i,j,k
      real e,tlcl,theta
        ! e is vapor pressure in mb
        ! tlcl is temperature at LCL in K

      do k=1,k1
      do j=1,j1-1
      do i=1,i1-1
!CB Getting rid of the problem of undef. T values that creates problems with 
!CB the calculation of tlcl
        if (t(i,j,k) .ne. -9999.) then
        e=prs(i,j,k)*q(i,j,k)/(0.622+q(i,j,k))/100.
        tlcl=55.0+2840.0/(3.5*alog(t(i,j,k))-alog(e)-4.805)
        tlcl=amin1(tlcl,t(i,j,k))
        theta=t(i,j,k)*(100000./prs(i,j,k))**(0.2854*          &
              (1.0-0.28*q(i,j,k)))
        thetae(i,j,k)=theta*exp(((3376./tlcl)-2.54)            &
                          *q(i,j,k)*(1.0+0.81*q(i,j,k))  )
        else
        thetae(i,j,k) =  -9999.
        endif
!CB
      enddo
      enddo
      enddo

      return
      end
