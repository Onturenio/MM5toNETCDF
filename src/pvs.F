      SUBROUTINE PVS(U,V,T,PRS,DMF,XMF,F,DS,I1,J1,K1,PV,      &
                 TVOR,DUDS,DVDS,DTDX,DTDY,DTDS,PVHOLD)
      implicit none
      integer i1,j1,k1

      REAL U(I1,J1,K1),V(I1,J1,K1),T(I1,J1,K1),DMF(I1,J1),XMF(I1,J1)
      REAL F(I1,J1),PRS(I1,J1,K1),PV(I1,J1,K1)

      REAL TVOR(I1,J1),DUDS(I1,J1),DVDS(I1,J1),DTDX(I1,J1),DTDY(I1,J1)
      REAL DTDS(I1,J1),PVHOLD(I1,J1,K1)

      integer i,j,k,k0,k2
      real ds,ds2r,g,scale,dpr,t1,t2,t3,t4,u1,u2,u3,u4,v1,v2,v3,v4,fx
!
!     ... EVERYTHING IS BY SLABS
!
      DS2R=1./(DS * 2.)
      G=9.81
      SCALE=-1.E6

      DO K=1,K1
!
!        ... COMPUTE VERTICAL DERIVATIVES: DU/DS, DV/DS, DTHETA/DS
!
         IF(K.EQ.1) THEN
            K0=K
            K2=K+1
         ELSE IF(K.EQ.K1) THEN
            K0=K-1
            K2=K
         ELSE
            K0=K-1
            K2=K+1
         ENDIF
         DO J=1,J1-1
         DO I=1,I1-1
            dpr=(prs(i,j,k0)-prs(i,j,k2))/100.
            DUDS(I,J)=(U(I+1,J+1,K0)-U(I+1,J+1,K2)  +    &
                       U(I+1,J  ,K0)-U(I+1,J  ,K2)  +    &
                       U(I  ,J+1,K0)-U(I  ,J+1,K2)  +    &
                       U(I  ,J  ,K0)-U(I  ,J  ,K2)) *    &
                     0.25 / DPR * XMF(I,J)
            DVDS(I,J)=(V(I+1,J+1,K0)-V(I+1,J+1,K2)  +    &
                       V(I+1,J  ,K0)-V(I+1,J  ,K2)  +    &
                       V(I  ,J+1,K0)-V(I  ,J+1,K2)  +    &
                       V(I  ,J  ,K0)-V(I  ,J  ,K2)) *    &
                     0.25 / DPR * XMF(I,J)
         enddo
         enddo
         DO J=1,J1-1
         DO I=1,I1-1
            T1=T(I,J,K0)
            T2=T(I,J,K2)
            dpr=(prs(i,j,k0)-prs(i,j,k2))/100.
            DTDS(I,J)=(T1-T2)/DPR
         enddo
         enddo
!
!        ... COMPUTE HORIZONTAL DERIVATIVES: DTHETA/DX, DTHETA/DY
!
         DO J=2,J1-2
         DO I=2,I1-2
            T1=T(I+1,J  ,K)
            T2=T(I-1,J  ,K)
            T3=T(I  ,J+1,K)
            T4=T(I  ,J-1,K)
            DTDY(I,J)=(T1 - T2)*DS2R
            dtdx(i,j)=(t3-t4)*ds2r
         enddo
         enddo
         CALL FILLIT(DTDX,I1,J1,1,I1,J1,2,I1-2,2,J1-2)
         CALL FILLIT(DTDY,I1,J1,1,I1,J1,2,I1-2,2,J1-2)
!
!        ... COMPUTE SLAB ABSOLUTE VORTICITY
!
         DO J=1,J1-1
         DO I=1,I1-1
            U1=U(I  ,J  ,K)/DMF(I  ,J  )
            U2=U(I+1,J  ,K)/DMF(I+1,J  )
            U3=U(I  ,J+1,K)/DMF(I  ,J+1)
            U4=U(I+1,J+1,K)/DMF(I+1,J+1)
            V1=V(I  ,J  ,K)/DMF(I  ,J  )
            V2=V(I+1,J  ,K)/DMF(I+1,J  )
            V3=V(I  ,J+1,K)/DMF(I  ,J+1)
            V4=V(I+1,J+1,K)/DMF(I+1,J+1)
            FX=(F(I,J)+F(I+1,J)+F(I,J+1)+F(I+1,J+1))*0.25
            TVOR(I,J)=XMF(I,J)**2 * DS2R*((V4-V2+V3-V1)-(U2-U1+U4-U3)) &
                     + FX
         ENDDO
         ENDDO
!
!        ... GROUP TERMS
!
         do J=1,J1-1
         do I=1,I1-1
            PVHOLD(I,J,K)=G * SCALE / 100. *                        &
             (  TVOR (I,J) * DTDS(I,J) -                            &
                DVDS(I,J) * DTDX(I,J) + DUDS(I,J) * DTDY(I,J)  )
         end do
         end do
      ENDDO

      DO K=1,K1
      DO J=1,J1-1
      DO I=1,I1-1
         PV(I,J,K)=PVHOLD(I,J,K)
      ENDDO
      ENDDO
      ENDDO

      RETURN
      END
