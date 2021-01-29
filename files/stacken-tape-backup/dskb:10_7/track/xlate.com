

C	xlate.COM:  DATA DEFINITIONS FOR xlate.FOR
C THIS FILE IS INCLUDE-ED BY THE VARIOUS COMPONENTS
C OF xlate.  IT CONTAINS ALL of THE FOLLOWING
C DECLARATIONS FOR THE DATAA AREAS, HISTO-S, AND
C MISC STORAGE:

C COMMON
C DIMENSIONS
C EQUIVALENCES
C INTEGER, REAL, LOGICAL, ... STATEMENTS






	Parameter MXBTYP=15		!Max # of block types.
	Parameter MXHIST=140		!Max # Histogram Types
	parameter mxval=260		!max # values to store
					!ie-max # reports in a file

!	IO CHANNEL DEFINITIONS
	PARAMETER UNIOUT=2		!GENERAL OUTPUT FILE
	PARAMETER UNIINP=1		!TRACK'S DATA FILE
	parameter uniplt=3		!plotting output file


	DIMENSION IOLD(5)		!PREVIOUS IVECT VALUES
	DIMENSION INVECT(128)		!READ BLOCK FROM FILE HERE
	DIMENSION IDATA(40)		!READ AN ENTRY INTO HERE
	DIMENSION DATA(40)		!SAME (READ ON)
	EQUIVALENCE(IDATA,DATA)

	DIMENSION ITRANS(5)		!TRANSLATION VECTOR (SEE BELOW)


!arrays for storing data that gets written to the plot file on eof:
	real yvalue(mxhist,mxval)	!y value (mean from summ
	real xvalue(mxhist,mxval)	!x value (time of day as
					!hh.xx, where xx is fractional
					!part of an hour
	real xmin(mxhist)		!min x value seen
	real xmax(mxhist)		!max x value seen
	real ymin(mxhist)		!min y value seen
	real ymax(mxhist)		!max y value seen


	LOGICAL FLAG1			!TRUE IF IN AN ENTRY CURRENTLY
	logical sink			!if true then do not store into histos
					!(too many reports in input file)

	INTEGER	BLKTYP(MXBTYP,2)	!Translation vector from TRACK
					!Block type numbers to TRKANL numbers
				!index 1 = Table Index
				!index 2 = block ytpe number:
				!	1=TRACK block type #
				!	2=TRKANL block type #




	INTEGER	TRKVER			!VERSION WORD OF TRACK
	INTEGER	UDATIM			!UNIV DATE/TIME OF RUN
	INTEGER TTYMAX			!NUM TTY-S SYSTEM BUILD FOR
	INTEGER USRCOR,TOTMEM		!# WORDS USER,TOTAL CORE
	INTEGER RPTNUM			!NUMBER OF THIS REPORT
	INTEGER START,STOP		!UNIV DATE/TIME-S FOR START
					!AND STOP OF THIS FRAME
	INTEGER CORMAX			!# WORDS OF CURRENT CORMAX
	INTEGER SCHED			!SCHED BITS
	INTEGER DATIME			!UNIV DATE/TIME FROM HEADER
	INTEGER CPUSER			!CPU SERIAL #
					! RPTINF AT ONE TIME

	integer hihist			!highest histo# which is legal
					!depends on size of names file



	COMMON /INPUT/IOLD,INVECT,INPOS,	!INPUT AREA, POINTER
	1	IBLKNO,hihist
							!BLOCK-NUMBER
	COMMON /RECORD/ILEN,ITYPE,IDATA,IWHAT
					!FILE RECORD DATA
	COMMON /FLAGS/FLAG1,sink		!MISC FLAGS
	COMMON /MONITR/COMVER,UDATIM,JOBMAX,TTYMAX,
	1  USRCOR,TOTMEM		!MONITOR PARAMETERS
	COMMON /REPORT/RPTNUM,START,STOP,
	1  CORMAX,SCHED,RPTINF		!REPORT PARAMETERS
	COMMON /TRACK/TRKVER,INTRVL,
	1  ITERS			!TRACK & RUN PARAMETERS
	COMMON /ITMRPT/ITMNUM,ITMNAM,ITMAUX,
	1  ITMFLG,ICHANO		!ITEM INFORMATION
		!ITMNUM IS HISTOGRAM NUMBER (HISTYP INDEX)
		!ITMNAM IS ASCII HISTOGRAM NAME
		!ITMAUX IS AUX ENTRY FOR HISTO
		!ITMFLG IS
		!ICHANO IS BINARY NUMBER OF LAST CHANNEL (1,2,3,..)


	COMMON/SWTCHS/SWDTAL

	common/minmax/ymin,ymax,xmin,xmax,yvalue,xvalue

