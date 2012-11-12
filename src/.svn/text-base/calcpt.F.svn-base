      subroutine calcpt(t,prs,i1,j1,k1,theta)
      implicit none
      integer i1,j1,k1
      real t(i1,j1,k1),prs(i1,j1,k1),theta(i1,j1,k1)

      integer i,j,k
      real rovcp
      rovcp=287.04/1004.

      do k=1,k1
      do i=1,i1-1
      do j=1,j1-1
        theta(i,j,k)=t(i,j,k)*(100000./prs(i,j,k))**rovcp
      enddo
      enddo
      enddo

      return
      end
