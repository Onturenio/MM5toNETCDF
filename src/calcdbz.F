      subroutine calcdbz(t,q,prs,rnw,i1,j1,k1,dbz,cref,ifcref,iice)
      implicit none
      integer i1,j1,k1,ifcref,iice
      real t(i1,j1,k1),q(i1,j1,k1),prs(i1,j1,k1),rnw(i1,j1,k1)
      real dbz(i1,j1,k1),cref(i1,j1)

      integer i,j,k
      real rho

      if(ifcref.eq.1)then
        do j=1,j1-1
        do i=1,i1-1
          cref(i,j)=-9999.
        enddo
        enddo
      endif

      do k=1,k1
      do j=1,j1-1
      do i=1,i1-1
        rho=prs(i,j,k)/(287.04*t(i,j,k)*(1.+0.608*q(i,j,k)))
        if(t(i,j,k).le.273.15 .and. iice.ne.0)then
          dbz(i,j,k)=((rnw(i,j,k)*rho)**1.75)*2.18500e-10*1.e18
        else
          dbz(i,j,k)=((rnw(i,j,k)*rho)**1.75)*3.630803e-9*1.e18
        endif
        dbz(i,j,k)=10.*log10(dbz(i,j,k)+1.e-10)
        if(dbz(i,j,k).lt.0.) dbz(i,j,k)=0.
        if(ifcref.eq.1)then
          if(dbz(i,j,k).gt.cref(i,j)) cref(i,j)=dbz(i,j,k)
        endif 
      enddo
      enddo
      enddo

      return
      end
