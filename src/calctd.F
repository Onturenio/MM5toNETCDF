      subroutine calctd(q,prs,t,i1,j1,k1,td)
      implicit none
      integer i1,j1,k1
      real q(i1,j1,k1),prs(i1,j1,k1),t(i1,j1,k1),td(i1,j1,k1)

      integer i,j,k
      real frac,el

      do k=1,k1
      do j=1,j1-1
      do i=1,i1-1
        frac=q(i,j,k)/0.622
        el=alog(frac*(0.01*prs(i,j,k))/(1.0+frac))
        td(i,j,k)=273.15+(243.5*el-440.8)/(19.48-el)
        if(td(i,j,k) .lt. 180.) then
            td(i,j,k) = -9999.
        endif
  10    continue
      enddo
      enddo
      enddo

      return
      end
