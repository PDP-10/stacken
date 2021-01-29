IDENTIFICATION DIVISION.

PROGRAM-ID.

	CT36T1.

AUTHOR.

	DIGITAL EQUIPMENT CORPORATION.

	This is a test program for  the DIT.  It opens a passive  link
	and then connects  to itself  creating an  active link.   User
	specified messages are sent  both directions across the  link,
	and then the link is closed.

* THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
* OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
*
* COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1985.
* ALL RIGHTS RESERVED.

*
* Facility: DIT-TEST
* 
* Edit History:
* 
* new_version (1, 0)
* 
* Edit (%O'1', '15-Dec-82', 'Sandy Clemens')
* %(  Add the DIT (Dap and Task-to-task) Installation Verification tests
*     for the VAX and DECSYSTEM-20 to the library.  
*     Files:  DITTHST.TXT (NEW), CD32T1.VAX-COB (NEW),
*     CT32T1.VAX-COB (NEW), FD32T1.VAX-FOR (NEW),
*     FT32T1.VAX-FOR (NEW), CD36T1.CBL (NEW), CT36T1.CBL (NEW),
*     FD6T1.FOR (NEW), FD7T1.FOR (NEW), FT6T1.FOR (NEW),
*     FT7T1.FOR (NEW) )%
*     
* Edit (%O'2', '14-Jan-83', 'Sandy Clemens')
* %(  Many edits to the Installation Verification system (ICS)  files.
*     Add SYS:  to all  the  10/20 programs  in  the COPY  or  INCLUDE
*     statement for the interface files.   Add SYS$LIBRARY to the  VAX
*     programs in  the COPY  or INCLUDE  statement for  the  interface
*     files.  Add check for INFO or  SUCCESS status return in all  ICS
*     programs.  Remove node names from all DIT programs so that local
*     node is used.  Change  directory used by 20  DAP programs to  be
*     PS:<DIL-TEST> with  password  DIL-TEST.   Remove  all  directory
*     specifications  from  VMS  programs  so  they  use  the  default
*     connected directory.   Add Lib$Match_Cond  to VMS  programs  for
*     status checking.  Change some of the symbolic variable names for
*     clarification.   Change  use  of  numeric  parameter  values  to
*     symbolic variable names.  Get rid  of use of "IMPLICIT  INTEGER"
*     in FORTRAN test programs.   Add copyright notice to  everything.
*     
*     Files: CD32T1.VAX-COB,  CD36T1.CBL, CT32T1.VAX-COB,  CT36T1.CBL,
*     FD32T1.VAX-FOR, FD6T1.FOR, FD7T1.FOR, FT32T1.VAX-FOR, FT6T1.FOR,
*     FT7T1.FOR, DITTHST.TXT )%
*     
* Edit (%O'6', '25-Jan-83', 'Sandy Clemens')
* %(  Add copyright and liability waiver to whatever needs it.
*     FILES: CD32T1.VAX-COB, CD36T1.CBL, CT32T1.VAX-COB, CT36T1.CBL,
*     FD32T1.VAX-FOR, FD6T1.FOR, FD7T1.FOR, FT32T1.VAX-FOR, FT6T1.FOR,
*     FT7T1.FOR, SUB6D1.FOR, SUB6T1.FOR, SUB7D1.FOR, SUB7T1.FOR  )%
*     
* Edit (%O'7', '25-Jan-83', 'Sandy Clemens')
* %(  Standardize "Author" entry in ICS Cobol programs.
*     FILES: CD32T1.VAX-COB, CD36T1.CBL, CT32T1.VAX-COB, CT36T1.CBL )%
* 
* Edit (%O'13', '18-May-84', 'Sandy Clemens')
* %(  Add version 1 tests to version 2 area.  FILES:  CD32T1.VAX-COB,
*     CT32T1.VAX-COB, FD32T1.VAX-FOR, FT32T1.VAX-FOR, CT36T1.CBL,
*     FT7T1.FOR
* )%
* 
* Edit (%O'17', '8-Oct-84', 'Sandy Clemens')
* %(  Put in new copyright notices.  FILES:  CD36T1.10-CBL,
*     CD36T1.CBL, CD32T1.VAX-COB, CT36T1.10-CBL, CT32T1.VAX-COB,
*     FD7T1.10-FOR, FD7T1.FOR, FD32T1.VAX-FOR, FT7T1.FOR,
*     FT32T1.VAX-FOR.  )%

INSTALLATION.

	DEC-MARLBORO.

DATE-WRITTEN.

	NOVEMBER 5, 1982.

ENVIRONMENT DIVISION.

CONFIGURATION SECTION.

SOURCE-COMPUTER.

	DECSYSTEM-20.

OBJECT-COMPUTER.

	DECSYSTEM-20.

INPUT-OUTPUT SECTION.

DATA DIVISION.

WORKING-STORAGE SECTION.

01  INTERFACE-FILES.
    COPY DIT OF "SYS:DIL.LIB".
    COPY DIL OF "SYS:DIL.LIB".

* Dilini is necessary for DECsystem-10 and DECSYSTEM-20 Cobol only
01  DILINI-PARAMS.
    05  DIL-INIT-STATUS PIC S9(10) COMP.
    05  DIL-STATUS PIC S9(10) COMP.
    05  DIL-MESSAGE PIC S9(10) COMP.
    05  DIL-SEVERITY PIC S9(10) COMP.

01  DIL-DATA-FLDS.
    05  SEND-DATA PIC X(100) USAGE DISPLAY-7.
    05  RECEIVE-DATA PIC X(100) USAGE DISPLAY-7.

01  COUNT-OPT-DATA PIC S9(10) COMP.
01  OPT-DATA PIC X(16) DISPLAY-7 VALUE SPACES.
01  PNETLN PIC S9(10) COMP.
01  ANETLN PIC S9(10) COMP.
01  HOSTN PIC X(06) DISPLAY-7 VALUE SPACES.
01  OBJID PIC X(16) DISPLAY-7.
01  DESCR PIC X(16) DISPLAY-7.
01  TASKNAME PIC X(16) DISPLAY-7.
01  USERID PIC X(39) DISPLAY-7 VALUE SPACES.
01  PASSWD PIC X(39) DISPLAY-7 VALUE SPACES.
01  ACCT PIC X(39) DISPLAY-7 VALUE SPACES.
01  MESSAGE-SIZE PIC S9(10) COMP VALUE 100.
01  MESSAGE-SIZE-UNITS PIC S9(10) COMP VALUE 7.
01  SYNCH-DISCONN PIC S9(10) COMP VALUE 0.

PROCEDURE DIVISION.

SETUP-RETURN-CODES.
* Set up for return code values, using DILINI routine

    ENTER MACRO DILINI USING DIL-INIT-STATUS, DIL-STATUS,
				 DIL-MESSAGE, DIL-SEVERITY.

    IF DIL-INIT-STATUS NOT = 1
	DISPLAY "? Invalid return code from DILINI routine = " DIL-INIT-STATUS.


OPEN-PASSIVE.
* Open a passive link.

    MOVE SPACES TO OBJID.
    MOVE SPACES TO DESCR.
    MOVE "SERVER" TO TASKNAME.

    ENTER MACRO NFOPP USING PNETLN, OBJID, DESCR, TASKNAME, DIT-WAIT-NO.

    DISPLAY " NFOPP Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFOPP: unsuccessful status return "
	STOP RUN.

CONNECT-TO-SELF.
* Ask for a connection to the passive link

    MOVE "TASK" TO OBJID.
    MOVE "SERVER" TO DESCR.
    MOVE SPACES TO TASKNAME.

    ENTER MACRO NFOPA USING ANETLN, HOSTN, OBJID, DESCR, TASKNAME,
		      USERID, PASSWD, ACCT, OPT-DATA, DIT-WAIT-NO.

    DISPLAY " NFOPA Status return: ", DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFOPA: Invalid status returned. "
	STOP RUN.

CHECK-THE-LINK.
* Wait for confirmation of the link request

    ENTER MACRO NFGND USING PNETLN, DIT-WAIT-YES.

    DISPLAY " NFGND Status return: ", DIL-STATUS.
    IF DIL-MESSAGE = DIT-C-CONNECTEVENT NEXT SENTENCE
    ELSE DISPLAY "? NFGND: Invalid status returned: "
	 STOP RUN.

ACCEPT-LINK.
* Accept link from self

    ENTER MACRO NFACC USING PNETLN, DIT-LTYPE-ASCII, COUNT-OPT-DATA, OPT-DATA.

    DISPLAY " NFACC Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFACC: unsuccessful status return "
	STOP RUN.


SEND-SOME-DATA.
* Send some data over the link to self

    DISPLAY " Enter some data to be sent over the link: ".
    ACCEPT SEND-DATA.

    ENTER MACRO NFSND USING ANETLN, MESSAGE-SIZE-UNITS, MESSAGE-SIZE,
			    SEND-DATA, DIT-MSG-MSG.

    DISPLAY " NFSND Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFSND: unsuccessful status return "
	STOP RUN.


READ-THE-DATA.
* Read the data sent over the link

    ENTER MACRO NFRCV USING PNETLN, MESSAGE-SIZE-UNITS, MESSAGE-SIZE,
			    RECEIVE-DATA, DIT-MSG-MSG, DIT-WAIT-YES.

    DISPLAY " NFRCV Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFRCV: unsuccessful status return "
	STOP RUN.

    DISPLAY " Data received: ".
    DISPLAY RECEIVE-DATA.

SEND-SOME-DATA-BACK.
* Send some data over the link in the opposite direction.

    MOVE SPACES TO SEND-DATA RECEIVE-DATA.

    DISPLAY " Enter some data to be sent back over the link: ".
    ACCEPT SEND-DATA.

    ENTER MACRO NFSND USING PNETLN, MESSAGE-SIZE-UNITS, MESSAGE-SIZE,
			    SEND-DATA, DIT-MSG-MSG.

    DISPLAY " NFSND Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFSND: unsuccessful status return "
	STOP RUN.


READ-THE-2ND-DATA.
* Read the data sent over the link the second time

    ENTER MACRO NFRCV USING ANETLN, MESSAGE-SIZE-UNITS, MESSAGE-SIZE,
			    RECEIVE-DATA, DIT-MSG-MSG, DIT-WAIT-YES.

    DISPLAY " NFRCV Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFRCV: unsuccessful status return "
	STOP RUN.

    DISPLAY " Data received: ".
    DISPLAY RECEIVE-DATA.

CLOSE-LINK.
* Close the link to self

    ENTER MACRO NFCLS USING ANETLN, SYNCH-DISCONN, COUNT-OPT-DATA, OPT-DATA.

    DISPLAY " NFCLS Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? NFCLS: unsuccessful status return "
	STOP RUN.

    ENTER MACRO NFGND USING PNETLN, DIT-WAIT-YES.

    DISPLAY " NFGND Status return: " DIL-STATUS.
    IF DIL-MESSAGE NOT = DIT-C-ABREJEVENT AND
       DIL-MESSAGE NOT = DIT-C-DISCONNECTEVENT AND
       DIL-SEVERITY NOT = STS-K-SUCCESS
	DISPLAY "? NFGND: Invalid status returned"
	STOP RUN.

    DISPLAY " ".
    DISPLAY " CT36T1 test successful. ".
    STOP RUN.
