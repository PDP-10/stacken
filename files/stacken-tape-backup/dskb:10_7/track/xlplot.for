! R Powell Nov 1982  /RBP
! R Powell Jan 1983  /RBP	added support of sending screens to printer
!				or other terminals for hardcopy

	Program xlplot			! Program to plot data points
					!from files produced by xlate.for

	Implicit integer (a - z)

	Parameter	input = 30,	! Unit for raw data input file
     +			output = 32,	! Unit for data output
     +			temp = 31,	! Unit for temporary file
     +			tty = 5,		! Unit for TTY: I/O
	1		uniplt=1,	! Unit for hardcopy of screen
     +	ttwid = 110,			!terminal width (change
     +					!format stmts if this changes)
     +	tthigh = 21,			!terminal plot height
     +	mxcsym=10			!max pos in CNTSYM to use.  Put a * in that slot
	Integer	matrix(ttwid,tthigh),		! Internal temporary storage for graph
     +		yaxis(55),		! Label for Y-axis
     +		commnt(16),		! Line of comments
     +		matln(ttwid)  		! line for printing 

	Real	x,			! x value
     +		y,			! y value
     +		xmin,			! Minimum x value
     +		xmax,			! Maximum x value
     +		ymin,			! Minimum y value
     +		ymax,			! Maximum x value
     +		xscale,			! Scaling factor for x
     +		yscale,			! Scaling factor for y
     +		yax,			! Temporary Y-ordinate
     +		xpoint(12),		! Display points on X-axis
     +		xxmin,			!minimum X value to select from input file
     +		xxmax			!maximum X value to select from input file


	Logical	xsel			! true if selecting ranges of
					! X values in input file
	logical	ploted			!we have plotted something so far
	logical	outtty			!true if output is to tty:
	logical pltopn			!true if PLT: is currently opened

	data outtty /.false./
	data ploted /.false./
	data xsel   /.false./
	data pltopn /.false./




10000	Format ($ ' input file: ')
10005	Format (16a5)
10006	FORMAT (a4,1x,55A1)
10015	Format (1x)
10020	Format (2f)
10025	Format (1x, a1 $)
10030   Format (/, ' Output to TTY:? (Y or N):  ',$)
10060	Format (/, ' Comment line: ')
11000	Format (1h1)
11010 	Format (1X,A1, f12.4, '!', 110a1)	!change if ttwid changes
11020	Format (1X,A1,12X, '!', 110a1)		!change if ttwid changes
11030	Format (1x,'Y=',a4,7x, '-',11('---------!'))	!change if ttwid changes
11040	Format (1x,'X=TIME' 12f10.2)
11050	Format (1h+, 18x, 110a1)		!change if ttwid changes
11060	FormaT (1X,A1, f12.4, '!')
11070 	Format (
	1	' DATE:  ',i2,'/',i2,'/',i2,
     +		15x, 16a5,$)
11080	Format (18x, '!')

11090	Format (/' Use all input file data, or select X-axis limits?',
     +	/,'  (ALL or SELECT):  ',$)

11092	Format (' Minimum X-value to extract from input file:  ',$)
11094	Format (' Maximum X-value to extract from input file:  ',$)

11098	Format (' Ymin='f,'  Ymax=',f,'  Yscale=',f,/,
     +	' Xmin=',f,'  Xmax=',f,'  Xscale=',f)

13001	format (a4,4f)
13002	format (/' What plots to graph?  Type:',/,
	1 '  "ALL" for all plots in input file, or',/,
	1 '  4-character TRACK name of desired plot:  ',$)
13003	format (' %No data found in file for plot "',
	1 a4,'"')
13004	format (' ?Sequence error.   YAXIS record is "',a4,'"',/,
	1 '  Scaling record is "',a4,'".  Aborting processing',/)
13005	format (a4,3(1x,i2) )		!reading date records
13006	format (a4,1x,8a5)		!reading comment records



10	Type 10000			! Ask for input file specs


	Open (	unit = input,		! Open the input file
     +		device = 'dsk',		!   default device is disk
     +		file = 'plot.dat',	!   default file name and extension
     +		mode = 'ascii',		!   raw input data is characters
     +		access = 'seqin',	!   this is a sequential input file
     +		dialog,			!   ask user for file name
     +		buffer count = 4)	!   set up 4 buffers for file

30	Type 10030			! Ask for output file specs
	Read (	tty,			! Read from tty
     +		10005,			! Output file specs string
     +		end = 999)		! Terminate on ^Z
	1			i	!get y or n

	if ( (i .eq. 'Y') .or.
	1    (i .eq. 'y') ) outtty='TTY:'

	if (outtty)
	1 open (unit=output,device='tty:',mode='ascii',
	1	access='seqout')

	if  (.not. outtty)
	1 	Open (	unit = output,
     +		device = 'dsk',
     +		file = 'outplt.dat',
     +		mode = 'ascii',
     +		access = 'seqout',
     +		dialog,
     +		record size = 130,
     +		buffer count = 2)


34	continue
	read (input,13005)i,iyr,imon,iday	!date record
	read (input,13006)i,(commnt(j),j=9,16)	!comment record

	Type 10060			! Get comment line
	Read (tty, 10005, end=999) (commnt(i),i=1,8)

	type 13002			!get name of desired plot
	accept 13001,namplt		!or 'ALL'
	if (namplt .eq. 'all')namplt='ALL'

37	type 11090			!see what he wants
	Read (tty, 10005),i
	If ( (i .ne. 'ALL') .and. (i .ne. 'all') .and.
     +		(i .ne. 'SELEC') .and. (i .ne. 'selec')) goto 37
	If ( (i .eq. 'ALL') .or. (i .eq. 'all') )goto 39	!no selection to do
	xsel=.true.
	Type 11092			!prompt for xxmin
	Read (tty,10020)xxmin
	Type 11094			!prompt for xxmax
	Read (tty,10020)xxmax

39	continue


!here to begin first/next plot
!read in y axis record, and skip until correct plot found (unless
!plotting everything)
41	continue
	read (input,10006,end=999)
	1	itype,yaxis
	if (namplt .eq. 'ALL') goto 45
	if (namplt .ne. itype) goto 41
45	continue

!read in scaling values

	read (input,13001)i,xmin,xmax,ymin,ymax
	if (i .ne. itype) goto 1100		!sequence error?

	if (.not. xsel) goto 50		!redefine min/max if selecting
	xmin=xxmin
	xmax=xxmax
50	continue

	mincnt = 0

	Xscale = (xmax - xmin)/ttwid	! Set scale factor
	Yscale = (ymax - ymin)/tthigh	!   Y-axis also

! NOW PLOT DATA FROM  FILE

	Do 70 i=1,ttwid			! Initialize matrix
	Do 70 j=1,tthigh
	  Matrix(i,j) = 0
70	Continue

80	Read (	input,13001)			! Input data file
     +		jtype,x,y			!

	if (jtype .eq. 'END') goto 90		!end of this graph
	rectot = rectot + 1 
	If (.not. xsel) goto 85		!selecting ranges of x-values?

	If ( (x .lt. xxmin) .or. (x .gt. xxmax) ) goto 80	!Ignore record

85	xloc = min0(int((x-xmin)/xscale),(ttwid-1)) + 1	!X matrix index
	yloc = min0(int((y-ymin)/yscale),(tthigh-1)) + 1	!Y matrix index
	matrix(xloc,yloc) = matrix (xloc,yloc) + 1
	If (mincnt .lt. matrix(xloc,yloc)) mincnt = mincnt + 1
	Go to 80

!here when end record seen for this graph's data - now plot it out
90	Continue
	write (output,11000)		!new page for new plot
	ploted=.true.			!and we have (almost) plotted something


	Do 120 i = 1,tthigh			! Loop over matrix lines
	Do 100 j=1,ttwid			! Convert matrix to symbols
	Matln(j) = ' '		!assume no point to plot
	IF (matrix(J,(tthigh+1)-I) .GT. 0) 
	1    Matln(j) = '*'	!   and replace matrix element
100	Continue
	  yax = Ymax - (yscale*(i-1))	! Value of Y-coordinate
	  If (mod(i-1,5).ne.0) 		! Print every 5th value
     +	    Go to 110
	Write (output, 11010, err=999)	! Print line of matrix
	1 YAXIS(I),
	1      Yax, (matln(j),j=1,ttwid)
	Go to 120
110	Write (output, 11020,err=999) 	! Line without ordinate value
	1 YAXIS(I),
	1	    (matln(j),j=1,ttwid)
120	Continue


	Write (output,11030)itype

	Do 130 i=1,12
	   Xpoint(13-i) = xmax - (i-1)*xscale*10
130	Continue

	Write (output,11040) (xpoint(i),i=1,12)  ! print X ordinates

	Write (output, 11070, err=999)
     +	  imon,iday,iyr,
     +	  (commnt(i),i=1,16)

	if (.not. outtty) goto 700

!here to see if terminal user wants to do hardcopy
150	continue
	ACCEPT 10005,IDUMMY		!PAUSE FOR A WHILE

	if (idummy .eq. ' ') goto 700			!skip if no output desired
	if ( (idummy .eq. 'e') .or. (idummy .eq. 'E') )
	1 goto 999				!user wants to exit
	if ( (idummy .eq. 'a') .or. (idummy .eq. 'a') )
	1 goto 9999				!user wants to abort

	if (.not. pltopn)
	1 	open(unit=uniplt,device='PLT',file='xlplot.plt',
	1 mode='ascii',access='append')
	pltopn=.true.				!to prevent further OPENs,
						!which imply CLOSEs, which
						!print each plot seperately
!	CALL SETWID(uniplt)		!SET TTY WIDTH TO 132

!now do the same thing again, but for device UNIPLT:


	Do 220 i = 1,tthigh			! Loop over matrix lines
	Do 200 j=1,ttwid			! Convert matrix to symbols
	Matln(j) = ' '		!assume no point to plot
	IF (matrix(J,(tthigh+1)-I) .GT. 0) 
	1    Matln(j) = '*'	!   and replace matrix element
200	Continue
	  yax = Ymax - (yscale*(i-1))	! Value of Y-coordinate
	  If (mod(i-1,5).ne.0) 		! Print every 5th value
     +	    Go to 210
	Write (uniplt, 11010, err=999)	! Print line of matrix
	1 YAXIS(I),
	1      Yax, (matln(j),j=1,ttwid)
	Go to 220
210	Write (uniplt, 11020,err=999) 	! Line without ordinate value
	1 YAXIS(I),
	1	    (matln(j),j=1,ttwid)
220	Continue


	Write (uniplt,11030)itype

	Do 230 i=1,12
	   Xpoint(13-i) = xmax - (i-1)*xscale*10
230	Continue

	Write (uniplt,11040) (xpoint(i),i=1,12)  ! print X ordinates

	Write (uniplt, 11070, err=999)
     +	  imon,iday,iyr,
     +	  (commnt(i),i=1,16)

	if ( (idummy .eq. 'll') .or. (idummy .eq. 'LL'))
	1 goto 150		!do it again




!output min/max info
700	continue
	Write (output, 11098, err=999)
     +	ymin,ymax,yscale,
     +	xmin,xmax,xscale

	go to 41					!plot next graph, if any



!here on eof
999	continue

	if (.not. ploted) type 13003,namplt	!warn if nothing ploted
	Close ( unit = output)		!close the output file
	close (unit=uniplt)
!here on an abort
9999	continue

	call exit


!here if sequence error seen (type field of scaling record not same
!as type field of preceeding yaxis label record)
1100	continue
	type 13004,itype,jtype
	goto 999

	End
