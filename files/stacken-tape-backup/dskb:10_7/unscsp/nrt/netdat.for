	IMPLICIT INTEGER (A-Z) 
	REAL RANGES, CUMSUM
	REAL TIMER, SUMTIM, SUMSQT, MEAN, VAR, STDV, SQRT
	COMMON WRDCNT, LASTWR
	COMMON /R/ RANGES(55), CUMSUM
	COMMON /M/ MCNT, MHIST(100), MRUN, MGOOD, MBAD
	INTEGER HISTO(55)
	INTEGER MONTHS(12),TIMFV(6),TIMLV(6)
	DATA RANGES/ 0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,
	1 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0,7.5,8.0,
	2 8.5,9.0,9.5,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,
	3 19.0,20.0,25.0,30.0,35.0,40.0,45.0,50.0,55.0,60.0,65.0,70.0,
	4 75.0,80.0,85.0,90.0,95.0,100.0/
	DATA MONTHS/3hJan,3HFeb,3hMar,3hApr,3hMay,3hJun,3hJul,3hAug,
	1           3hSep,3hOct,3HNov,3hDec/
	DATA STAR  /1H*/
C
C
C
C	Program to read NETRSP.DAT, and interpret the results.
C
C	This program computes the following:
C
C		The MEAN response for the interval.
C		The VARIANCE of response for the interval
C		The standard deviation of response for the interval
C		A histogram of responses, as follows:
C			by tenths of seconds, up to 1 second
C			by half seconds, up to 10 seconds
C			by full seconds, up to 20
C			by five second intervals, up to 100
C	A total of 55 intervals
C
	MAPSW = 1
	OPEN(UNIT=1,DEVICE='DSK',ACCESS='SEQIN',MODE='IMAGE',
	1    FILE='NETRSP')
12	WORD = RDONEW(EOFFLG)
	IF (EOFFLG.EQ.0) GO TO 15
	TYPE 16
16	FORMAT(' NETRSP.DAT contains no data')
	GO TO 50
C	
15	IF(WORD.EQ.0) GO TO 12
	IF(WORD.EQ.1) GO TO 20
C
C Bad first word
C
	TYPE 1
1	FORMAT('?First word of file is not a text record')
	STOP

20	CALL NEWREC
C
C Process one experiment
C
	CNT = 0
	TIMFIR = 0
	SUMTIM = 0
	SUMSQT = 0
	DO 21 I = 1, 55
		HISTO(I) = 0
21	CONTINUE
	MCNT = 0
	MRUN = 0
	MGOOD = 0
	MBAD = 0
	DO 22 I = 1, 100
		MHIST(I) = 0
22	CONTINUE
C
C	
25	WORD = RDONEW(EOFFLG)
	IF(EOFFLG.NE.0) GO TO 40
	IF (WORD.EQ.2) GO TO 30
	IF (WORD.EQ.1.OR.WORD.EQ.0) GO TO 40
	TYPE 2, WRDCNT
2	FORMAT('?Illegal record type at word ',I8)
	GOTO 40

30	TIMEST = RDONEW(EOFFLG)
	IF(TIMFIR.EQ.0)TIMFIR = TIMEST
	TIMER = FLOAT(RDONEW(EOFFLG)) / 1000.0
	CNT = CNT + 1
	SUMTIM = SUMTIM + TIMER
	SUMSQT = SUMSQT + (TIMER * TIMER)
	IF (MAPSW.NE.0) CALL MAPRSP(IFIX(TIMER * 1000.0))
	CALL HSTCNT(TIMER, HISTO)
	GO TO 25

C
C  Print out the results of this experiment
C
40	IF (CNT.GT.1) GO TO 45
	PRINT 43
43	FORMAT(' Less than 2 datapoints, statistics are meaningless')
	GO TO 48

45	MEAN = SUMTIM / FLOAT(CNT)
	VAR = (SUMSQT - FLOAT(CNT) * (MEAN * MEAN)) / FLOAT(CNT)
	STDV = SQRT((FLOAT(CNT) * VAR) / (FLOAT(CNT) - 1))
	CALL UDT2DT(TIMFIR,TIMFV)
	CALL UDT2DT(TIMEST,TIMLV)
	T = TIMFV(2)
	TIMFV(2) = MONTHS(TIMFV(1))
	TIMFV(1) = T
	T = TIMLV(2)
	TIMLV(2) = MONTHS(TIMLV(1))
	TIMLV(1) = T
	PRINT 8, TIMFV, TIMLV
8	FORMAT(1X,'Test ran from ',I2,'-',A3,'-',I2,2X,I2,':',I2
	1      ,':'I2,' through ',I2,'-',A3,'-',I2,2X,I2,':',I2
	2      ,':'I2)

	PRINT 4, CNT
4	FORMAT(/I8,'  Observations.')
	PRINT 5, MEAN
5	FORMAT(F8.3, '  Mean response time.')
	PRINT 6, VAR
6	FORMAT(F8.3, '  Variance.')
	PRINT 7, STDV
7	FORMAT(F8.3, '  Standard deviation.',//)
	CALL PRNHST(HISTO,CNT)
	IF (MAPSW.NE.0) CALL PMHIST
48	CALL FNNXTR
	IF (EOFFLG .EQ. 0) GO TO 20

50	CONTINUE
	END

	SUBROUTINE MAPRSP(TIM)
	IMPLICIT INTEGER (A-Z)
	LOGICAL TYPMAP	
	COMMON /M/ MCNT, MHIST(100), MRUN, MGOOD, MBAD
	DATA STAR /1H*/
C
C  Count the number of consecutive good responses
C
	TYPMAP = .FALSE.
	IF (TIM .LE. 200) GO TO 20
	MBAD = MBAD + 1
	IF (CNT.NE.0) MRUN = MRUN + 1
	IF (CNT.GT.100) CNT = 100
	MHIST(CNT) = MHIST(CNT) + 1
	CNT = 0
	GO TO 30
C
20	IF (CNT.EQ.0) MRUN = MRUN + 1
	CNT = CNT + 1
	MGOOD = MGOOD + 1
30	IF (.NOT.TYPMAP) RETURN
	REP = (TIM + 25) / 50
	IF (REP.NE.0) GO TO 10
	TYPE 1
	RETURN

10	TYPE 1, (STAR, I = 1, REP)
	RETURN 

1	FORMAT(1X,100A1)
	END

	SUBROUTINE PMHIST
	IMPLICIT INTEGER (A-Z)
	REAL SQRT, Z, ZN, ZD, ZDN, ZDD, GOOD, BAD, COUNT
	COMMON /M/ MCNT, MHIST(100), MRUN, MGOOD, MBAD
	DATA STAR /1H*/

	PRINT 1
1	FORMAT('1Histogram of runs of good responses'//)

	HIGH = 0
	DO 10 I = 1, 100
		IF (MHIST(I) .NE. 0) HIGH = I
10	CONTINUE

	IF (HIGH .EQ. 0) RETURN
	DO 20 I = 1, HIGH
		REP = MHIST(I)
		IF (REP.GT.100) REP = 100
		IF (REP.NE.0) PRINT 2, I, MHIST(I), (STAR, K = 1, REP)
		IF (REP.EQ.0) PRINT 2, I, REP
20	CONTINUE
C
C  Compute the Run statistic
C
	COUNT = MGOOD + MBAD
	GOOD = MGOOD
	BAD = MBAD
	ZN = FLOAT(MRUN) - (2.0 * GOOD * BAD) / COUNT - 1.0
	ZDN = 2.0 * GOOD * BAD * (2.0 * GOOD * BAD - COUNT)
	ZDD = COUNT ** 2 * (COUNT - 1.0)
	ZD = SQRT(ZDN/ZDD)
	Z = ZN / ZD
	PRINT 3, MGOOD, MBAD, MRUN, Z
3	FORMAT(//,1X,'Number good',I5,', number bad',I5,', runs ',I5,
	1', run statistic is ',F10.7)

	RETURN

2	FORMAT(1X, I4, I6, 3X, 100A1)
	END


	SUBROUTINE FNNXTR
	IMPLICIT INTEGER (A-Z)
	COMMON WRDCNT, LASTWR
C
C  Routine to find the next record.  Looks for a type 1 record, flushes
C  other junk.  Stops at end of file.

10	IF (LASTWR.EQ.1) RETURN
	X = RDONEW(EOFFLG)
	IF (EOFFLG.EQ.0) GO TO 10
	RETURN
	END


	INTEGER FUNCTION RDONEW(F)
	IMPLICIT INTEGER (A-Z)
	COMMON WRDCNT, LASTWR
C
C   Routine to read one word from the input file
C

	F = 0
	READ (1,END=10), LASTWR
	WRDCNT = WRDCNT + 1
	RDONEW = LASTWR
	RETURN

10	F = 1
	RDONEW = 0
	END

	SUBROUTINE NEWREC
	IMPLICIT INTEGER (A-Z)
	COMMON WRDCNT
	INTEGER X(130)
C
C  Routine to process the header
C

	CNT1 = 0	
C
C  Get count
C

	CNT = RDONEW(EOFFLG)
	IF (CNT .LE. 130) GO TO 10
	CNT1 = CNT - 130		
	CNT = 130

10	IF(EOFFLG .NE. 0) GO TO 99
1	FORMAT(1H1,130A1)
2	FORMAT(1H0)
	DO 12 I = 1, CNT
		X(I) = RDONEW(EOFFLG) + 135274560
		IF (EOFFLG .NE. 0) GO TO 99
12	CONTINUE
	PRINT 1,(X(I), I = 1, CNT)
	PRINT 2
	IF (CNT1 .EQ. 0) GO TO 20
C
C  Skip comment characters beyond 130
C
	DO 15 I = 1 , CNT1
		JUNK = RDONEW(EOFFLG)
		IF (EOFFLG .NE. 0) GOTO 99
15	CONTINUE
	
20	RETURN

99	TYPE 3
3	FORMAT(' ?Premature EOF reading comment')
	STOP
	END
		

	SUBROUTINE HSTCNT(X,H)
	IMPLICIT INTEGER (A-Z)
	REAL X
	INTEGER H(55)
C
C  Routine to bump the histogram counters
C
C
C	1-10		x .ge. 0   and x .lt. 1.0
C	11-28		x .ge. 1.0 and x .lt. 10.0
c	29-38		X .ge. 10  and x .LT. 20
c	39-54		x .ge. 20  and x .lt. 100
c	55		x .ge. 100
C
	IF(X .LT. 1.0)  GO TO 10
	IF(X .LT. 10.0) GO TO 20
	IF(X .LT. 20.0) GO TO 30
	IF(X .LT.100.0) GO TO 40
	I = 55
	GO TO 50

10	I = 1 + IFIX(10*X)
	GO TO 50

20	I = 9 + IFIX(2*X)
	GO TO 50

30	I = 14 + IFIX(X)
	GO TO 50

40	I = 35 + IFIX(X/5.0)

50	H(I) = H(I) + 1
	RETURN
	END

	SUBROUTINE PRNHSL(INDEX,N,CNT)
	IMPLICIT INTEGER (A-Z)
	REAL RANGES,Z,ALOG,CUMSUM
	COMMON /R/ RANGES(55), CUMSUM
	DATA HCHAR /1H*/
C
C  Routine to print a histogram line
C
	Z = FLOAT(N) / FLOAT(CNT)
	CUMSUM = CUMSUM + Z
	IF (Z.EQ.0) GO TO 200
	REP = 48 - 48/ALOG(1/FLOAT(CNT))*ALOG(Z)
	IF (INDEX.EQ.55) GO TO 100
	PRINT 1,RANGES(INDEX), RANGES(INDEX+1), N, CUMSUM,
	1	(HCHAR, I = 1, REP)
1	FORMAT(' X>',F5.1,' and X<',F4.1,I5,F8.4,3X,100A1)
	RETURN

100	PRINT 2,RANGES(INDEX), N, CUMSUM, (HCHAR, I = 1, REP)
2	FORMAT(' X>',F5.1,'       ',5X,  I5,F8.4,3X,100A1)
	RETURN

200	IF(INDEX.EQ.55) GO TO 300
	PRINT 3, RANGES(INDEX), RANGES(INDEX+1), N, CUMSUM
3	FORMAT(' X>',F5.1,' and X<',F4.1,I5,F8.4)
	RETURN

300	PRINT 4, RANGES(INDEX), N, CUMSUM
4	FORMAT(' X>',F5.1,'       ',5X  ,I5,F8.4)
	RETURN
	END

	SUBROUTINE PRNHST(HIST,CNT)
	IMPLICIT INTEGER (A-Z)
	INTEGER HIST(55)
	REAL RANGES, CUMSUM
	COMMON /R/ RANGES(55), CUMSUM
C
C  Routine to print the histogram
C
	CUMSUM = 0.0
C
	HIGH = 0
	DO 5 I = 1, 55
		IF(HIST(I) .NE. 0) HIGH = I
5	CONTINUE
C
	DO 10 I = 1, HIGH
		CALL PRNHSL(I,HIST(I),CNT)
10	CONTINUE
	RETURN
	END

	SUBROUTINE UDT2DT(UDT,DATEV)
	IMPLICIT INTEGER (A-Z)
	INTEGER DATEV(6)
	REAL TIMSEC
C
C  Routine to convert from Universal Date/Time to an array of MON, DAY
C  YEAR, HOURS, MINUTES, SECONDS.
C

	TIMSEC = FLOAT(MOD(UDT,2 ** 18))*86400.0/2**18
	UDT = UDT / 2 ** 18 - 26707
	Y = UDT / 1461
	D = UDT - Y * 1461
	Y = 4 * Y
	IF (D.LE.1) GO TO 2
	L = 1
	D = D - 366
	Y = Y + D / 365 + 1
	D = MOD(D, 365)

2	IF(D.GE.(59+L)) GO TO 3
	IF(D.GE.31) GO TO 21
	M = 1
	D = D + 1
	GO TO 4

21	M = 2
	D = D - 30
	GO TO 4

3	D = D - 59 - L
	M = IFIX(FLOAT(D) / 30.6 + 0.019)
	D = D + 1 - IFIX(FLOAT(M) * 30.6 + 0.5)

	M = M + 3
4	DATEV(1) = M
	DATEV(2) = D
	DATEV(3) = Y + 32
	DATEV(4) = TIMSEC / 3600.0
	TMP =  TIMSEC - FLOAT(DATEV(4))*3600.0
	DATEV(5) = FLOAT(TMP) / 60.0
	DATEV(6) = TMP - FLOAT(DATEV(5)) * 60.0
	RETURN
	END