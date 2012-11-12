      SUBROUTINE PVP(U,V,T,DMF,XMF,F,P,DS,I1,J1,K1,PV,     &
                     DUDP,DVDP,DTDP,DTDY,DTDX,VOR,PVHOLD)

      REAL U(I1,J1,K1), V(I1,J1,K1), T(I1,J1,K1),       &
                DMF(I1,J1), XMF(I1,J1), F(I1,J1),       &
                P(K1),                                  &
                PV(I1,J1,K1)
      REAL VOR (I1,J1),                                 &
                DUDP(I1,J1), DVDP(I1,J1),               &
                DTDX(I1,J1), DTDY(I1,J1),               &
                DTDP(I1,J1),                            &
                PVHOLD(I1,J1,K1)
!
!     ... EVERYTHING IS BY SLABS
!
      G=9.81
      SCALE=-1.E6

      DO 5000 K=1,K1
!
!        ... COMPUTE VERTICAL DERIVATIVES: DU/DP, DV/DP, DTHETA/DP
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
         DO 100 J=1,J1-1
         DO 100 I=1,I1-1
            DUDP(I,J)=(U(I+1,J+1,K0)-U(I+1,J+1,K2)  +       &
                       U(I+1,J  ,K0)-U(I+1,J  ,K2)  +       &
                       U(I  ,J+1,K0)-U(I  ,J+1,K2)  +       &
                       U(I  ,J  ,K0)-U(I  ,J  ,K2)) *       &
                       0.25 / (P(K0)-P(K2)) * XMF(I,J)
            DVDP(I,J)=(V(I+1,J+1,K0)-V(I+1,J+1,K2)  +       &
                       V(I+1,J  ,K0)-V(I+1,J  ,K2)  +       &
                       V(I  ,J+1,K0)-V(I  ,J+1,K2)  +       &
                       V(I  ,J  ,K0)-V(I  ,J  ,K2)) *       &
                       0.25 / (P(K0)-P(K2)) * XMF(I,J)
100      CONTINUE
         DO 110 J=1,J1-1
         DO 110 I=1,I1-1
            T1=T(I,J,K0)*(1000./P(K0))**0.286
            T2=T(I,J,K2)*(1000./P(K2))**0.286
            DTDP(I,J)=(T1-T2)/(P(K0)-P(K2))
110      CONTINUE
!
!        ... COMPUTE HORIZONTAL DERIVATIVES: DTHETA/DX, DTHETA/DY
!
         DS2R=1./(DS * 2.)
         DO 400 J=2,J1-2
         DO 400 I=2,I1-2
            T1=T(I+1,J  ,K)*(1000./P(K))**0.286
            T2=T(I-1,J  ,K)*(1000./P(K))**0.286
            T3=T(I  ,J+1,K)*(1000./P(K))**0.286
            T4=T(I  ,J-1,K)*(1000./P(K))**0.286
            DTDY(I,J)=(T1 - T2)*DS2R
            DTDX(I,J)=(T3 - T4)*DS2R
400      CONTINUE
         CALL FILLIT(DTDX,I1,J1,1,I1,J1,2,I1-2,2,J1-2)
         CALL FILLIT(DTDY,I1,J1,1,I1,J1,2,I1-2,2,J1-2)
!
!        ... COMPUTE SLAB ABSOLUTE VORTICITY
!
         DO 500 J=1,J1-1
         DO 500 I=1,I1-1
            U1=U(I  ,J  ,K)/DMF(I  ,J  )
            U2=U(I+1,J  ,K)/DMF(I+1,J  )
            U3=U(I  ,J+1,K)/DMF(I  ,J+1)
            U4=U(I+1,J+1,K)/DMF(I+1,J+1)
            V1=V(I  ,J  ,K)/DMF(I  ,J  )
            V2=V(I+1,J  ,K)/DMF(I+1,J  )
            V3=V(I  ,J+1,K)/DMF(I  ,J+1)
            V4=V(I+1,J+1,K)/DMF(I+1,J+1)
            FX=(F(I,J)+F(I+1,J)+F(I,J+1)+F(I+1,J+1))*0.25
            VOR(I,J)=XMF(I,J)**2 * DS2R*((V4-V2+V3-V1)-(U2-U1+U4-U3))  &
                     + FX
500      CONTINUE
!
!        ... GROUP TERMS
!
         DO 600 J=1,J1-1
         DO 600 I=1,I1-1
            PVHOLD(I,J,K)=G * SCALE /  100. *                         &
             (  VOR (I,J) * DTDP(I,J) -                               &
                DVDP(I,J) * DTDX(I,J) + DUDP(I,J) * DTDY(I,J)  )
600      CONTINUE
5000  CONTINUE

      DO 5100 K=1,K1
      DO 5100 J=1,J1-1
      DO 5100 I=1,I1-1
         PV(I,J,K)=PVHOLD(I,J,K)
5100  CONTINUE

      RETURN
      END
