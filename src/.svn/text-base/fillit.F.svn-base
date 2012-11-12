      SUBROUTINE FILLIT(F,IX,JX,KX,IMX,JMX,IFIRST,ILAST,JFIRST,JLAST)
      implicit none
      integer IX,JX,KX,IMX,JMX,IFIRST,ILAST,JFIRST,JLAST
!
!     SECTION  TOOLS
!     PURPOSE  FILL DATA OUT TO IMX,JMX FROM AN INTERIOR DOMAIN
!
      REAL F(IX,JX,KX)

      integer i,j,k

      DO 1000 K=1,KX
         DO 300 J=JFIRST,JLAST
            DO 100 I=1,IFIRST-1
               F(I,J,K)=F(IFIRST,J,K)
100         CONTINUE
            DO 200 I=ILAST+1,IMX
               F(I,J,K)=F(ILAST,J,K)
200         CONTINUE
300      CONTINUE
         DO 600 I=1,IMX
            DO 400 J=1,JFIRST-1
               F(I,J,K)=F(I,JFIRST,K)
400         CONTINUE
            DO 500 J=JLAST+1,JMX
               F(I,J,K)=F(I,JLAST,K)
500         CONTINUE
600      CONTINUE
1000  CONTINUE
      RETURN
      END
