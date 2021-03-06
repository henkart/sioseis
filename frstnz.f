      SUBROUTINE FRSTNZ(IAPADR,NSAMPS,NELEM,ISCR)
C     FRSTNZ RETURNS THE ELEMENT COUNT OF THE FIRST NONZERO ELEMENT OF AN ARRAY
C  STARTING AT AP LOCATION IAPADR.
C
C  ARGUMENTS:
C  IAPADR - THE AP ADDRESS OF THE BEGINNING OF THE ARRAY TO BE SCANNED.
C  NSAMPS - THE NUMBER OF SAMPLES OR ELEMENTS TO BE SCANNED.
C  NELEM  - THE ELEMENT COUNT COMPUTED BY FRSTNZ.  THE FIRST ELEMENT
C           (AT AP ADDRESS IAPADR) IS 1.
C  ISCR   - THE AP ADDRESS OF AN AP SCRATCH ARRAY AT LEAST NSAMPS+2 LONG.
C
C  WRITTEN AND COPYRIGHTED BY
C  PAUL HENKART, SCRIPPS INSTITUTION OF OCEANOGRAPHY, 2 JANUARY 1980
C  ALL RIGHTS ARE RESERVED BY THE AUTHOR.  PERMISSION TO COPY OR REPRODUCE THIS
C  SUBROUTINE, BY COMPUTER OR OTHER MEANS, MAY BE OBTAINED ONLY FROM THE AUTHOR.
C
      CALL LVNOT(IAPADR,1,ISCR,1,NSAMPS)                                 /* ZEROES=1 AND NONZEROES=0
      ISCR1=ISCR+NSAMPS                                                  /* GET ADDITIONAL SCRATCH SPACE (2 WORDS)
      CALL MINV(ISCR,1,ISCR1,NSAMPS)                                     /* FIND THE MINIMUM VALUE (THE FIRST ZERO)
      ISCR2=ISCR1+1                                                      /* THIS POINTS TO THE AP ADDRESS OF THE MINIMUM
      CALL APWR                                                          /* WAIT FOR RESULTS TO BE COMPLETED
      CALL APGET(A,ISCR2,1,2)                                            /* THE ADDRESS IS FLOATING POINT!
      CALL APWD                                                          /* WAIT FOR DATA TRANSMISSION COMPLETION
      NELEM=A                                                            /* COMPUTE THE ELEMENT COUNT FROM THE BEGINNING OF THE ARRAY
      RETURN
      END
