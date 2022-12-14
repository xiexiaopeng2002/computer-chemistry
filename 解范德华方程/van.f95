PROGRAM MAIN
    REAL P,R,T,A,B,V0,V,EPS
    EXTERNAL F,G
    COMMON P,R,T,A,B
    OPEN(6,FILE='result.TXT', STATUS='UNKNOWN')
    P=10.0
    R=0.082
    A=8.664
    B=0.08445
    T=273.15
    EPS=1.0E-5
    V0=R*T/P
    WRITE(6,*)'V0=',V0,' dm3'
    CALL NEWN(V0,EPS,F,G,V)
    WRITE(6,*)'Vm=',V,' dm3'
END
FUNCTION F(X)
    REAL P,R,T,A,B
    COMMON P,R,T,A,B
    F=P*X**3-(P*B+R*T)*X*X+A*X-A*B
    RETURN
END
FUNCTION G(X)
    REAL P,R,T,A,B
    COMMON P,R,T,A,B
    G=3*P*X**2-2*(P*B+R*T)*X+A
    RETURN
END
SUBROUTINE NEWN(X0,EPS,F,G,X)
    REAL X0,EPS
    K=1
10  FX=F(X0)
    GX=G(X0)
    X=X0-FX/GX
    IF((ABS(X-X0)/X).GT.EPS)THEN
        X0=X
        K=K+1
        IF(K.GT.50) THEN
            WRITE(*,*)'NO RESOLUTION'
            GOTO 30
        END IF
        GOTO 10
    ENDIF
30  RETURN
END
