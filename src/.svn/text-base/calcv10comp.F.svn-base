      SUBROUTINE calcv10comp(u10,v10,i1,j1,dir10,mv10)
      implicit none
      integer i1,j1
      REAL u10(i1,j1),v10(i1,j1),dir10(i1,j1),mv10(i1,j1)

      integer i,j
      real SPDTST,RTOD,DCHALF,XSPD,ddir
      DATA  SPDTST/1E-10/, RTOD/57.2957795/, DCHALF/180.0/

      do j=1,j1-1
      do i=1,i1-1
         mv10(i,j) = SQRT(u10(i,j)*u10(i,j) + v10(i,j)*v10(i,j))
!CB
!CB Adding my own routine here for direction, not to happy with the given one
!CB
        if((abs(u10(i,j)).le.1.E-3).AND.(v10(i,j).gt.0.))then
          ddir=90.
        elseif((abs(u10(i,j)).le.1.E-3).AND.(v10(i,j).lt.0.))then
          ddir=270.
        elseif(u10(i,j).gt.0.)then
          ddir=atan(v10(i,j)/u10(i,j))*RTOD
        elseif(u10(i,j).lt.0.)then
          ddir=atan(v10(i,j)/u10(i,j))*RTOD+DCHALF
        endif
  
        dir10(i,j)=270.-ddir
        if(dir10(i,j).lt.  0.) dir10(i,j)=dir10(i,j)+360.
        if(dir10(i,j).gt.360.) dir10(i,j)=dir10(i,j)-360.
  
!CB  
!CB       IF (XSPD .LT. SPDTST) THEN
!CB          DIR(i,j,k) = 0.0
!CB       ELSE
!CB          DIR(i,j,k) = ATAN2(U(i,j,k),V(i,j,k)) * RTOD + DCHALF
!CB       ENDIF
      enddo
      enddo

      RETURN
      END
