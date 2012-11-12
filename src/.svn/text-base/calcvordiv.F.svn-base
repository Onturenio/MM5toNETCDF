      subroutine calcvordiv(u,v,dmf,xmf,ds2r,i1,j1,k1,      &
                            ifvor,ifdiv,vor,div)
      implicit none
      integer i1,j1,k1,ifvor,ifdiv
      real u(i1,j1,k1),v(i1,j1,k1),dmf(i1,j1),xmf(i1,j1)
      real vor(i1,j1,k1),div(i1,j1,k1)
      real ds2r

      integer i,j,k
      real u1,u2,u3,u4,v1,v2,v3,v4

      do k=1,k1
      do j=1,j1-1
      do i=1,i1-1
        u1=u(i  ,j  ,k)/dmf(i  ,j  )
        u2=u(i+1,j  ,k)/dmf(i+1,j  )
        u3=u(i  ,j+1,k)/dmf(i  ,j+1)
        u4=u(i+1,j+1,k)/dmf(i+1,j+1)
        v1=v(i  ,j  ,k)/dmf(i  ,j  )
        v2=v(i+1,j  ,k)/dmf(i+1,j  )
        v3=v(i  ,j+1,k)/dmf(i  ,j+1)
        v4=v(i+1,j+1,k)/dmf(i+1,j+1)
        if(ifvor.eq.1)then
          vor(i,j,k)=xmf(i,j)*xmf(i,j)*ds2r*     &
              ((v4-v2+v3-v1)-(u2-u1+u4-u3))
        endif
        if(ifdiv.eq.1)then
          div(i,j,k)=xmf(i,j)*xmf(i,j)*ds2r*     &
              ((u3-u1+u4-u2)+(v2-v1+v4-v3))
        endif
      enddo
      enddo
      enddo

      return
      end
