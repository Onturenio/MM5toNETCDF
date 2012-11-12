      SUBROUTINE ADVEC(U,V,DMF,XMF,Q,I1,J1,K1,DS,OUT)      
      implicit none
      integer i1,j1,k1
      real ds
!                                                          
! COMPUTES ADVECTION OF A SCALAR. ON INPUT, OUT CONTAINS   
! THE SCALAR TO BE ADVECTED AND ON OUTPUT IT CONTAINS THE  
! ADVECTION                                                
!                                                          
      real U(I1,J1,K1), V(I1,J1,K1), OUT(I1,J1,K1),       &
        XMF(I1,J1), DMF(I1,J1), Q(I1,J1,K1)                   

      integer i,j,k
      real ds2r,u1,u2,u3,u4,v1,v2,v3,v4,DQDX,DQDY
!                                                          
      DS2R = 1./(2.*DS)                                 
!                                                          
      DO 200 K = 1, K1                                     
         DO 100 J = 2, J1-2                                
         DO 100 I = 2, I1-2                                
            U1=U(I  ,J  ,K)/DMF(I  ,J  )                   
            U2=U(I+1,J  ,K)/DMF(I+1,J  )                   
            U3=U(I  ,J+1,K)/DMF(I  ,J+1)                   
            U4=U(I+1,J+1,K)/DMF(I+1,J+1)                   
            V1=V(I  ,J  ,K)/DMF(I  ,J  )                   
            V2=V(I+1,J  ,K)/DMF(I+1,J  )                   
            V3=V(I  ,J+1,K)/DMF(I  ,J+1)                   
            V4=V(I+1,J+1,K)/DMF(I+1,J+1)                   
            DQDX = (Q(I,J+1,K) - Q(I,J-1,K)) * DS2R            
            DQDY = (Q(I+1,J,K) - Q(I-1,J,K)) * DS2R            
            OUT(I,J,K) = -1.*XMF(I,J)*XMF(I,J)*0.25*       &
                ((U1+U2+U3+U4)*DQDX + (V1+V2+V3+V4)*DQDY)  
100      CONTINUE                                          
200   CONTINUE                                             
      CALL FILLIT(OUT,I1,J1,K1,I1,J1,2,I1-2,2,J1-2)        
      RETURN                                               
      END
