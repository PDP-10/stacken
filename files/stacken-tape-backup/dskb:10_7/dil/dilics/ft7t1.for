C FT7T1
C	Test program for the  DIT.  It opens a  passive link and  then
C	connects to itself  creating an active  link.  User  specified
C	messages are send both directions across the link, and the the
C	link is closed.

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
C Edit (%O'13', '18-May-84', 'Sandy Clemens')
C %(  Add version 1 tests to version 2 area.  FILES:  CD32T1.VAX-COB,
C     CT32T1.VAX-COB, FD32T1.VAX-FOR, FT32T1.VAX-FOR, CT36T1.CBL,
C     FT7T1.FOR
C )%
C 
C Edit (%O'17', '8-Oct-84', 'Sandy Clemens')
C %(  Put in new copyright notices.  FILES:  CD36T1.10-CBL,
C     CD36T1.CBL, CD32T1.VAX-COB, CT36T1.10-CBL, CT32T1.VAX-COB,
C     FD7T1.10-FOR, FD7T1.FOR, FD32T1.VAX-FOR, FT7T1.FOR,
C     FT32T1.VAX-FOR.  )%

C	include DIL interface files
	INCLUDE 'SYS:DITV7'
	INCLUDE 'SYS:DILV7'

C	data fields
	DIMENSION SENDDP (16), RECDP (16), SENDDA (16), RECDA (16)

C	dit parameters
	DIMENSION HOSTN (4), OPTDAT (4), OBJIDP (4), OBJIDA (4)
	DIMENSION DESCRP (4), DESCRA (4), TASKNP (4), TASKNA (4)
	DIMENSION PASSWD (8), ACCT (8), USERID (8)
		  	
	INTEGER STAT, MSGSIZ, MUNTSZ, CNTOPD, SYNCDS

C	network logical names for each "side" of the link
	INTEGER PNETLN
	INTEGER ANETLN

	DATA OPTDAT /0, 0, 0, 0/
	DATA OBJIDP /0, 0, 0, 0/
	DATA DESCRP /0, 0, 0, 0/
	DATA TASKNP /'SERVE', 'R    ', 0, 0/
	DATA HOSTN /'     ', '     ', 0, 0/
	DATA OBJIDA /'TASK ', 0, 0, 0/
	DATA DESCRA /'SERVE', 'R    ', 0, 0/
	DATA TASKNA /0, 0, 0, 0/
	DATA PASSWD /0, 0, 0, 0, 0, 0, 0, 0/
	DATA USERID /0, 0, 0, 0, 0, 0, 0, 0/
	DATA ACCT /0, 0, 0, 0, 0, 0, 0, 0/

C	initialize sending and receiveing message data fields
	DO 200 I = 1, 16
	SENDDP (I) = 0
	SENDDA (I) = 0
	RECDP (I) = 0
200	RECDA (I) = 0

C	Open a passive link

	STAT = NFOPP (PNETLN, OBJIDP, DESCRP, TASKNP, WAITLN)

150	FORMAT (' NFOPP Status return: ', I12)
	WRITE (5,150) STAT

	IF (STAT .EQ. NORMAL) GO TO 102

901	FORMAT ('? Error status returned from NFOPP: ', I12)
	WRITE (5, 901) STAT
	STOP

C	Ask for a connection to the passive link

102	STAT = NFOPA (ANETLN, HOSTN, OBJIDA, DESCRA, TASKNA,
     1  USERID, PASSWD, ACCT, OPTDAT, WAITLN)

103	FORMAT (' NFOPA Status return: ', I12)
	WRITE (5,103) STAT
	
	IF (STAT .EQ. NORMAL) GO TO 104

902	FORMAT ('? Error status returned from NFOPA: ', I12)
	WRITE (5, 902) STAT
	STOP

C	Wait for confirmation of the link request

104	STAT = NFGND (PNETLN, WAITLY)

105	FORMAT (' NFGND Status return: ', I12)
	WRITE (5,105) STAT
	
	IF (STAT .EQ. NORMAL) GO TO 106
	IF (STAT .EQ. CONEVT) GO TO 106

903	FORMAT ('? Error status returned from NFGND: ', I12)
	WRITE (5, 903) STAT
	STOP

C	Accept link from self

106	CNTOPD = 0
	STAT = NFACC (PNETLN, LASCII, CNTOPD, OPTDAT)

107	FORMAT (' NFACC Status return: ', I12)
	WRITE (5,107) STAT

	IF (STAT .EQ. NORMAL) GO TO 109

904	FORMAT ('? Error status returned from NFACC: ', I12)
	WRITE (5, 904) STAT
	STOP

C	Read and send some data over the link to self

108	FORMAT (' Enter some data to be sent over the link: ', $)
109	WRITE (5, 108)

110	FORMAT (16A5)
	ACCEPT 110, SENDDP

C	Initialize number of bytes

	MSGSIZ = 80
	MUNTSZ = 7

	STAT = NFSND (ANETLN, MUNTSZ, MSGSIZ, SENDDP, MSGMSG)

111	FORMAT (' NFSND Status return: ', I12)
	WRITE (5,111) STAT

	IF (STAT .EQ. NORMAL) GO TO 112

905	FORMAT ('? Error status returned from NFSND: ', I12)
	WRITE (5, 905) STAT
	STOP

C	Read the data sent over the link

C	Initialize number of bytes

112	STAT = NFRCV (PNETLN, MUNTSZ, MSGSIZ, RECDA, MSGMSG, WAITLY)

113	FORMAT (' NFRCV Status return: ', I12)
	WRITE (5,113) STAT

	IF (STAT .EQ. NORMAL) GO TO 115

906	FORMAT ('? Error status returned from NFRCV: ', I12)
	WRITE (5, 906) STAT
	STOP

114	FORMAT (' Data received: ', 16A5)
115	WRITE (5,114) RECDA

C	Send some data over the link in the opposite direction

116	FORMAT (' Enter some data to be sent over the link: ', $)
117	WRITE (5, 116)

118	FORMAT (16A5)
	ACCEPT 118, SENDDA

C	Reinitialize number of bytes

	MSGSIZ = 80

	STAT = NFSND (PNETLN, MUNTSZ, MSGSIZ, SENDDA, MSGMSG)

119	FORMAT (' NFSND Status return: ', I12)
	WRITE (5,119) STAT

	IF (STAT .EQ. NORMAL) GO TO 120

907	FORMAT ('? Error status returned from NFSND: ', I12)
	WRITE (5, 907) STAT
	STOP

C	Read the data sent over the link the second time

C	Initialize number of bytes

120	STAT = NFRCV (ANETLN, MUNTSZ, MSGSIZ, RECDP, MSGMSG, WAITLY)

121	FORMAT (' NFRCV Status return: ', I12)
	WRITE (5,121) STAT

	IF (STAT .EQ. NORMAL) GO TO 123

908	FORMAT ('? Error status returned from NFRCV: ', I12)
	WRITE (5, 908) STAT
	STOP

122	FORMAT (' Data received: ', 16A5)
123	WRITE (5,122) RECDP

C	Close the link to self

	STAT = NFCLS (ANETLN, SYNCDS, CNTOPD, OPTDAT)

124	FORMAT (' NFCLS Status return: ', I12)
	WRITE (5,124) STAT

	IF (STAT .EQ. NORMAL) GO TO 125

909	FORMAT ('? Error status returned from NFCLS: ', I12)
	WRITE (5, 909) STAT
	STOP

125	STAT = NFGND (PNETLN, WAITLY)
	IF (STAT .EQ. ARJEVT) GO TO 126
	IF (STAT .EQ. DSCEVT) GO TO 126
	IF (STAT .EQ. NORMAL) GO TO 126
910	FORMAT ('? Error status returned from NFGND: ', I12)
	WRITE (5, 910) STAT
	STOP

127	FORMAT (' FT7T1 test successful ')
126	WRITE (5,127)
	STOP
	END
