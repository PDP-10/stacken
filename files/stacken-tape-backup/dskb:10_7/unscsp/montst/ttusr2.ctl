;TTUSR2.CTL  %006   MAKE TTUSR2.XXX, WAIT FOR TTUSR1.CTL TO MAKE
;TTUSER.SCP, THEN RUN 14 COPIES OF TTUSER.  TTUSR1 WAITS FOR THIS JOB TO
;MAKE FILE TTUSR2.XXX BEFORE IT MAKES TTUSER.SCP
;4 AUG 77  P WHITE/SML
;
.GOTO SKIP
SCP::
	MLON
START:	INIT	1,0
	SIXBIT	/DSK/
	0,,0
	JRST	SLP

	LOOKUP	1,[SIXBIT /TTUSER/
		   SIXBIT /SCP/
		   0
		   0]
	JRST	SLP1

	EXIT

SLP:	MOVEI	1,1
	JRST	.+2
SLP1:	MOVEI	1,2
	MOVEI	2,3	;;SLEEP FOR 3 SEC OCTAL
	SLEEP	2,
	JRST	START

	END	START
SKIP::
.R TECO
=ERTTUSR2.CTL
*_SCP::
=0,.K
=EWWAITT1.MAC
=NSKIP::0L
=.,ZKPWEF
.MAKE TTUSR2.XXX
*ISTART MAKING TTUSER.SCP!
=EX
.EXECUTE WAITT1
;
;TTUSER.SCP FOUND.  RUN 14 COPIES
;
.R SCRIPT
*TTUSER
.CONT
*14
*
*TTUSR2
*TTUSR2
*
*
*
*Y
*N
*Y
.IF (ERROR)  ;WCH FILE IS TOO LONG TO LIST
%FIN:
.NOERROR
.DELETE TTUSR2.XXX
