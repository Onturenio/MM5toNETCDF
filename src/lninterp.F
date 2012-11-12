      subroutine lninterp(var,prs,pk,mix,mjx,mkx,nplevs,plev,ptmp)
      implicit none
      integer nplevs,mix,mjx,mkx
      real var(mix,mjx,mkx),prs(mix,mjx,mkx)
      integer pk(mix,mjx,nplevs)
      real plev(100),ptmp(mix,mjx,nplevs)
 
      integer i,j,k,n,ku,kd
 
      print*,'interpolando logar'
      do n=1,nplevs
        do i=1,mix-1
        do j=1,mjx-1
          if(pk(i,j,n).eq.1)then ! above sigma levels
            ptmp(i,j,n)=-9999.
          elseif(pk(i,j,n).eq.0)then ! below sigma levels
            ku=mkx-1
            kd=mkx
            ptmp(i,j,n)=var(i,j,ku)+                              &
                         (var(i,j,kd)-var(i,j,ku))*               &
                         (alog(plev(n))-alog(prs(i,j,ku)))/       &
                         (alog(prs(i,j,kd))-alog(prs(i,j,ku)))
          else ! regular case
            ku=pk(i,j,n)-1
            kd=pk(i,j,n)
            ptmp(i,j,n)=var(i,j,ku)+                              &
                         (var(i,j,kd)-var(i,j,ku))*               &
                         (alog(plev(n))-alog(prs(i,j,ku)))/       &
                         (alog(prs(i,j,kd))-alog(prs(i,j,ku)))
          endif
        enddo
        enddo
      enddo

      do n=1,nplevs
        do i=1,mix-1
        do j=1,mjx-1
          var(i,j,n)=ptmp(i,j,n)
        enddo
        enddo
      enddo
 
      return
      end
