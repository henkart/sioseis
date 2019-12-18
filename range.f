      FUNCTION RANGE(GXP,GGX,GNEED)
C    RANGE CALCULATES THE RANGE (SHOT TO RECEIVER DISTANCE) FROM A SET OF
C  GROUP-DISTANCE PAIRS AND/OR THE GROUP-GROUP DISTANCE.  THIS ROUTINE ASSUMES
C  THAT THE SEISMIC LINE IS STRAIGHT!!!  RANGES ARE INTERPOLATED BETWEEN
C  GROUPS SPECIFIED AND ARE EXTRAPOLATED USING GGX FOR GROUPS LESS THAN THE
C  FIRST GIVEN OR GREATER THAN THE LAST GIVEN.  EXTRAPOLATION USES GGX*
C  (GROUP GIVEN - GROUP WANTED)+(RANGE OF THE GROUP GIVEN).
C
C  ARGUMENTS:
C    GXP   - AN ARRAY OF GROUP-DISTANCE PAIRS.  AT LEAST ONE PAIR MUST BE GIVEN.
C            EACH PAIR MUST HAVE THE GROUP NUMBER FIRST AND THE RANGE (DISTANCE)
C            SECOND.  THE GXP SET MUST BE TERMINATED BY A NEGATIVE GROUP NUMBER.
C            THUS, ODD ELEMENTS IN THE GXP ARRAY ARE GROUP NUMBERS AND THE EVEN
C            ELEMENTS ARE THE CORRESPONDING RANGES.  GROUP NUMBERS MUST INCREASE
C            IN THE GXP ARRAY.
C    GGX   - THE CONSTANT GROUP TO GROUP DISTANCE.
C    GNEED - THE GROUP NUMBER OF THE RANGE WANTED.
C
C  EXAMPLE 1:
C  GIVEN GXP(1)=24., GXP(2)=450., GXP(3)=-1.,  GGX=300. AND GNEED=20.
C  THEN RANGE=(24-20)*300.+450.=1650.
C
C  COPYRIGHTED BY:
C  PAUL HENKART, SCRIPPS INSTITUTION OF OCEANOGRAPHY, DECEMBER 1979
C
      DIMENSION GXP(1)
C
      INDEX=1                                                            /* THE FIRST GXP PAIR
   10 TEMP=GXP(INDEX)-GNEED
c      IF(TEMP)300,200,100
      IF( temp .LT. 0 ) GOTO 300
      IF( temp .EQ. 0 ) GOTO 200
  100 IF(INDEX.NE.1) GO TO 150
C****  THE GROUP WANTED IS LESS THAN THE FIRST GIVEN OR IS GREATER THAN THE LAST
C****  GIVEN, THEREFORE, EXTRAPOLATE USING GGX.
  110 CONTINUE
      RANGE=TEMP*GGX+GXP(INDEX+1)
      RETURN
  150 CONTINUE                                                           /*  INTERPOLATE TO GET THE RANGE
      RANGE=(TEMP/(GXP(INDEX)-GXP(INDEX-2)))*(GXP(INDEX-1)-
     *     GXP(INDEX+1))+GXP(INDEX+1)
      RETURN
  200 CONTINUE                                                           /*  GNEED IS GXP(INDEX) EXACTLY!!
      RANGE=GXP(INDEX+1)
      RETURN
  300 CONTINUE                                                          /*  GROUP WANTED (GNEED) IS BIGGER THAN GXP(INDEX)
      IF(GXP(INDEX+2).LT.0.) GO TO 110
      INDEX=INDEX+2
      GO TO 10
      END