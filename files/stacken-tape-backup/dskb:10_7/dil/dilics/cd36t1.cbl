IDENTIFICATION DIVISION.

PROGRAM-ID.

	CD36T1.

AUTHOR.

	DIGITAL EQUIPMENT CORPORATION.

	This program opens a remote  file named DAP.TST and writes  an
	ASCII record into it,  closes the file,  reopens the file  and
	reads the record back and then closes the file again.

	Note: this program writes and  reads the file DAP.TST using  a
	directory called [5,33].   If this  directory does  not
	exist, it must be created as a VALID login directory.

* THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
* OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
*
* COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1985.
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
* new_version (2, 0)
*
* Edit (%O'10', '17-Apr-84', 'Sandy Clemens')
* %(  Convert to run on TOPS-10 -- Doug Rayner.
*     Add remote file access ICS programs for TOPS-10. )%
*
* 
* Edit (%O'17', '8-Oct-84', 'Sandy Clemens')
* %(  Put in new copyright notices.  FILES:  CD36T1.10-CBL,
*     CD36T1.CBL, CD32T1.VAX-COB, CT36T1.10-CBL, CT32T1.VAX-COB,
*     FD7T1.10-FOR, FD7T1.FOR, FD32T1.VAX-FOR, FT7T1.FOR,
*     FT32T1.VAX-FOR.  )%

INSTALLATION.

	DEC-MARLBOROUGH.

DATE-WRITTEN.

	NOVEMBER 5, 1982.

ENVIRONMENT DIVISION.

INPUT-OUTPUT SECTION.

DATA DIVISION.

FILE SECTION.

WORKING-STORAGE SECTION.

01  INTERFACE-FILES.
    COPY DIT OF "SYS:DIL.LIB".
    COPY DIL OF "SYS:DIL.LIB".

* Dilini is necessary for DECsystem-10 and DECSYSTEM-20 Cobol only.
01  DILINI-PARAMS.
    05  DIL-INIT-STATUS PIC S9(10) COMP.
    05  DIL-STATUS PIC S9(10) COMP.
    05  DIL-SEVERITY PIC S9(10) COMP.
    05  DIL-MESSAGE PIC S9(10) COMP.

* File and directory description fields

01  FILE-NAME PIC X(39) VALUE 'DAP.TST[5,33]' DISPLAY-7.
01  USERID USAGE DISPLAY-7 PIC X(39) VALUE '[5,33]'.
01  PASSWD USAGE DISPLAY-7 PIC X(39) VALUE SPACES.
01  ACCT USAGE DISPLAY-7 PIC X(39) VALUE SPACES.

* Record and file description fields

01  FILE-NUMBER USAGE COMP PIC S9(10).
01  REC-FORMAT USAGE COMP PIC S9(10).
01  REC-ATTRIBUTES USAGE COMP PIC S9(10).
01  REC-SIZE USAGE COMP PIC S9(10) VALUE 95.
01  REC-UNIT-SIZE USAGE COMP PIC S9(10) VALUE 0.

01  DATA-RECORD USAGE DISPLAY-7 PIC X(100).

PROCEDURE DIVISION.

* Set up for return code values, using DILINI routine

    ENTER MACRO DILINI USING DIL-INIT-STATUS, DIL-STATUS,
			     DIL-MESSAGE, DIL-SEVERITY.

    IF DIL-INIT-STATUS NOT = 1
	DISPLAY "? Invalid return code from DILINI routine = " DIL-INIT-STATUS.

* Get record format

    DISPLAY " Enter the value for the record format (RFM):".
    DISPLAY " 0 = undefined,".
    DISPLAY " 1 = fixed,".
    DISPLAY " 2 = variable, ".
    DISPLAY " 3 = VFC, ".
    DISPLAY " 4 = stream".
    ACCEPT REC-FORMAT.

* Get record attributes

    DISPLAY " Enter a value for the record attributes (RAT):".
    DISPLAY " 0 = unspecified,".
    DISPLAY " 1 = implied <LF><CR> envelope,".
    DISPLAY " 2 = print file format,".
    DISPLAY " 3 = Fortran carriage control,".
    DISPLAY " 4 = MACY11 format".
    ACCEPT REC-ATTRIBUTES.

* Request the password

    DISPLAY " Enter the password: "
	WITH NO ADVANCING ACCEPT PASSWD.

* Open file DAP.TST for output

    ENTER MACRO ROPEN USING FILE-NUMBER, FILE-NAME, USERID, PASSWD, ACCT,
			    DIT-MODE-WRITE, DIT-TYPE-ASCII, REC-FORMAT,
			    REC-ATTRIBUTES, REC-SIZE, REC-UNIT-SIZE.

    DISPLAY " ROPEN Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS 
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? ROPEN: unsuccessful status return "
	STOP RUN.

* Accept a record and write it to the file

    DISPLAY " Enter data for the record for the remote file: ".
    ACCEPT DATA-RECORD.

    ENTER MACRO RWRITE USING FILE-NUMBER, REC-UNIT-SIZE,
			REC-SIZE, DATA-RECORD.

    DISPLAY " RWRITE Status return: " DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS 
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? RWRITE: unsuccessful status return. "
	STOP RUN.

* Close the file

    ENTER MACRO RCLOSE USING FILE-NUMBER, DIT-OPT-NOTHING.

    DISPLAY " RCLOSE Status return: ", DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS 
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? RCLOSE: unsuccessful status return."
	STOP RUN.

* Open the file to read the record

    MOVE 100 TO REC-SIZE.
    ENTER MACRO ROPEN USING FILE-NUMBER, FILE-NAME, USERID, PASSWD, ACCT,
		      DIT-MODE-READ, DIT-TYPE-ASCII, REC-FORMAT,
		      REC-ATTRIBUTES, REC-SIZE, REC-UNIT-SIZE.

    DISPLAY " ROPEN Status return: ", DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS 
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? ROPEN: unsuccessful status return."
	STOP RUN.

* Read the record

    MOVE SPACES TO DATA-RECORD.

    ENTER MACRO RREAD USING FILE-NUMBER, REC-UNIT-SIZE,
			    REC-SIZE, DATA-RECORD.

    DISPLAY " RREAD returned ", DIL-STATUS.
    IF DIL-SEVERITY NOT = STS-K-SUCCESS 
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? RREAD: unsuccesful status return."
	STOP RUN.

    DISPLAY " The record was: ".
    DISPLAY DATA-RECORD.

* Close the file

    ENTER MACRO RCLOSE USING FILE-NUMBER, DIT-OPT-NOTHING.

    DISPLAY " RCLOSE Status return: ", DIL-STATUS.
     IF DIL-SEVERITY NOT = STS-K-SUCCESS 
       AND DIL-SEVERITY NOT = STS-K-INFO
	DISPLAY "? RCLOSE: unsuccessful status return."
	STOP RUN.

    DISPLAY " ".
    DISPLAY " CD36T1 test successful. ".
    STOP RUN.
