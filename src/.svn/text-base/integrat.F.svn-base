      SUBROUTINE INTEGRAT(fld3d,prs,psfc,i1,j1,k1,sigma,ptop,sigmaf,   &
     &                    slab)
      implicit none
      integer i1,j1,k1
      real fld3d(i1,j1,k1),prs(i1,j1,k1),psfc(i1,j1),sigma(k1),   &
     &     slab(i1,j1),sigmaf(k1+1)
      real ptop

      integer i,j,k
      real gg,prfup,prfdn

!  sigmaf stores values of full-sigma levels
!  prfup is the pressure on the full-sigma level above the current half-level
!  prfdn is the pressure on the full-sigma level below the current half-level
!  gg converts kg/m**2 to g/cm**2, divides by g, and converts Pa to mb

      gg=10./9.81/100.

      do i=1,i1-1
      do j=1,j1-1
        slab(i,j)=0.
      enddo
      enddo

      sigmaf(1)=0.
      sigmaf(k1+1)=1.
      do k=2,k1
        sigmaf(k)=2.*sigma(k-1)-sigmaf(k-1)
      enddo

      do j=1,j1-1
      do i=1,i1-1
        prfup=ptop
        do k=1,k1
          if(k.eq.k1)then
            prfdn=psfc(i,j)
          else
            prfdn=prs(i,j,k)+(prs(i,j,k+1)-prs(i,j,k))*           &
                  (sigmaf(k+1)-sigma(k))/(sigma(k+1)-sigma(k))
          endif
          slab(i,j)=slab(i,j)+fld3d(i,j,k)*(prfdn-prfup)*gg
          prfup=prfdn
        enddo
      enddo
      enddo
 
      RETURN
      END
