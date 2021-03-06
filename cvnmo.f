C      SUBROUTINE CVNMO(IT02,ISI,IX2V2,NSAMPS,IANSWS,ISI2,ISI3,SCALAR)
      SUBROUTINE CVNMO(I1,I2,I3,I4,I5,I6,I7,I8)
C    CVNMO CALCULATES NORMAL MOVEOUT FOR A CONSTANT VELOCITY USING THE AP.
C  ACTUALLY, IT CALCULATES AN ARRAY OF TX VALUES (INDEXES TO THE UNMOVEDOUT
C  TRACE) CORRESPONDING TO A UNIFORMLY INCREASING T0.
C
C    TX=(SQRT(T0**2+C)+SCALAR+SI/2)/SI
C  WHERE:
C   TX = 2 WAY TRAVEL TIME (AS INDEXES TO THE TRACE)
C   T0 = 2 WAY NORMAL INCIDENT TIME
C   C  = X**2/V**2
C   X  = SHOT TO RECEIVER DISTANCE
C   V  = THE CONSTANT VELOCITY
C   SI = THE SAMPLE INTERVAL
C  SCALAR - A SCALAR VALUE TO ADD BEFORE CONVERTING TO INDICES. THIS IS A
C           CONVENIENT WAY TO REMOVE THE DEEP WATER DELAY TIME AND ALSO
C           FIND THE BEGINNING OF THE WINDOW
C
C  METHOD:
C    1)  BUILD AN ARRAY OF T0**2 USING THE INITIAL T0**2 AND THE SAMPLE INTERVAL
C    2)  SQUARE T0
C    3)  ADD THE CONSTANT X**2/V**2
C    4)  TAKE THE SQUARE ROOT
C    5)  ADD THE SCALAR
C    6)  ADD HALF THE SAMPLE INTERVAL FOR ROUNDOFF
C    7)  DIVIDE BY THE SAMPLE INTERVAL TO CONVERT TO SAMPLES
cccccccC    8)  CONVERT SAMPLES TO INDEXES (32 BIT INTEGERS).
C
C  ARGUMENTS:
C    IT02   - THE AP ADDRESS OF THE INITIAL T0 VALUE.
C    ISI    - THE AP ADDRESS OF THE TIME INCREMENT BETWEEN SUCCESSIVE T0 VALUES.
C    IX2V2  - THE AP ADDRESS OF THE SQUARE OF THE RANGE DIVIDED BY THE CONSTANT
C             VELOCITY ((X**2)/(V**2)).
C    NSAMPS - THE NUMBER OF TX VALUES TO COMPUTE.
C    IANSWS - THE AP ADDRESS OF THE OUTPUT ARRAY OF TX.
C    ISI2   - THE AP ADDRESS OF THE SAMPLE INTERVAL, IN SECONDS.
C    ISI3   - THE AP ADDRESS OF HALF THE SAMPLE INTERVAL.
C    SCALAR - THE AP ADDRESS OF THE SCALAR VALUE TO ADD.
C
C  WRITTEN AND COPYRIGHTED BY:
C  PAUL HENKART, SCRIPPS INSTITUTION OF OCEANOGRAPHY, 25 MARCH 1981
C  ALL RIGHTS ARE RESERVED BY THE AUTHOR.  PERMISSION TO COPY OR REPRODUCE THIS
C  SUBROUTINE, BY COMPUTER OR OTHER MEANS, MAY BE OBTAINED ONLY FROM THE AUTHOR.
C
      IMPLICIT INTEGER (A-Z)
      IT02=I1
      ISI=I2
      IX2V2=I3
      NSAMPS=I4
      IANSWS=I5
      ISI2=I6
      ISI3=I7
      SCALAR=I8
      CALL VRAMP(IT02,ISI,IANSWS,1,NSAMPS)
      CALL VMUL(IANSWS,1,IANSWS,1,IANSWS,1,NSAMPS)
      CALL VSADD(IANSWS,1,IX2V2,IANSWS,1,NSAMPS)
      CALL VSQRT(IANSWS,1,IANSWS,1,NSAMPS)
      CALL VSADD(IANSWS,1,SCALAR,IANSWS,1,NSAMPS)
      CALL VSADD(IANSWS,1,ISI3,IANSWS,1,NSAMPS)
      CALL VDIV(ISI2,0,IANSWS,1,IANSWS,1,NSAMPS)
c      CALL VFIX32(IANSWS,1,IANSWS,1,NSAMPS)
      RETURN
      END
