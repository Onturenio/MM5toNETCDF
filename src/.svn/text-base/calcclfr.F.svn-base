      subroutine calcclfr(prs,rh,i1,j1,k1,clfrlo,clfrmi,clfrhi)
      implicit none
      integer i1,j1,k1
      real prs(i1,j1,k1),rh(i1,j1,k1)
      real clfrlo(i1,j1),clfrmi(i1,j1),clfrhi(i1,j1)

      integer i,j,k,kclo,kcmd,kchi

      do i=1,i1-1
      do j=1,j1-1
        do k=1,k1
          if(prs(i,j,k).lt. 97000.) kclo=k
          if(prs(i,j,k).lt. 80000.) kcmd=k
          if(prs(i,j,k).lt. 45000.) kchi=k
        enddo
        do k=1,k1
          IF(K.LE.KCLO.AND.K.GT.KCMD)clfrlo(i,j)=      &
             AMAX1(RH(i,j,k),clfrlo(i,j))
          IF(K.LE.KCMD.AND.K.GT.KCHI)clfrmi(i,j)=      &
             AMAX1(RH(i,j,k),clfrmi(i,j))
          IF(K.LE.KCHI)clfrhi(i,j)=AMAX1(RH(i,j,k),clfrhi(i,j))
        enddo

        clfrlo(i,j)=4.0*clfrlo(i,j)/100.-3.0
        clfrmi(i,j)=4.0*clfrmi(i,j)/100.-3.0
        clfrhi(i,j)=2.5*clfrhi(i,j)/100.-1.5
 
        clfrlo(i,j)=amin1(clfrlo(i,j),1.0)
        clfrlo(i,j)=amax1(clfrlo(i,j),0.0)
        clfrmi(i,j)=amin1(clfrmi(i,j),1.0)
        clfrmi(i,j)=amax1(clfrmi(i,j),0.0)
        clfrhi(i,j)=amin1(clfrhi(i,j),1.0)
        clfrhi(i,j)=amax1(clfrhi(i,j),0.0)
      enddo
      enddo

      return
      end
