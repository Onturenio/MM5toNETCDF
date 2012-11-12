      SUBROUTINE VECT(IX,JX,KX,XLON,XLONC,XLATC,xn,U,V)
      implicit none
      integer ix,jx,kx
      real XLON(IX,JX),U(IX,JX,KX),V(IX,JX,KX)
      real XLONC,XLATC,xn

      integer i,j,k
      real alpha,diff,utemp

      do k=1,kx
      do i=1,ix-1
      do j=1,jx-1
         diff=xlon(i,j)-xlonc
         if(diff .gt.  180.) diff=diff-360.
         if(diff .lt. -180.) diff=diff+360.

         alpha=diff*xn*(3.14159/180.)*sign(1.,xlatc)

         utemp=u(i,j,k)
         u(i,j,k)=v(i,j,k)*sin(alpha) + utemp*cos(alpha)
         v(i,j,k)=v(i,j,k)*cos(alpha) - utemp*sin(alpha)
      enddo
      enddo
      enddo

      RETURN
      END 
