      SUBROUTINE SEAPRSNH(T,TER,PS,psfc,PP,SIGMA,IMX,JMX,KX,PTOP,    &
       pslv,PL,T0,TS,XKLEV)
!     SECTION  DIAGNOSTIC                                                
!     PURPOSE  COMPUTES SEA LEVEL PRESSURE FROM THE RULE                 
!              T1/T2=(P1/P2)**(GAMMA*R/G).                              
!                                                                       
!     INPUT       T        TEMPERATURE                CROSS    3D       
!                 TER      TERRAIN                    CROSS    2D       
!                 PS       P STAR = PSFC-PTOP         CROSS    2D       
!                 SFP      SURFACE PRESSURE           CROSS    2D       
!                 SIG      HALF SIGMA LEVELS                   1D       
!                 IMX      DOT POINT DIMENSION N-S                      
!                 JMX      DOT POINT DIMENSION E-W                      
!                 KX       NUMBER OF VERTICAL LEVELS                    
!                 PTOP     PRESSURE AT TOP OF MODEL                     
!                                                                       
!     OUTPUT      SLP      SEA LEVEL PRESSURE         CROSS    2D       
!                                                                       
      DIMENSION T(IMX,JMX,KX),PP(IMX,JMX,KX),                     &    
                PS(IMX,JMX)  ,psfc(IMX,JMX) ,                     &
                TER(IMX,JMX) ,SIGMA(KX)
      DIMENSION PL(IMX,JMX),T0(IMX,JMX),TS(IMX,JMX),              &    
                XKLEV(IMX,JMX)                                         
      DIMENSION pslv(IMX,JMX)
                                                                      
      LOGICAL L1,L2,L3,L4                                             

      PARAMETER (TC=273.15+17.5) ! T CRITICAL IN PSFC/PSL
      PARAMETER (PCONST=100.)    ! HEIGHT (MB ABOVE SURFACE)
!                                  TO BEGIN EXTRAPOLATION
      PARAMETER ( R     = 287.04,                                 &  
     &            CP    = 1004.0,                                 &  
     &            ROVCP = R/CP,                                   &  
     &            CPOVR = CP/R,                                   &  
     &            GAMMA = 6.5E-3,                                 & 
     &            G     = 9.81,                                   & 
     &            EPS   = 0.622,                                  &
     &            XLVC1 = 3.1484E6,                               & 
     &            XLVC2 = 2.37E3,                                 & 
     &            SVP1  = 0.6112,                                 & 
     &            SVP2  = 17.67,                                  & 
     &            SVP3  = 29.65,                                  &
     &            SVPT0 = 273.15)
!                                                                 
!     ... SEA LEVEL PRESSURE                                      
!                                                                 
      XTERM=GAMMA*R/G                                             
!                                                                 
!     ... COMPUTE PRESSURE AT PCONST MB ABOVE SURFACE (PL)        
!                                                                 
      KUPTO=KX/2                                                  
99    CONTINUE
      DO 100 J=1,JMX-1                                                  
      DO 100 I=1,IMX-1                                                  
         PL(I,J)=PSFC(I,J)-PCONST                                       
         XKLEV(I,J)=0.                                                 
100   CONTINUE                                                         
!                                                                      
!     ... FIND 2 LEVELS ON SIGMA SURFACES SURROUNDING PL AT EACH I,J   
!                                                                      
      DO 150 J=1,JMX-1                                                 
      DO 150 I=1,IMX-1                                                 
         DO 125 K=KX-1,KUPTO,-1                                        
            IF(((SIGMA(K  )*PS(I,J)+PTOP+PP(I,J,K)).LT.PL(I,J)) .AND.  &
            ((SIGMA(K+1)*PS(I,J)+PTOP+PP(I,J,K+1)).GE.PL(I,J)))        &
            XKLEV(I,J)=FLOAT(K)                                        
125      CONTINUE                                                      
         IF(XKLEV(I,J).LT.1.) THEN                                     
            PRINT *,'ERROR FINDING PRESSURE LEVEL ',PCONST,' MB ',     &
                    'ABOVE THE SURFACE'                                
            PRINT *,'LAST K LEVEL =',KUPTO                             
            IF(KUPTO.NE.1) THEN                                        
               PRINT *,'TRYING AGAIN WITH KUPTO=1'                     
               KUPTO=1                                                 
               GOTO 99                                                 
            ELSE                                                       
               PRINT *,'I,J=',I,J                                      
               PRINT *,'PL=',PL(I,J)                                   
               PRINT *,'PSFC=',PSFC(I,J)
               CALL ABORT                                              
            END IF                                                     
         END IF                                                        
150   CONTINUE                                                         
!                                                                      
!     ... GET TEMPERATURE AT PL (TL), EXTRAPOLATE T AT SURFACE (TS)    
!         AND T AT SEA LEVEL (T0) WITH 6.5 K/KM LAPSE RATE             
!                                                                      
      DO 200 J=1,JMX-1                                                 
      DO 200 I=1,IMX-1
         KLO=NINT(XKLEV(I,J))+1                                       
         KHI=NINT(XKLEV(I,J))                                         
         PLO=SIGMA(KLO)*PS(I,J)+PTOP+PP(I,J,KLO)                      
         PHI=SIGMA(KHI)*PS(I,J)+PTOP+PP(I,J,KHI)                      
         TLO=T(I,J,KLO)                                               
         THI=T(I,J,KHI)                                               
         TL=THI-(THI-TLO)*ALOG(PL(I,J)/PHI)/ALOG(PLO/PHI)             
         TS(I,J)=TL*(PSFC(I,J)/PL(I,J))**XTERM                        
         TBAR=(TS(I,J)+TL)*0.5                                        
         HL=TER(I,J)-R/G*ALOG(PL(I,J)/PSFC(I,J))*TBAR                 
         T0(I,J)=TL+GAMMA*HL                                          
200   CONTINUE                                                        
!                                                                     
!     ... CORRECT SEA LEVEL TEMPERATURE IF TOO HOT                    
!                                                                     
      DO 400 J=1,JMX-1                                                
      DO 400 I=1,IMX-1                                                
         L1=T0(I,J).LT.TC                                             
         L2=TS(I,J).LE.TC                                             
         L3=.NOT.L1                                                   
         IF(L2.AND.L3)THEN                                            
            T0(I,J)=TC                                                
         ELSE IF((.NOT. L2).AND. L3) THEN                             
            T0(I,J)=TC-0.005*(TS(I,J)-TC)**2                         
         ENDIF                                                        
400   CONTINUE                                                          
!                                                                       
!     ... COMPUTE SEA LEVEL PRESSURE                                    
!                                                                       
      DO 600 J=1,JMX-1                                                  
      DO 600 I=1,IMX-1                                                  
         pslv(I,J)=PSFC(I,J)*EXP(2.*G*TER(I,J)/(R*(TS(I,J)+T0(I,J))))
600   CONTINUE                                                          
      RETURN                                                            
      END
