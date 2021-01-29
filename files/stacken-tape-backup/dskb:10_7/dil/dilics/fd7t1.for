C FD7T1

C	This program opens a remote  file named DAP.TST and writes  an
C	ASCII record into it,  closes the file,  reopens the file  and
C	reads the record back and  then closes the file again.   NOTE:
C	This  program  reads  and  writes  the  file  DAP.TST  from  a
C	directory called [5,33].   If this  directory does  not
C	exist, it must be created as a valid login directory.

C THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
C OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
C
C COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1985.
C ALL RIGHTS RESERVED.

C
C Facility: DIT-TEST
C 
C Edit History:
C 
C new_version (1, 0)
C 
C Edit (%O'1', '15-Dec-82', 'Sandy Clemens')
C %(  Add the DIT (Dap and Task-to-task) Installation Verification tests
C     for the VAX and DECSYSTEM-20 to the library.  
C     Files:  DITTHST.TXT (NEW), CD32T1.VAX-COB (NEW),
C     CT32T1.VAX-COB (NEW), FD32T1.VAX-FOR (NEW),
C     FT32T1.VAX-FOR (NEW), CD36T1.CBL (NEW), CT36T1.CBL (NEW),
C     FD6T1.FOR (NEW), FD7T1.FOR (NEW), FT6T1.FOR (NEW),
C     FT7T1.FOR (NEW) )%
C
C Edit (%O'2', '14-Jan-83', 'Sandy Clemens')
C %(  Many edits to the Installation Verification system (ICS)  files.
C     Add SYS:  to all  the  10/20 programs  in  the COPY  or  INCLUDE
C     statement for the interface files.   Add SYS$LIBRARY to the  VAX
C     programs in  the COPY  or INCLUDE  statement for  the  interface
C     files.  Add check for INFO or  SUCCESS status return in all  ICS
C     programs.  Remove node names from all DIT programs so that local
C     node is used.  Change  directory used by 20  DAP programs to  be
C     PS:<DIL-TEST> with  password  DIL-TEST.   Remove  all  directory
C     specifications  from  VMS  programs  so  they  use  the  default
C     connected directory.   Add Lib$Match_Cond  to VMS  programs  for
C     status checking.  Change some of the symbolic variable names for
C     clarification.   Change  use  of  numeric  parameter  values  to
C     symbolic variable names.  Get rid  of use of "IMPLICIT  INTEGER"
C     in FORTRAN test programs.   Add copyright notice to  everything.
C     
C     Files: CD32T1.VAX-COB,  CD36T1.CBL, CT32T1.VAX-COB,  CT36T1.CBL,
C     FD32T1.VAX-FOR, FD6T1.FOR, FD7T1.FOR, FT32T1.VAX-FOR, FT6T1.FOR,
C     FT7T1.FOR, DITTHST.TXT )%
C     
C Edit (%O'6', '25-Jan-83', 'Sandy Clemens')
C %(  Add copyright and liability waiver to whatever needs it.
C     FILES: CD32T1.VAX-COB, CD36T1.CBL, CT32T1.VAX-COB, CT36T1.CBL,
C     FD32T1.VAX-FOR, FD6T1.FOR, FD7T1.FOR, FT32T1.VAX-FOR, FT6T1.FOR,
C     FT7T1.FOR, SUB6D1.FOR, SUB6T1.FOR, SUB7D1.FOR, SUB7T1.FOR  )%
C
C new_version (2, 0)
C
C Edit (%O'10', '17-Apr-84', 'Sandy Clemens')
C %(  Convert to run on TOPS-10 -- Doug Rayner.
C     Add remote file access ICS programs for TOPS-10. )%
C 
C Edit (%O'17', '8-Oct-84', 'Sandy Clemens')
C %(  Put in new copyright notices.  FILES:  CD36T1.10-CBL,
C     CD36T1.CBL, CD32T1.VAX-COB, CT36T1.10-CBL, CT32T1.VAX-COB,
C     FD7T1.10-FOR, FD7T1.FOR, FD32T1.VAX-FOR, FT7T1.FOR,
C     FT32T1.VAX-FOR.  )%


C Use the DIL interface files
	INCLUDE 'SYS:DITV7'
	INCLUDE 'SYS:DILV7'

C File and directory description fields
	INTEGER FNAME (8), USERID (8), PASSWD (8), ACCT (8), FNUMBR

C Sending and receiving data records
	INTEGER DATA1 (20), DATA2 (20)

C DIL Status code
	INTEGER STAT

C Record size and record unit size
	INTEGER RSIZE, RUNTSZ

	DATA FNAME /'DAP.T', 'ST[5,', '33]  ', '     ', '     ',
     1  '     ', '     ', '     '/
	DATA USERID /'[5,33',']    ', '     ', '     ',
     1  '     ', '     ', '     ', '     '/
	DATA PASSWD /'     ', '     ', '     ', '     ', '     ',
     1  '     ', '     ', '     '/
	DATA ACCT /'     ', '     ', '     ', '     ',
     1  '     ', '     ', '     ', '     '/

C Program messages
200	FORMAT (' ROPEN status return: ', I12)
201	FORMAT (' RWRITE status return: ', I12)
202	FORMAT (' RCLOSE status return: ', I12)
203	FORMAT (' RREAD status return: ', I12)
700	FORMAT ('? Invalid status returned... ')

C Request the password
900	FORMAT (' Enter the password: ')
	WRITE (5,900)
901	FORMAT (8A5)
	ACCEPT 901, PASSWD

C Open file DAP.TST for output

	RSIZE = 95
	RUNTSZ = 0

	STAT = ROPEN (FNUMBR, FNAME, USERID, PASSWD, ACCT, MWRITE,
     1		TASCII, FSTM, AUNSPC, RSIZE, RUNTSZ)

	WRITE (5,200) STAT
	IF (STAT .EQ. NORMAL) GO TO 100
	WRITE (5,700)
	STOP

C Accept a record and write it to the file

101	FORMAT (' Enter data for the record: ')
100	WRITE (5,101)
102	FORMAT (20A5)
	ACCEPT 102, DATA1
	STAT = RWRITE (FNUMBR, RUNTSZ, RSIZE, DATA1)

	WRITE (5,201) STAT
	IF (STAT .EQ. NORMAL) GO TO 103
	WRITE (5,700)
	STOP

C Close the file

103	STAT = RCLOSE (FNUMBR, ONTHNG)

	WRITE (5,202) STAT
	IF (STAT .EQ. NORMAL) GO TO 104
	WRITE (5,700)
	STOP

C Open the file to read the record

104	RSIZE = 100
	STAT = ROPEN (FNUMBR, FNAME, USERID, PASSWD, ACCT, MREAD,
     1  	TASCII, FSTM, AUNSPC, RSIZE, RUNTSZ)

	WRITE (5,200) STAT
	IF (STAT .EQ. NORMAL) GO TO 105
	WRITE (5,700)
	STOP

C Read the record

105	STAT = RREAD (FNUMBR, RUNTSZ, RSIZE, DATA2)

	WRITE (5,203) STAT
	IF (STAT .EQ. NORMAL) GO TO 106
	WRITE (5,700)
	STOP

107	FORMAT (' The record read was: ')
106	WRITE (5,107)
110	FORMAT (' ', 20A5)
	WRITE (5,110) DATA2

C Close the file

	STAT = RCLOSE (FNUMBR, ONTHNG)

	WRITE (5,202) STAT
	IF (STAT .EQ. NORMAL) GO TO 108
	WRITE (5,700)
	STOP

109	FORMAT (' FD7T1 test successful.')
108	WRITE (5,109)
	STOP
	END
