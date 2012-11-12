      subroutine calcrh(t,q,prs,i1,j1,k1,iice,rh)
      implicit none
      integer i1,j1,k1,iice
      real t(i1,j1,k1),q(i1,j1,k1),prs(i1,j1,k1),rh(i1,j1,k1)

      integer i,j,k
      real es,qs

      do k=1,k1
      do i=1,i1-1
      do j=1,j1-1
        if(t(i,j,k).le.273.15 .and. iice.ne.0)then
          es=6.11*exp(22.514-(6150./t(i,j,k)))
        else
          es=6.112*exp(17.67*((t(i,j,k)-273.15)/(t(i,j,k)-29.65)))
        endif
        qs=0.622*es/((prs(I,J,K)/100.)-es)
        rh(i,j,k)=100.*q(I,J,K)/qs
      enddo
      enddo
      enddo

      return
      end
