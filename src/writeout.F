      subroutine writeout(ztype,nplevs,plev,ifecha,var,mix,mjx,mkx,ix1,ix2,jx1,jx2,ka,kb,kc,icode)
      implicit none

      integer mix,mjx,mkx,ix1,ix2,jx1,jx2,ka,kb,kc,icode
      integer i,j,k,tamanno,blend,ztype
      integer ifecha,nplevs
      real var(mix,mjx,mkx)
      real plev(nplevs)

      blend=5
      tamanno=(jx2-2*blend-jx1+1)*(ix2-ix1+1-2*blend)

      if(ztype.ne.2)then
        do k=ka,kb,kc
          write(90)ifecha,icode,ka-k+1,tamanno
          write(90)((var(i,j,k),j=jx1+blend,jx2-blend),i=ix1+blend,ix2-blend)
        enddo
      else        
        do k=ka,kb,kc
          write(90)ifecha,icode,int(plev(k)/100),tamanno
          write(90)((var(i,j,k),j=jx1+blend,jx2-blend),i=ix1+blend,ix2-blend)
        enddo
      endif

      end subroutine writeout
