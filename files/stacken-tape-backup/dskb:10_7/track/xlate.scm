File 1)	DSK:X.FOR[4,126]    	created: 1227 21-Aug-1982
File 2)	DSK:XLATE.FOR[4,126]	created: 0045 28-Aug-1982

1)1		PARAMETER MYVER="303000012	!3C(12)
1)	C
****
2)1		PARAMETER MYVER="303000013	!3C(13)
2)	C
**************
1)1		INTEGER IBAR(20)		!HISTOGRAM BARS
1)		INTEGER HISTYP(MXHIST)
1)		INTEGER HISNAM(11,MXHIST)
1)	C	DATA STATEMENTS
****
2)1		integer commnt(8)		!comment line passed to plots
2)		INTEGER IBAR(20)		!HISTOGRAM BARS
2)		INTEGER HISTYP(mxhist)
2)		INTEGER HISNAM(11,MXHIST)
2)		logical hisplt(mxhist)		!true if there is data in this
2)						!histogram to be plotted
2)		logical	first			!true if we hav e not read in
2)						!a date record from the file
2)	C	DATA STATEMENTS
**************
1)1	C DEFINE INITIALL POSITION IN THE INPUT VECTOR
****
2)1		data(hisplt(i),i=1,mxhist)/mxhist*.true./
2)	C DEFINE INITIALL POSITION IN THE INPUT VECTOR
**************
1)1	C  MISC:
1)		DATA HSTFL1/.FALSE./
1)		DATA IVHCNT/0/		!INVALID-HEADER-CODE COUNT
****
2)1		DATA HSTFL1/.FALSE./
2)		data first/.true./
2)		DATA IVHCNT/0/		!INVALID-HEADER-CODE COUNT
**************
1)1		OPEN(UNIT=10,DEVICE='TRACK',MODE='ASCII',
1)		1 ACCESS='SEQIN',FILE='NAMES.TRK')
****
2)1		OPEN(UNIT=10,DEVICE='xlate',MODE='ASCII',
2)		1 ACCESS='SEQIN',FILE='NAMES.TRK')
**************
1)1	C OPEN FILES FOR INPUT, OUTPUT, AND DUMPING
1)	C dumpING OF RECORDS:
1)		OPEN(UNIT=UNIINP,ACCESS='SEQIN',MODE='image',
****
2)1	C OPEN FILES
2)		type 10001			!prompt for input file
2)		OPEN(UNIT=UNIINP,ACCESS='SEQIN',MODE='image',
**************
1)1		OPEN(UNIT=UNIOUT,ACCESS='SEQOUT',MODE='ASCII',
****
2)1		type 10002			!prompt for output file
2)		OPEN(UNIT=UNIOUT,ACCESS='SEQOUT',MODE='ASCII',
**************
1)1		open(unit=uniplt,access='seqout',mode='ascii',
****
2)1		type 10007			!prompt for plot output file
File 1)	DSK:X.FOR[4,126]    	created: 1227 21-Aug-1982
File 2)	DSK:XLATE.FOR[4,126]	created: 0045 28-Aug-1982

2)		open(unit=uniplt,access='seqout',mode='ascii',
**************
1)1	75	CALL DATE(INVECT)
****
2)1		type 10008			!prompt for comment line
2)		accept 19903,commnt
2)	75	CALL DATE(INVECT)
**************
1)1	C		TOP OF MAIN PROCESSING LOOP
****
2)1		myedit=iright(myverx)		!get edit number for listings
2)	!writeout header line with version # and comment
2)		write (uniout,10008)myedit,commnt
2)2	C		TOP OF MAIN PROCESSING LOOP
**************
1)1		call maktim(idate,itime,i,i,i,ihr,imin)
1)		xval=float(ihr) + float(imin)/60.0
1)		CALL PRDTIM(IDATE,ITIME)		!STARTING DATE/TIME
****
2)2		if (.not. first) goto 3720		!still need date?
2)		call maktim(idate,itime,iiyr,iimon,iiday,ihr,imin)
2)		xval=float(ihr) + float(imin)/60.0
2)		first=.false.
2)	3720	continue
2)		CALL PRDTIM(IDATE,ITIME)		!STARTING DATE/TIME
**************
1)1		DO 4190 I=1,MXHIST
1)		IF (ITMNAM .EQ. HISTYP(I)) GOTO 4200
1)	4190	CONTINUE
1)		WRITE (UNIOUT,10027)ITMNAM,RPTNUM
1)		TYPE 10027,ITMNAM,RPTNUM
1)	4200	ITMNUM=I
1)	C OUTPUT INFORMATION
****
2)2	4200	ITMNUM=item(histyp,itmnam)
2)	C OUTPUT INFORMATION
**************
1)1		yvalue(itmnum,rptnum)=xmean
1)		xvalue(itmnum,rptnum)=xval
1)		xmin(itmnum)=amin1(xval,xmin(itmnum) )
1)		xmax(itmnum)=amax1(xval,xmax(itmnum) )
1)		ymin(itmnum)=amin1(xmean,ymin(itmnum) )
1)		ymax(itmnum)=amax1(xmean,ymax(itmnum) )
1)	C END OF PROCESSING
****
2)2		call putplt(itmnum,xmean,xval)
2)		hisplt(itmnum)=.true.		!something there to plot
2)	C END OF PROCESSING
**************
1)1	!FORMAT OF SCHEDULER RECORD:
1)	!1	micro scheduling interval
1)	!2	5 words:
1)	!		b0=fixed quota flag
****
2)2	!FORMAT OF SCHEDULER record:
2)	!1	micro scheduling interval
File 1)	DSK:X.FOR[4,126]    	created: 1227 21-Aug-1982
File 2)	DSK:XLATE.FOR[4,126]	created: 0045 28-Aug-1982

2)	!2	"5"
2)	!3	5 words:
2)	!		b0=fixed quota flag
**************
1)1	!7	PQ1 quantum runtime
1)	!8	PQ2 quantum runtime
1)	!9	min core usage per job
1)	!10	nim core usage multiplier
1)	!11	min core usage requeue constant
1)	!12	nim core usage maximum
1)	!13-15	3 words of quantum multiplier information
1)	!		LH=queue#
1)	!		RH=quantum multiplier
1)	!16-17	2 words of max quantum runtime information:
1)	!		LH=queue#
1)	!		RH=max time slice
1)	!18-22	5 words of secondary class quotas:
1)	!		LH=class#
1)	!		RH=secondary quota
1)	!23	time % to scan Q swapped in before subqueues
1)	!24	swap scan time
1)	!25	scheduler fairness factor
1)	!26	swapper fairness factor
1)	!27	incore fairness factor
1)	!28	SCDCOR
1)	!29	Q# for background batch subqueue
1)	!30	bacground batch swaptime interval
1)		WRITE(UNIOUT,10046)
1)		1	DATA(1),DATA(24),
1)		1	DATA(25),DATA(26),DATA(27),
1)		1	DATA(23),DATA(28),
1)		1	DATA(29),DATA(30),
1)		1	DATA(7),DATA(8),DATA(9),
1)		1	DATA(10),DATA(11),
1)		1	DATA(12)
1)	!GET CLASS INFORMATION
1)		DO 8100 I=1,5
1)		IQUOTA=IRIGHT(DATA(I+1))
1)		ICLASS=ILEFT(DATA(I+1)) .AND. "377777
1)		IFLAG='NO'			!ASSUME NOT FIXED
1)		IF (DATA(I+1) .LT. 0) IFLAG='YES'
1)		WRITE (UNIOUT,10047)ICLASS,IQUOTA,IFLAG
1)		ICLASS=ILEFT(DATA(17+I))
1)		IQUOTA=IRIGHT(DATA(17+I))		!SEC QUOTA
1)		WRITE (UNIOUT,10048)ICLASS,IQUOTA
****
2)2	!8	"2"
2)	!9	PQ1 quantum runtime
2)	!8	PQ2 quantum runtime
2)	!11	min core usage per job
2)	!12	nim core usage multiplier
2)	!13	min core usage requeue constant
2)	!14	min core usage maximum
2)	!15	"3"
2)	!16-18	3 words of quantum multiplier information
2)	!		LH=queue#
File 1)	DSK:X.FOR[4,126]    	created: 1227 21-Aug-1982
File 2)	DSK:XLATE.FOR[4,126]	created: 0045 28-Aug-1982

2)	!		RH=quantum multiplier
2)	!19	"2"
2)	!20-21	2 words of max quantum runtime information:
2)	!		LH=queue#
2)	!		RH=max time slice
2)	!22	"5"
2)	!23-27	5 words of secondary class quotas:
2)	!		LH=class#
2)	!		RH=secondary quota
2)	!28	time % to scan Q swapped in before subqueues
2)	!29	swap scan time
2)	!30	scheduler fairness factor
2)	!31	swapper fairness factor
2)	!32	incore fairness factor
2)	!33	SCDCOR
2)	!34	Q# for background batch subqueue
2)	!35	bacground batch swaptime interval
2)		WRITE(UNIOUT,10046)
2)		1	DATA(1),DATA(29),
2)		1	DATA(30),DATA(31),DATA(32),
2)		1	DATA(28),DATA(33),
2)		1	DATA(34),DATA(35),
2)		1	DATA(9),DATA(10),DATA(11),
2)		1	DATA(12),DATA(13),
2)		1	DATA(14)
2)	!GET CLASS INFORMATION
2)		DO 8100 I=1,5
2)		IQUOTA=IRIGHT(DATA(I+2))
2)		ICLASS=ILEFT(DATA(I+2)) .AND. "377777
2)		IFLAG='NO'			!ASSUME NOT FIXED
2)		IF (DATA(I+2) .LT. 0) IFLAG='YES'
2)		WRITE (UNIOUT,10047)ICLASS,IQUOTA,IFLAG
2)		ICLASS=ILEFT(DATA(22+I))
2)		IQUOTA=IRIGHT(DATA(22+I))		!SEC QUOTA
2)		WRITE (UNIOUT,10048)ICLASS,IQUOTA
**************
1)1		IQ=ILEFT(DATA(I+12))
1)		IMULT=IRIGHT(DATA(I+12))
1)		WRITE (UNIOUT,10049)IQ,IMULT
****
2)2		IQ=ILEFT(DATA(I+15))
2)		IMULT=IRIGHT(DATA(I+15))
2)		WRITE (UNIOUT,10049)IQ,IMULT
**************
1)1		IQ=ILEFT(DATA(I+15))
1)		IMAX=IRIGHT(DATA(I+15))
1)		WRITE (UNIOUT,10053)IQ,IMAX
1)	8300	CONTINUE
1)		GOTO 100
****
2)2		IQ=ILEFT(DATA(I+19))
2)		IMAX=IRIGHT(DATA(I+19))
2)		WRITE (UNIOUT,10053)IQ,IMAX
2)	8300	continue
2)	!now put into histograms.  must fake up itmnum values on the way
2)		call putplt(item(histyp,'MSI'),data(1),xval)
File 1)	DSK:X.FOR[4,126]    	created: 1227 21-Aug-1982
File 2)	DSK:XLATE.FOR[4,126]	created: 0045 28-Aug-1982

2)		call putplt(item(histyp,'PQ1'),data(9),xval)
2)		call putplt(item(histyp,'pq2'),data(10),xval)
2)		call putplt(item(histyp,'MCOR'),data(11),xval)
2)		call putplt(item(histyp,'MMUL'),data(12),xval)
2)		call putplt(item(histyp,'MREQ'),data(13),xval)
2)		call putplt(item(histyp,'MMAX'),data(14),xval)
2)		call putplt(item(histyp,'SWP1'),data(28),xval)
2)		call putplt(item(histyp,'SWP2'),data(29),xval)
2)		call putplt(item(histyp,'FAR1'),data(30),xval)
2)		call putplt(item(histyp,'FAR2'),data(31),xval)
2)		call putplt(item(histyp,'FAR3'),data(32),xval)
2)		call putplt(item(histyp,'SCDC'),data(33),xval)
2)		call putplt(item(histyp,'BBAT'),data(34),xval)
2)		call putplt(item(histyp,'BSWP'),data(34),xval)
2)		GOTO 100
**************
1)1	!TITL 40 character title information  (this line is optional)
1)	!type 55 character graph name
****
2)2	!DATE YY MM DD
2)	!TITL 40 character title information
2)	!type 55 character graph name
**************
1)1		do 39500  i=1,mxhist		!loop over all histograms
1)		write (uniplt,10061)histyp(i),(hisnam(j,i),j=1,11)
****
2)2		write (uniplt,10065)iiyr,iimon,iiday
2)		write (uniplt,10060)commnt
2)		do 39500  i=1,mxhist		!loop over all histograms
2)		if(.not. hisplt(i) )goto 39500	!still non-ex graphs
2)		write (uniplt,10061)histyp(i),(hisnam(j,i),j=1,11)
**************
1)1	10001	FORMAT(////,  ' INPUT FILESPEC?'/)
1)	10002	FORMAT(//' OUTPUT FILESPEC?'//)
1)	C REPORTING OUTPUTS
1)	10003	FORMAT(' HEADER.  TRACK VERSION ',O,5X,
****
2)2	10001	FORMAT(  ' INPUT FILESPEC?')
2)	10002	FORMAT(' OUTPUT FILESPEC?')
2)	10003	FORMAT(' HEADER.  TRACK VERSION ',O,5X,
**************
1)1	10010	FORMAT(////' SYSTEM DATA DISPLAY.  REPORT NUMBER ',
****
2)2	10007	format(' Plot File''s Filespec?')
2)	10008	format (' XLATE Edit ',o4,':  ',8a5)
2)	10010	FORMAT(////' SYSTEM DATA DISPLAY.  REPORT NUMBER ',
**************
1)1	10025	FORMAT(' TRKANL(', O2 ')', 5X, 2A5, 5A, A5///////)
1)	10026	FORMAT (' END ENTRY ENCOUNTERED')
1)	10027	FORMAT(////'   ???? UNKNOWN DATA ITEM TYPE:  "',
1)		1 A4, '"  IN REPORT# ',I5, '  ????',///)
1)	10029	FORMAT (1X,'   ?? INVALID HEADER CODE:  ',O12,
****
2)2	10026	FORMAT (' END ENTRY ENCOUNTERED')
2)	10029	FORMAT (1X,'   ?? INVALID HEADER CODE:  ',O12,
**************
File 1)	DSK:X.FOR[4,126]    	created: 1227 21-Aug-1982
File 2)	DSK:XLATE.FOR[4,126]	created: 0045 28-Aug-1982

1)1	10060	format(a4,1x,8a5)	!for title statements (optnl) in plots
1)	10061	format(a4,1x,11a5)	!for graph names in plots
****
2)2	10060	format('TITL',1x,8a5)	!for title statements in plots
2)	10061	format(a4,1x,11a5)	!for graph names in plots
**************
1)1	C INPUT FORMAT STATEMENTS:
****
2)2	10065	format('DATE',3(1x,i2) )	!for DATE records
2)	C INPUT FORMAT STATEMENTS:
**************
1)1	!--------------------------------------------------------------------------
****
2)2	19903	format (8a5)
2)	!--------------------------------------------------------------------------
**************
2)2		
2)2		subroutine putplt(itm,xmean,xval)
2)2	!subroutine to put data into the histogram arrays
2)2	!call is
2)2	!	call putplt(ihisto,y,x)
2)2	!where:
2)2	!ihisto is the histo number (ITMnum)
2)2	!y is the y-value
2)2	!x is the x-value
2)2		include 'xlate.com/nolist'
2)2		yvalue(itm,rptnum)=xmean
2)2		xvalue(itm,rptnum)=xval
2)2		xmin(itm)=amin1(xval,xmin(itm) )
2)2		xmax(itm)=amax1(xval,xmax(itm) )
2)2		ymin(itm)=amin1(xmean,ymin(itm) )
2)2		ymax(itm)=amax1(xmean,ymax(itm) )
2)2		return
2)2		end
2)2		function item(histyp,iname)
2)2	!function to convert a histo name (4-char from track) to
2)2	!an item number (from xlate:names.trk file)
2)2	!call is:
2)2	!	???=item(histyp,iname)
2)2	!where:
2)2	!	histyp is the array containing the 4-char abbrevs
2)2	!	iname is the name we ae searching for
2)2		include 'xlate.com/nolist'
2)2		integer histyp(mxhist)
2)2		DO 4190 I=1,MXHIST
2)2		IF (ITMNAM .EQ. HISTYP(I)) GOTO 4200
2)2	4190	CONTINUE
2)2		WRITE (UNIOUT,10027)ITMNAM,RPTNUM
2)2		TYPE 10027,ITMNAM,RPTNUM
2)2	4200	continue
2)2		item=i
2)2		return
2)2	10027	FORMAT(////'   ???? UNKNOWN DATA ITEM TYPE:  "',
2)2		1 A4, '"  IN REPORT# ',I5, '  ????',///)
2)2		end
