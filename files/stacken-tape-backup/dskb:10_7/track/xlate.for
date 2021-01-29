!  R. Powell Nov 1982  /RBP
C		PROGRAM TO ANALIZE TRACK'S
!			BINARY FILES
!
	PROGRAM XLATE
!
	PARAMETER MYVER="304000014	!3D(14)
!
!
!
! GET DEFINITIONS OF VARIABLES, COMMON BLOCKS, ETC:

	INCLUDE 'DSK:XLATE.COM'

	integer commnt(8)		!comment line passed to plots
	INTEGER IBAR(20)		!HISTOGRAM BARS
	INTEGER HISTYP(mxhist)
	INTEGER HISNAM(11,MXHIST)
	logical hisplt(mxhist)		!true if there is data in this
					!histogram to be plotted
	logical	first			!true if we have not read in
					!a date record from the file

	equivalence (IMSI,data(1))
	equivalence (IPQ1,data(9))
	equivalence (IPQ2,data(10))
	equivalence (IMCOR,data(11))
	equivalence (IMMUL,data(12))
	equivalence (IMREQ,data(13))
	equivalence (IMMAX,data(14))
	equivalence (ISWP1,data(28))
	equivalence (ISWP2,data(29))
	equivalence (IFAR1,data(30))
	equivalence (IFAR2,data(31))
	equivalence (IFAR3,data(32))
	equivalence (ISCDC,data(33))
	equivalence (IBBAT,data(34))
	equivalence (IBSWP,data(34))

!	DATA STATEMENTS




! DEFINE TRANSLATION VECTOR FOR CONVERTING TRACKING-TYPE CODE (IWHAT)
! INTO ASCII STRINGS FOR PRINTING

	DATA (ITRANS(I),I=1,5)/'SYSTM','JOB','USERS',
	1 'PPN','TTY'/

!initial values of plotting arrays
	data(xmin(i),i=1,mxhist)/mxhist*1E37/
	data(xmax(i),i=1,mxhist)/mxhist*-1E-37/
	data(ymin(i),i=1,mxhist)/mxhist*1E37/
	data(ymax(i),i=1,mxhist)/mxhist*-1E-37/
	data(hisplt(i),i=1,mxhist)/mxhist*.false./


! DEFINE INITIALL POSITION IN THE INPUT VECTOR

	DATA INPOS/128/			!FORCE A READ

	DATA IRPT/0/		!INITIAL INDEX FOR RPTINF/HISTOT

	DATA OLDRNM/99999/	!PREVIOUS REPORT NUMBER
	DATA OHR/9999/		!HOUR OF PREVIOUS REPORT

	DATA HSTFL1/.FALSE./
	data first/.true./
	data sink/.false./	!do not sink data until overflow occurs
	DATA IVHCNT/0/		!INVALID-HEADER-CODE COUNT


!Initialize Translation Vector converting TRACK block numbers to
!TRKANL numbers

	BLKTYP(1,1)="711	!REPORT START
	BLKTYP(1,2)=1
	BLKTYP(2,1)="721	!SYSTEM DATA INITIALIZATION
	BLKTYP(2,2)=2
	BLKTYP(3,1)="731	!SYSTEM DATA DISPLAY
	BLKTYP(3,2)=3
	BLKTYP(4,1)="732	!SCHEDULER PARAPETER DATA DISPLAY
	BLKTYP(4,2)=4
	BLKTYP(5,1)="741	!SYSTEM DATA ITEM
	BLKTYP(5,2)=5
	BLKTYP(6,1)="751	!SYSTEM DATA ITEM FREQUENCY INFORMATION
	BLKTYP(6,2)=6
	BLKTYP(7,1)="761	!TYPE SUMMARY
	BLKTYP(7,2)=7
	BLKTYP(8,1)="771	!SYSTEM DATA END OF REPORT
	BLKTYP(8,2)=8

!ALL TRACK TYPES ABOVE THIS LINE FOR V5 AND LATER
!ALL TRACK TYPES BELOW THIS LINE FOR EARLIER VERSION (BUT NEW TRKANL
! CANNOT READ EARLIER DATA FILES)

	BLKTYP(9,1)="10
	BLKTYP(9,2)=1
	BLKTYP(10,1)="20
	BLKTYP(10,2)=2
	BLKTYP(11,1)="30
	BLKTYP(11,2)=3
	BLKTYP(12,1)="40
	BLKTYP(12,2)=5
	BLKTYP(13,1)="50
	BLKTYP(13,2)=6
	BLKTYP(14,1)="60
	BLKTYP(14,2)=7
	BLKTYP(15,1)="70
	BLKTYP(15,2)=8


!TO KEEP COPIES OF NAMES FILE SMALL, TRY MAKING THE
!DEFIVE HERE A LOGICAL NAME, AND PUT THE NAMES FILE THERE
	OPEN(UNIT=10,DEVICE='DSK',MODE='ASCII',
	1 ACCESS='SEQIN',FILE='NAMES.TRK')

	DO 6 I=1,MXHIST
	READ(10,10050,END=7)HISTYP(I),(HISNAM(J,I),J=1,11)
6	CONTINUE
	TYPE 10051 
7	CLOSE(UNIT=10)
	hihist=i			!highest legal histogram

!		INITIALIZATION

! DEFINE VERSION NUMBER

	IBLKNO=0



! GET SWITCH VALUES:
	SWHIST=.FALSE.
	SWDTAL=.TRUE.
	SWDUMP=.FALSE.
	SWNON0=.FALSE.
	SWDIST=.FALSE.
	SWPLOT=.FALSE.
	SWIVHC=.FALSE.



25	CONTINUE



! OPEN FILES

	type 10001			!prompt for input file
	OPEN(UNIT=UNIINP,ACCESS='SEQIN',MODE='image',
	1 FILE='TRACK.TRC',VERSION=MYVER,
	1 DEVICE='DSK',DIALOG)

	type 10002			!prompt for output file
	OPEN(UNIT=UNIOUT,ACCESS='SEQOUT',MODE='ASCII',
	1  VERSION=MYVER,DEVICE='DSK',FILE='XLATE.DAT',
	1  DIALOG)

	type 10007			!prompt for plot output file
	open(unit=uniplt,access='seqout',mode='ascii',
	1 version=myver,device='dsk',file='xlate.plt',
	1 dialog)

	type 10009			!prompt for comment line
	accept 19903,commnt


75	CALL DATE(INVECT)
	CALL TIME(K)
	MYVERX=MYVER
	myedit=iright(myverx)		!get edit number for listings

!writeout header line with version # and comment
	write (uniout,10008)myedit,commnt



!		TOP OF MAIN PROCESSING LOOP
!
!
! ALL PROCESSING ROUTINES RETURN TO STATEMENT 100
! WHEN EOF IS REACHED, CONTROL GOES TO 11000 (SEE OPEN STATEMENT).
! THE STATUS OF "FLAG1" CONTROLS WHETHER THIS IS THE END OF THE
! INPUT RECORDS, OR  EOF IN THE MIDDLE OF A RECORD.


100	CONTINUE

	FLAG1=.FALSE.			!NOT PROCESSING AN ENTRY

! GET TYPE OF THIS ENTRY
	CALL INWORD(ITYPE,$11000)
	IF (ITYPE .EQ. 0)GOTO 100	!PASS OVER JUNK WORDS
	FLAG1=.TRUE.			!NOW PROCESSING AN ENTRY



!VALIDATE BLOCK TYPE
	DO 105 I=1,MXBTYP
	IF (ITYPE .NE. BLKTYP(I,1) )GOTO 105	!MATCHED?
	INDEX = BLKTYP(I,2)		!TRANXLATE TO TRKANL BLOCK TYPE
	GOTO 110
105	CONTINUE

!HERE IF INVALID BLOCK TYPE
	CALL BADHDR(1,$100)		!CODE 1 IS BAD BLOCK TYPE

!VALIDATE LENGTH FIELD
110	CONTINUE
	CALL INWORD(ILEN,$11000)	!GET LENGTH OF RECORD
	IF ( (ILEN .GE. 2) .AND.
	1    (ILEN .LT. 100) ) GOTO 120	!FROM 2 TO 100??
	CALL BADHDR(2,$100)		!CODE 2 IS BAD LENGTH

120	CONTINUE

!HEADER IS OK
140	CONTINUE

!GET DATA PORTION OF ENTRY INTO LOCAL VECTOR
160	CALL GETDAT($11000)


!DISPATCH TO CORRECT PROCESSOR
200	GOTO (1000,2000,3000,8000,4000,5000,6000,7000)INDEX
!	      STRT INIT DSPL SCHD RPRT FREQ SUMM END


!--------------------------------------------------------------------------
!		REPORT START ENTRY


1000	CONTINUE
	TRKVER=IDATA(1)			!VER # OF TRACK
	IWHAT=IDATA(2)			!WHAT WE ARE TRACKING.  SE
					!SEE "ITRANS"
! END OF PROCESSING
	GOTO 100
!--------------------------------------------------------------------------

!	SYSTEM DATA INITIALIZATION ENTRY

2000	CONTINUE
	MONVER=IDATA(1)			!MONITOR VERSION #
	CPUSER=IDATA(2)			!CPU SERIAL NUMBER
	JOBMAX=IDATA(3)			!MAX JOBS MONITOR BUILD FOR
	TTYMAX=IDATA(4)			!MAX TTYS  "       "     "
	USRCOR=IDATA(5)/1000		!PAGES OF USER CORE
	TOTMEM=IDATA(6)/1000		!PAGES OF TOTAL CORE
	INTRVL=IDATA(7)			!INTERVAL THIS RUN
	ITERS=IDATA(8)			!ITERATIONS THIS RUN
	UDATIM=IDATA(9)			!UNIVERSAL DATE/TIME

	WRITE (UNIOUT,10045)MONVER,CPUSER,JOBMAX,TTYMAX,USRCOR,
	1 TOTMEM,INTRVL,ITERS


	IDATE=ILEFT(UDATIM)
	ITIME=IRIGHT(UDATIM)

	CALL PRDTIM(IDATE,ITIME)		!AND OUTPUT DATE & TIME


! END OF PROCESSING

2999	GOTO 100
!--------------------------------------------------------------------------

!		SYSTEM DATA DISPLAY

3000	CONTINUE

3200	RPTNUM=IDATA(1)			!REPORT NUMBER
	START=IDATA(2)			!UNIV DATE/TIME STARTED
	STOP=IDATA(3)			!UNIV DATE/TIME ENDED
	CORMAX=IDATA(4)			!# WORDS OF CORMAX
	SCHED=IDATA(5)			!SCHED BITS

! OUTPUT INFORMATION

3700	WRITE (UNIOUT,10010) RPTNUM

	if (rptnum .lt. mxval) goto 3710	!too many reports to store?
	if (sink) goto 3710			!only say this once
	i=mxval
	type 10018,i
	sink=.true.				!sink data from now on
	lstrpt=rptnum-1				!last good report number
3710	continue

	IDATE=ILEFT(START)
	ITIME=IRIGHT(START)

!compute x axis value and put in XVAL for later use in summary
!records.  X axis value is the time of day, expressed as hours and
!parts of hours

	call maktim(idate,itime,jjyr,jjmon,jjday,ihr,imin)
	xval=float(ihr) + float(imin)/60.0
	if (.not. first) goto 3720		!still need date
						!for DATE record?
	first=.false.
	iiyr=jjyr
	iiday=jjday
	iimon=jjmon
3720	continue

	CALL PRDTIM(IDATE,ITIME)		!STARTING DATE/TIME
	IDATE=ILEFT(STOP)
	ITIME=IRIGHT(STOP)
	CALL PRDTIM(IDATE,ITIME)

	WRITE(UNIOUT,10013) CORMAX,SCHED





! END OF PROCESSING

3999	GOTO 100
!--------------------------------------------------------------------------

!		SYSTEM DATA ITEM REPORT

4000	CONTINUE
	ITMNAM=IDATA(1)			!ITEM NAME IN ASCII
	ITMAUX=IDATA(2)			!AUX INFO, IN WHATEVER FORMAT




! HERE TO GET INDEX INTO HISTYP IN 'I'
4200	ITMNUM=item(histyp,itmnam)




! OUTPUT INFORMATION

4900	IF ( (ITMNAM .EQ. 'DISK') .OR.
	1  (ITMNAM .EQ. 'CHAN') )
	1  GOTO 4950		!GO HANDLE DISK/CHAN ENTRIES

	WRITE (UNIOUT,10014)  ITMNAM,
	1 (HISNAM(I,ITMNUM),I=1,11)
	GOTO 4975		!SKIP DISK/CHAN STUFF
4950	CONTINUE
	IAUX1=IASCII(ITMAUX,5)	!CONVERT FROM SIXBIT
	IAUX2=ILSHFT(ITMAUX,30)	!GET TO LAST SIXBIT CHARACTER
	IAUX2=IASCII(IAUX2,1)
	WRITE (UNIOUT,10054)ITMNAM,IAUX1,IAUX2

4975	CONTINUE

! END OF PROCESSING

4999	GOTO 100
!--------------------------------------------------------------------------

!		SYSTEM DATA ITEM FREQUENCY ENTRY

5000	IVALOW=IDATA(1)+1		!LOW VALUE FOR THIS ITER
	IVALHI=IDATA(2)+1		!HIGH VALUE FOR THIS ITER
	VALPCT=DATA(3)			!% VALUES IN ABOVE RANGE THIS

! OUTPUT INFORMATION

!MAKE BAR FOR HIST, THEN PRINT IT ALL OUT
	IPCT=VALPCT/5.0
	DO 5910 I=1,20
5910	IBAR(I)=' '
	IF (IPCT .LE. 20) IBAR(IPCT)='*'
	 WRITE(UNIOUT,10015) IVALOW,IVALHI,VALPCT,(IBAR(I),I=1,20)

! END OF PROCESSING

5999	GOTO 100
!--------------------------------------------------------------------------

!		SUMMARY INFORMATION ENTRY

6000	CONTINUE
	NUMSMP=IDATA(1)			!NUMBER OF SAMPLING THIS ITER
	XMEAN=DATA(2)			!MEAN VALUE
	SIGMA=DATA(3)			!SD FOR DISTRIBUTION


6900	WRITE(UNIOUT,10016) NUMSMP,XMEAN,SIGMA

!store data for later plotting
	call putplt(itmnum,xmean,xval,hisplt)


! END OF PROCESSING

6999	GOTO 100

!--------------------------------------------------------------------------

!			END ENTRY

7000	CONTINUE

	WRITE (UNIOUT,10026)
	GOTO 100

!--------------------------------------------------------------------------

!SCHEDULER PARAMETER ENTRY

8000	CONTINUE


!FORMAT OF SCHEDULER record:
!1	micro scheduling interval
!2	"5"
!3	5 words:
!		b0=fixed quota flag
!		b1-b17=class#
!		b18-b35=quota
!8	"2"
!9	PQ1 quantum runtime
!8	PQ2 quantum runtime
!11	min core usage per job
!12	nim core usage multiplier
!13	min core usage requeue constant
!14	min core usage maximum
!15	"3"
!16-18	3 words of quantum multiplier information
!		LH=queue#
!		RH=quantum multiplier
!19	"2"
!20-21	2 words of max quantum runtime information:
!		LH=queue#
!		RH=max time slice
!22	"5"
!23-27	5 words of secondary class quotas:
!		LH=class#
!		RH=secondary quota
!28	time % to scan Q swapped in before subqueues
!29	swap scan time
!30	scheduler fairness factor
!31	swapper fairness factor
!32	incore fairness factor
!33	SCDCOR
!34	Q# for background batch subqueue
!35	bacground batch swaptime interval

	XMMUL=FLOAT(IMMUL)
	WRITE(UNIOUT,10046)
	1	 IMSI , ISWP2 ,
	1	 IFAR1 , IFAR2 , IFAR3 ,
	1	 ISWP2 , ISCDC ,
	1	 IBBAT , IBSWP ,
	1	 IPQ1 , IPQ2 , IMCOR ,
	1	 XMMUL, IMREQ ,
	1	 IIMMAX 


!GET CLASS INFORMATION
	WRITE (UNIOUT,10024)
	DO 8100 I=1,5
	IQUOTA=IRIGHT(DATA(I+2))
	ICLASS=ILEFT(DATA(I+2)) .AND. "377777
	IFLAG='NO'			!ASSUME NOT FIXED
	IF (DATA(I+2) .LT. 0) IFLAG='YES'
	WRITE (UNIOUT,10047)ICLASS,IQUOTA,IFLAG

	ICLASS=ILEFT(DATA(22+I))
	IQUOTA=IRIGHT(DATA(22+I))		!SEC QUOTA
	WRITE (UNIOUT,10048)ICLASS,IQUOTA
8100	CONTINUE

!GET QUEUE INFORMATION:  MULTIPLIERS
	WRITE (UNIOUT,10024)
	DO 8200 I=1,3
	IQ=ILEFT(DATA(I+15))
	IMULT=IRIGHT(DATA(I+15))
	WRITE (UNIOUT,10049)IQ,IMULT
8200	CONTINUE

!GET QUEUE INFORMATION:  MAX TIME SLICE
	DO 8300 I=1,2
	IQ=ILEFT(DATA(I+19))
	IMAX=IRIGHT(DATA(I+19))
	WRITE (UNIOUT,10053)IQ,IMAX
8300	continue

!now put into histograms.  must fake up itmnum values on the way

	call putplt(item(histyp,'MSI'),FLOAT(IMSI),xval,hisplt)
	call putplt(item(histyp,'PQ1'),FLOAT(IPQ1),xval,hisplt)
	call putplt(item(histyp,'PQ2'),FLOAT(IPQ2),xval,hisplt)
	call putplt(item(histyp,'MCOR'),FLOAT(IMCOR),xval,hisplt)
	call putplt(item(histyp,'MMUL'),FLOAT(IMMUL),xval,hisplt)
	call putplt(item(histyp,'MREQ'),FLOAT(IMREQ),xval,hisplt)
	call putplt(item(histyp,'MMAX'),FLOAT(IMMAX),xval,hisplt)
	call putplt(item(histyp,'SWP1'),FLOAT(ISWP1),xval,hisplt)
	call putplt(item(histyp,'SWP2'),FLOAT(ISWP2),xval,hisplt)
	call putplt(item(histyp,'FAR1'),FLOAT(IFAR1),xval,hisplt)
	call putplt(item(histyp,'FAR2'),FLOAT(IFAR2),xval,hisplt)
	call putplt(item(histyp,'FAR3'),FLOAT(IFAR3),xval,hisplt)
	call putplt(item(histyp,'SCDC'),FLOAT(ISCDC),xval,hisplt)
	call putplt(item(histyp,'BBAT'),FLOAT(IBBAT),xval,hisplt)
	call putplt(item(histyp,'BSWP'),FLOAT(IBSWP),xval,hisplt)


	GOTO 100


!--------------------------------------------------------------------------

!	ERROR PROCESSING ROUTINES



! HERE ON INPUT EOF

11000	CONTINUE
	IF (.NOT. FLAG1) GOTO 30000		!NORMAL EOF
	TYPE 10017, IBLKNO
	GOTO 30000				!ERROR CLOSEUP




! HERE ON OUTPUT ERROR

12000	CONTINUE
	TYPE	10021
	GOTO	20000				!ERROR CLOSEUP
! HERE ON ENTRY CODE OUT OF RANGE

13000	CONTINUE
	FLAG1=.FALSE.
	GOTO 11000	!!TEMPORARY KLUGE!!
	TYPE 10020, ITYPE
	GOTO 20000				!ERROR CLOSEUP



! HERE TO CLOSE UP FILES ON ERROR

20000	CONTINUE
	TYPE 10022				!ABORT MESSAGE
	GOTO 30000				!AND INTO FINAL CODE


! HERE TO CLOSE UP 

30000	CONTINUE

!put out the plotting data.  file format is:
!
!DATE YY MM DD
!TITL 40 character title information
!type 55 character graph name
!type xmin xmax ymin ymax
!type xval yval
!type xval yval 
!type xval yval
!.... and so on
!END
!
!where type is the 4 char abbrev used by TRACK
!all records (graph name, scaling values, and data values)
!for a histogram are kept together.   the reader
!knows when one histogram finishes and another begins
!by the presence of the END record.
!

	write (uniplt,10065)iiyr,iimon,iiday
	write (uniplt,10060)commnt

	do 39500  i=1,hihist		!loop over all histograms
	if(.not. hisplt(i) )goto 39500	!skip non-ex graphs
	write (uniplt,10061)histyp(i),(hisnam(j,i),j=1,11)
	write (uniplt,10062)histyp(i),xmin(i),xmax(i),ymin(i),ymax(i)

	do 39400 j=1,mxval
	if ( (xvalue(i,j) .eq. 0) .and.
	1    (J .gt. 1) )
	1  goto 39400			!skip empty entries
	write (uniplt,10063)histyp(i),xvalue(i,j),yvalue(i,j)
39400	continue

	write (uniplt,10064)	!write END record
39500	continue

	close (unit=uniplt)


! REPORT ANY INVALID HEADER CODES WHICH MAY HAVE OCCURED:
39550	if(.not. sink) goto 39580		!did we sink any data?
	i=rptnum-lstrpt
	type 10039,i,lstrpt

39580	CONTINUE
	type 10040,rptnum

	TYPE	10023				! CLOSING MESSAGE
	CLOSE(UNIT=uniinp)
	CLOSE(UNIT=uniout)

	CALL EXIT
!--------------------------------------------------------------------------


!		FORMAT STATEMENTS


! PROMPTING:
10001	FORMAT(/,  ' INPUT FILESPEC?')
10002	FORMAT(/,' OUTPUT FILESPEC?')

10003	FORMAT(' HEADER.  TRACK VERSION ',O,5X,
	1 'TRACKING TYPE IS ',I2,' (',A5,')' )

10004	FORMAT(1X,/,' SYSTEM DATA.  MONITOR VERSION IS ',O,
	1 /,' JOBMAX IS ',I3,5X,'TTYMAX IS ',I3)

10005	FORMAT(' WORDS OF USER CORE = ',I8,/,
	1 ' WORDS OF TOTAL CORE = ',I8)

10006	FORMAT(' DATE & TIME ARE:  ')

10007	format(/,' Plot File''s Filespec?')
10008	format (' XLATE Edit ',o4,':  ',8a5)
10009	format (/,' Comments (up to 40 characters):  ',$)


10010	FORMAT(////' SYSTEM DATA DISPLAY.  REPORT NUMBER ',
	1 I5)

!--
10013	FORMAT(' CORMAX WAS ',O8,'W',
	1 '    SCHED SET TO ',O12)


10014	FORMAT(/,' ITEM IS "',
	1 A4, '" -- ',11A5)


10015	FORMAT(
	1 '  LOW =',I10,
	1  '  HIGH =',I10,
	1   2X,F6.1,'  %',20A1)


10016	FORMAT('  SAMPLES = ',I5,2X,
	1  'MEAN =',F10.3,
	1 '     SIGMA = ',F10.3)



10017	FORMAT(/'   ???? EOF IN MIDDLE OF RECORD.  BLOCK #',
	1  I5,2X,/)

10018	format (/'   ??? too many reports seen in input file.',/,
	1 '    ??? maximum value is ',i5'.  Remaining data will',/,
	1 '    ??? not be stored in plotting output files.')

10020	FORMAT(/ '   ??? ENTRY CODE OUT OF RANGE:  ',I2,/)

10021	FORMAT (/'   ???? ERROR ON OUTPUT FILE'/)


10022	FORMAT (/'   ???? ABORTING ????'/)


10023	FORMAT (/' XLATE COMPLETED'/)
10024	FORMAT (/)


10026	FORMAT (' END ENTRY ENCOUNTERED')


10029	FORMAT (1X,'   ?? INVALID HEADER CODE:  ',O12,
	1 ' IN BLOCK#',I6,'    ??',/)
10038	FORMAT (1X,'TOTAL # INVALID HEADER CODES:  ',I5)

10039	format (1x,i5,' records were not output to plot file:',/,
	1	' Last good report number=',i5)
10040	format (1x,'Total number of TRACK reports read=',i5)

10045	FORMAT(//,' SYSTEM DATA INITIALIZATION RECORD',/
	1 ' MONVER=',O12,2X,'  CPU SERIAL#=',I5,2X,
	1 '  JOBMAX=',I4,/,
	1 ' TTYMAX=',I5,2X,'  TOTAL USER CORE=',I5,
	1 'P',2X,'  TOTAL MEMORY=',I5,'P',/,
	1 ' INTERVAL TIME=',I5,' SECS',2X,
	1 '     # OF ITERATIONS=',
	1 I5)
10046	FORMAT(/,' SCHEDULER PERFORMANCE INFORMATION:',/,
	1 '  Micro-scheduling Interval=',I5,2x,
	1 '  Swap Scan Time=',i5,/,
	1 '  Scheduler Fairness Factor=',i5,2x,
	1 '  Swapper Fairness=',i5,2x,
	1 '  Incore Fairness=',I5,/,
	1 '  Time % to scan Q swapped in before subQs=',i5,2x,
	1 '  SCDCOR=',i5,/,
	1 '  Background Batch subQ #=',i3,2x,
	1 '  Background Batch swaptime interval=',i5,/,
	1 '  PQ1 Quantum=',i5,2x,
	1 '  PQ2 Quantum=',i5,2x,
	1 '  Minimum core usage per job=',i10,/,
	1 '  Min core usage multiplier=',f8.4,2x,
	1 '  Min core usage requeue constant=',i10,/,
	1 '  Min core usage maximum=',I10)
10047	FORMAT('  CLASS#=',I2,'   QUOTA=',O6,3X,
	1 'FIXED=',A3)
10048	FORMAT('  CLASS#=',I2,'   SECONDARY QUOTA=',O6)
10049	FORMAT('  QUEUE#=',I2,'   QUANTUM MULTIPLIER=',O6)
10053	FORMAT('  QUEUE#=',I2,'   MAX TIME SLICE=',O6)
10054	FORMAT(/,' ITEM IS "',
	1 A4, '" -- ',A5,A1,49X)	!PADD AT RIGHT SO RECORD LENGTH
					!IS SAME AS 10014 OUTPUT
10050	FORMAT(A4,1X,11A5)
10051	FORMAT(' MXHIST NEEDS TO BE INCREASED FOR',
	1 / ' STORAGE OF MORE HISTOGRAM TYPES FROM NAMES.TRK')

10060	format('TITL',1x,8a5)	!for title statements in plots
10061	format(a4,1x,11a5)	!for graph names in plots
10062	format(a4,1x,4(f,1x))	!for scaling numbers in plots
10063	format(a4,1x,f,1x,f)	!for x and y values in plots
10064	format ('END')
10065	format('DATE',3(1x,i2) )	!for DATE records

! INPUT FORMAT STATEMENTS:

19901	FORMAT (A1)
19902	FORMAT (A3)
19903	format (8a5)
!--------------------------------------------------------------------------



	END
	SUBROUTINE INWORD(DUMMY,$)

!	SUBROUTINE TO READ A WORD FROM INPUT FILE

! FIRST ARGUMENT IS WHERE TO RETURN DATA TO,
! SECOND ARGUMENT IS STATEMENT TO GOTO ON EOF


	INCLUDE 'XLATE.COM/NOLIST'		!GET DECLARATIONS

	INTEGER DUMMY

! CHECK TO SEE IF A NEW BLOCK NEEDED

	IF (INPOS .LT. 128) GOTO 100

! SAVE LAST FEW LOCS FROM OLD ARRARY FOR DEBUGGING
	DO 25 IND=1,5
25	IOLD(IND)=INVECT(123+IND)
	
	READ(1,END=1000) INVECT			!UNFORMATTED DUMP READ
	INPOS=0
	IBLKNO=IBLKNO+1			!FOR DIAGNOSTICS

100	INPOS=INPOS+1			!MOVE TO NEXT(OR FIRST) WORD
	DUMMY=INVECT(INPOS)

	RETURN

! HERE ON ERROR
!	1
1000	CONTINUE
	RETURN(1)

	END
	SUBROUTINE GETDAT($)

!	SUBROUTINE TO READ DATA PORTION OF AN ENTRY

! GETDAT RETURNS DATA INTO "IDATA"
!	'$'    IS WHERE TO GOTO ON END-OF-FILE


	INCLUDE 'XLATE.COM/NOLIST'		!GET DECLARATIONS

	LOGICAL FLAG

! CHECK FOR NUL DATA SECTION
	IF (ILEN .EQ. 2)	RETURN

! CHECK FOR ILEN TOO SMALL OR LARGE
	IF ( (ILEN .LE. 40) .AND.
	1 (ILEN .GT. 2) )	GOTO 50
35	TYPE 10002,ILEN,ITYPE,IBLKNO	!TELL USER
10002	FORMAT(/'    ?? ILEN=',I9,' FOR ITYPE=',
	1 O4,' IN BLOCK#',I6,' ??'/)

	CALL EXITS		!EXIT WITHOUT RESET, ETC.


50	DO 100 I=1,ILEN-2
100	CALL INWORD(IDATA(I),$1000)


! CLEAR REST OF OLD ENTRY
	IF ((ILEN-2) .EQ. 40) GOTO 200
	DO 175 I=ILEN+1,40
175	IDATA(I)=0
200	CONTINUE



500	RETURN


! HERE ON EOF
1000	TYPE 10005,I,ILEN
	RETURN(1)



! FORMAT STATEMENS


10003	FORMAT ('    ?ZERO WORD SEEN WHERE FLT PT WORD EXPECTED.'/
	1  ' AROUND WORD#',I4, 5X, 'IN RECORD#',I6)
10004	FORMAT (' REPLACING IT WITH THE NEXT DATA WORD, WHICH IS',/
	1  ' "',O12,'"')
10005	FORMAT ('   ?Input EOF after ',I2,' words when ',I2,/,
	1	'  words expected in record.')

	END
	SUBROUTINE PRDTIM(DATE,TIME)

!	SUBROUTINE TO TYPE DATE AND TIME
	INCLUDE 'XLATE.COM/NOLIST'


	integer date,time,year,month,day,hour,min,sec
	LOGICAL FLAG		!TRUE IF PRINTING TIME
				!FALSE IF RETURNING BINARY INFO

! FIRST ARGUMENT IS THE UNIVERSAL DATE
! SECOND ARGUMENT IS THE UNIVERSAL TIME


	FLAG = .TRUE.		!PRINT THE TIME
	GOTO 100


! ENTRY POINT FOR RETURNING BINARY INFO

	ENTRY MAKTIM(DATE,TIME,YEAR,MONTH,DAY,HOUR,MIN)
	FLAG = .FALSE.		!DO NOT PRINT TIME


! CONVERT TO BINARY FORMAT.  "UV2BIN" RESIDES IN LIBFOR.MAC
! WHICH ALSO NEEDS AT LOAD-TIME SCAN.REL

100	CONTINUE
	CALL UV2BIN(DATE,TIME,YEAR,MONTH,DAY,HOUR,MIN,SEC)

	IF (.NOT. FLAG) RETURN		!ALL DONE IF NOT PRINTING
	WRITE (UNIOUT,1001)MONTH,DAY,YEAR,HOUR,MIN,SEC

1001	FORMAT(1X,2(I2,'/'),I2,5X,2(I2,':'),I2)

	RETURN
	END
	SUBROUTINE BADHDR(ICODE,$)
!SUBROUTINE TO REPORT AND LOG BAD HEADERS

!CODE = REASON FOR CALLING THIS A BAD HEADER:
!	1=HAD BLOCK TYPE
!	2=BAD LENGTH

	INCLUDE 'XLATE.COM/NOLIST'

11001	FORMAT ('   ?Bad block "',O,'" at word #',I3,' in record #',I5)
11002	FORMAT ('   ?Invalid length "',I3,'" at word #',
	1	I3,' in record #',I5)
11004	FORMAT ('   ??BADHDR called with bad reason code?')


	IF ( (ICODE .LT. 1) .OR. (ICODE .GT. 2) ) GOTO 10000
	IPOS=INPOS-1			!GET ACTUAL WORD NUMBER IN RECORD
	GOTO (100,200)ICODE


!BAD BLOCK TYPE
100	TYPE 11001,ITYPE,IPOS,IBLKNO
	RETURN (1)

!BAD LENGTH
200	TYPE 11001,ILEN,IPOS,IBLKNO
	RETURN (1)
!BAD BAD REASON!!
10000	TYPE 11004,ICODE
	CALL EXIT
	END
	subroutine putplt(itm,xmean,xval,hisplt)
!subroutine to put data into the histogram arrays
!call is
!	call putplt(ihisto,y,x,vector)
!where:
!ihisto is the histo number (ITMnum)
!y is the y-value
!x is the x-value
!vector(ihisto) is set to true when we enter data for ihisto


	include 'xlate.com/nolist'
	integer hisplt(mxhist)

	if (sink) return		!sinking excess data?


	yvalue(itm,rptnum)=xmean
	xvalue(itm,rptnum)=xval
	xmin(itm)=amin1(xval,xmin(itm) )
	xmax(itm)=amax1(xval,xmax(itm) )
	ymin(itm)=amin1(xmean,ymin(itm) )
	ymax(itm)=amax1(xmean,ymax(itm) )

	hisplt(itm)=.true.

	return
	end
	function item(histyp,iname)
!function to convert a histo name (4-char from track) to
!an item number (from xlate:names.trk file)
!call is:
!	???=item(histyp,iname)
!where:
!	histyp is the array containing the 4-char abbrevs
!	iname is the name we ae searching for


	include 'xlate.com/nolist'

	integer histyp(mxhist)


	DO 4190 I=1,hiHIST
	IF (iname .EQ. HISTYP(I)) GOTO 4200
4190	CONTINUE
	WRITE (UNIOUT,10027)iname,RPTNUM
	TYPE 10027,iname,RPTNUM
4200	continue
	item=i
	return


10027	FORMAT(/'   ???? UNKNOWN DATA ITEM TYPE:  "',
	1 A4, '"  IN REPORT# ',I5, '  ????',/)


	end
