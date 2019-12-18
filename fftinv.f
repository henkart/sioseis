       SUBROUTINE FFTINV(A,M)
C COMPUTES AND RETURNS THE INVERSE FFT.  THIS IS BASICALLY THE ONE TAKEN
C FROM OPPENHEIM AND SCHAFER, PAGE 331.
C ARGUMENTS:
C A - THE COMPLEX INPUT ARRAY TO BE TRANSFORMED.  THIS IS ALSO THE OUTPUT!!
C M - THE POWER OF 2 OF THE FFT.  THERE MUST BE 2**M COMPLEX POINTS IN A.
C
      COMPLEX A(1),U,W,T
       DATA PI/3.1415926535/
      N=2**M
      NV2=N/2
      NM1=N-1
      J=1
      DO 7 I=1,NM1
      IF(I.GE.J) GO TO 5
      T=A(J)
      A(J)=A(I)
      A(I)=T
5     K=NV2
6     IF(K.GE.J) GO TO 7
      J=J-K
      K=K/2
      GOTO 6
7     J=J+K
      LE=1
      DO 20 L=1,M
      LE1=LE
      LE=2*LE
      U=(1.,0.)
      B=PI/FLOAT(LE1)
      W=CMPLX(COS(B),-SIN(B))
      DO 20 J=1,LE1
      DO 10 I=J,N,LE
      IP=I+LE1
      T=A(IP)*U
      A(IP)=A(I)-T
10    A(I)=A(I)+T
20    U=U*W
      RETURN
      END
