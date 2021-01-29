C- COPYRIGHT (C) 1979,1980 BY DIGITAL EQUIPMENT CORPORATION,
C- MAYNARD, MASS.
C- 
C- 
C- THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED
C- ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH LICENSE AND WITH THE
C- INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR ANY  OTHER
C- COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
C- OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF THE  SOFTWARE  IS  HEREBY
C- TRANSFERRED.
C- 
C- THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE WITHOUT  NOTICE
C- AND  SHOULD  NOT  BE  CONSTRUED  AS A COMMITMENT BY DIGITAL EQUIPMENT
C- CORPORATION.
C- 
C- DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY  OF  ITS
C- SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.

	IMPLICIT INTEGER(A-Z)
	INTEGER RECORD(18),OFILE(6),WHO(0:3),TYPES(0:3,0:6)
	INTEGER DATES(2)

C	Format of RECORD entries as output by TRACER:
C
C	 1 - Sequence number
C	 2 - Jiffy daytime of request
C	 3 - Name of unit (ASCII, e.g. 'DSKB0')
C	 4 - Bit34=Monitor I/O, Bit35=Write
C	 5 - # blocks being IOed
C	 6 - Block number being IOed
C	 7 - UUO executed
C	 8 - Spare
C	 9 - Kontroller type (as from DSKCHR)
C	10 - Unit type (as from DSKCHR)
C	11 - Value of monitor AC S
C	12 - Supposed to be block number within file
C	13 - Job number of requestor
C	14 - Program name
C	15 -  running when data taken
C	16 - Filename and
C	17 -  extension
C	18 - PPN

	DATA WHO/'UR','UW','MR','MW'/
	DATA TYPES/4*'?FD',
	1	'RD10','RM10B',2*'NXD',
	2	'RP01','RP02','RP03','?NXD',
	3	'MD(2)','MD(1)',2*'?NXD',
	4	'RS04',3*'?NXD',
	5	'RP04','RP06','RM03','RP??',
	6	4*'?NXD'/
	DATA UMATCH,PMATCH,MINSIZ/3*0/
	OPEN(UNIT=47,DIALOG='TRACE:DSKFIL.BIN',
	1MODE='IMAGE',ACCESS='SEQIN')
	TYPE 5
	REWIND 47
5	FORMAT(' Output to (Blanks = TTY:) :  ',$)
	ACCEPT 6,OFILE
6	FORMAT(6A5)
	IF(OFILE(1) .EQ. '     ') OFILE(1) = 'TTY: '

	TYPE 104
104	FORMAT(' Sequence limit (0=all entries):  ',$)
	ACCEPT 112, LIMIT
112	FORMAT(I)
	IF(LIMIT .EQ. 0) GO TO 663
	TYPE 124
124	FORMAT(' Starting sequence number:  ',$)
	ACCEPT 112,ISTART
	GO TO 666
663	LIMIT = "377777 777777	! Wants all entries !
666	TYPE 645
645	FORMAT(' Do you wish to select any disk parameters (Y,N): ',$)
	ACCEPT 6,YESNO
	IF(YESNO .EQ. 'Y' .or. yesno .eq. 'y') GO TO 633
	IF(YESNO .EQ. 'N' .or. yesno .eq. 'n') GO TO 686
	GO TO 666
633	IF(YESNO .EQ. 'y') TYPE 634
634	FORMAT(' % Please shift to UPPER case'/)
	TYPE 101
101	FORMAT(' Give unit name (e.g. DSKB1) for selection.  (B'
	1,'lanks = all units):  ',$)
	ACCEPT 6,UMATCH
	IF(UMATCH .EQ. '     ') UMATCH = 0
	TYPE 103
103	FORMAT(' Program name (5 chars) for selection.  (B'
	1,'lanks = all programs):  ',$)
	ACCEPT 6,PMATCH
	IF(PMATCH .EQ. '     ') PMATCH = 0
	TYPE 474
474	FORMAT(' Minimum transfer size (blocks) to report:  ',$)
	ACCEPT 112,MINSIZ
686	OPEN(UNIT=3,DIALOG=OFILE,MODE='ASCII',ACCESS='SEQOUT')
	CALL DATE(DATES)
	CALL TIME(TIMES)
	WRITE(3,8) OFILE,DATES,TIMES
8	FORMAT(1X6A5,3X,2A5,3X,A5//
	1' Seq ID     Daytime  Unit Type  IOtype Block#  UUO of req.'1x 
	2' Status  word'5x'block    job:program file'/)
	SEQ = 0
9	READ(47,END=99,ERR=88) RECORD

	IF(SEQ+1 .EQ. RECORD(1)) GO TO 12
	TYPE 11,SEQ
11	FORMAT(' ? Sequencing error after record',I7)

12	SEQ = RECORD(1)
	IF(SEQ .LT. ISTART) GO TO 9
	UNIT = RECORD(3)
	IF(UMATCH .NE. 0 .AND. UNIT .NE. UMATCH) GO TO 9
	IF(PMATCH .NE. 0 .AND. RECORD(14) .NE. PMATCH) GO TO 9
	IF(RECORD(5) .LT. MINSIZ) GO TO 9
	TMHR = RECORD(2) / 216000
	ETC = RECORD(2) - 216000 * TMHR
	TMMI = ETC / 3600
	ETC = ETC - 3600 * TMMI
	TMSC = ETC / 60
	TMJI = ETC - 60 * TMSC
	TYPE = TYPES(RECORD(10),RECORD(9))
	WHAT = WHO(RECORD(4))
	NUM = RECORD(5)
	LBN = RECORD(6)
	UUO = RECORD(7)
	WRITE(3,14) SEQ,TMHR,TMMI,TMSC,TMJI,UNIT,TYPE,WHAT,NUM,LBN,
	1UUO,(RECORD(IZ),IZ=11,18)
14	FORMAT(I7,I3,':',I2,':',I2,'.'I2,1X,A5,1XA5,1XA2,I4,I7,
	11XO12,2XO12,I10,4XI3':'A5,A1,2X2A5,'['O12,']')
	IF(SEQ .LT. LIMIT) GO TO 9
	GO TO 99

88	TYPE 89
89	FORMAT(' ?Input error')
99	CLOSE(UNIT=3) ; CLOSE(UNIT=47)
	TYPE 144,SEQ
144	FORMAT(' Done after'I8,' entries')
	STOP
	END
