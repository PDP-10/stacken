IDENTIFICATION DIVISION. 

PROGRAM-ID.

	C36T2.

AUTHOR.

	DIGITAL EQUIPMENT CORPORATION.

	Test program for DEC-10/20 Cobol.

	This program performs minimal confidence test on DIX.   Please
	see program  F7T2.FOR for  a bit-by-bit  justification of  the
	initial and expected final values used here.

* THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
* OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
*
* COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1985.
* ALL RIGHTS RESERVED.

*
* Facility: DIX-TEST
*
* Edit History:
*
* new_version (2, 0)
*
* Edit (%O'23', '13-Apr-84', 'Sandy Clemens')
* %(  Add new DIX V2 tests to DXT2:.  )%
*
* Edit (%O'26', '17-Jul-84', 'Sandy Clemens')
* %(  Change the DIX ICS tests so that they do not print out the
*     values of the destination buffers.  Since what COBOL and what
*     FORTRAN prints out is different, it causes confusion.
*     FILES:  C36T2.CBL, F7T2.FOR, F32T2.VAX-FOR
* )%
* 
* Edit (%O'31', '8-Oct-84', 'Sandy Clemens')
* %(  Put in new copyright notices.  FILES:  C36T2.CBL, C32T2.VAX-COB,
*     F7T2.FOR, F32T2.VAX-FOR  )%


INSTALLATION.

	DEC-MARLBOROUGH.

DATE-WRITTEN.

	APRIL 13, 1984.


ENVIRONMENT DIVISION.

CONFIGURATION SECTION.

SOURCE-COMPUTER.

	DECSYSTEM-20.

OBJECT-COMPUTER.

	DECSYSTEM-20.

INPUT-OUTPUT SECTION.

DATA DIVISION.

WORKING-STORAGE SECTION.

* source data values

* Since VERY large numbers are going to be put into the source fields,
* and Cobol will not allow  for direct VALUE clause specifications  of
* such large numeric  values into  an S9(10) COMP  fields, the  values
* will be entered as sixbit values and then redefined as sbf36 values.

*	field	  numeric value	  sixbit
*	SRCDAT1   -33408571294    @XL:AB
*	SRCDAT2   27015512064     9*0   
*	SRCDAT3   2147483647      !_____
*	SRCDAT4   17553718994     062'[2
*	SRCDAT5   19669029568	  2479+ 
*	SRCDAT6   2568829440	  "9'3H 


01 SRC-SIXBIT PIC X(36) USAGE DISPLAY-6
			VALUE "@XL:AB9*0   !_____062'[22479+ ""9'3H ".

01 SRCDAT REDEFINES SRC-SIXBIT.
    05  SRCDAT1 PIC S9(10) COMP.
    05  SRCDAT2 PIC S9(10) COMP.
    05  SRCDAT3 PIC S9(10) COMP.
    05  SRCDAT4 PIC S9(10) COMP.
    05  SRCDAT5 PIC S9(10) COMP.
    05  SRCDAT6 PIC S9(10) COMP.

* destination data fields
01  DSTDAT PIC S9(10) COMP OCCURS 7.

* foreign field descriptors
01  FFDS.
    05  STR20 PIC S9(10) COMP OCCURS 3.
    05  SBF20 PIC S9(10) COMP OCCURS 3.
    05  FLT20 PIC S9(10) COMP OCCURS 3.
    05  DN20 PIC S9(10) COMP OCCURS 3.
    05  PD20 PIC S9(10) COMP OCCURS 3.
    05  STRVAX PIC S9(10) COMP OCCURS 3.
    05  SBFVAX PIC S9(10) COMP OCCURS 3.
    05  FLTVAX PIC S9(10) COMP OCCURS 3.
    05  DNVAX PIC S9(10) COMP OCCURS 3.
    05  PDVAX PIC S9(10) COMP OCCURS 3.

01  INTERFACE-FILES.
    COPY DIL OF "SYS:DIL.LIB".
    COPY DIX OF "SYS:DIL.LIB".

01  DILINI-PARAMS.
    05  DIL-INIT-STATUS PIC S9(10) COMP.
    05  DIL-STATUS PIC S9(10) COMP.
    05  DIL-SEVERITY PIC S9(10) COMP.
    05  DIL-MESSAGE PIC S9(10) COMP.

* success flag
01  SUCCESS-FLAG PIC X(8).
    88  OK VALUE "SUCCESS".
    88  NOT-OK VALUE "FAILURE".

* keep track of which test is running
* have to change TEST to TESTA because new version of COBOL has TEST
* as a reserved word
77  TESTA PIC S9(10) COMP.

77  SUB PIC S9(5) COMP.

PROCEDURE DIVISION.

INITIALIZE-STUFF.

    MOVE "SUCCESS" TO SUCCESS-FLAG.

    ENTER MACRO DILINI USING DIL-INIT-STATUS, DIL-STATUS,
			     DIL-MESSAGE, DIL-SEVERITY.

    IF DIL-INIT-STATUS NOT = 1
	DISPLAY "? Failure in DILINI. Dil-status = " DIL-STATUS.

* initialize destination buffer to zeros
    PERFORM INITIALIZE-DSTDAT THRU INIT-EXIT
		VARYING SUB FROM 1 BY 1 UNTIL SUB > 7.

MAKE-FFDS.

    MOVE 1 TO TESTA.
    ENTER MACRO XDESCR USING STR20(1), SRCDAT, DIX-SYS-10-20, 7, 0, 0,
			     DIX-DT-ASCII-7, 7, 0.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 2 TO TESTA.
    ENTER MACRO XDESCR USING SBF20(1), SRCDAT, DIX-SYS-10-20, 36, 2, 0,
			     DIX-DT-SBF36, 0, 2.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 3 TO TESTA.
    ENTER MACRO XDESCR USING FLT20(1), SRCDAT, DIX-SYS-10-20, 36, 3, 0,
			     DIX-DT-FLOAT-36, 0, 0.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 4 TO TESTA.
    ENTER MACRO XDESCR USING DN20(1), SRCDAT, DIX-SYS-10-20, 6, 24, 0,
			     DIX-DT-DN6TS, 5, 3.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 5 TO TESTA.
    ENTER MACRO XDESCR USING PD20(1), SRCDAT, DIX-SYS-10-20, 9, 20, 0,
			     DIX-DT-PD9, 5, 2.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 6 TO TESTA.
    ENTER MACRO XDESCR USING STRVAX(1), DSTDAT(1), DIX-SYS-VAX, 8, 0, 0,
			     DIX-DT-ASCII-8, 7, 0.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 7 TO TESTA.
    ENTER MACRO XDESCR USING SBFVAX(1), DSTDAT(1), DIX-SYS-VAX, 8, 8, 0,
			     DIX-DT-SBF32, 0, 2.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 8 TO TESTA.
    ENTER MACRO XDESCR USING FLTVAX(1), DSTDAT(1), DIX-SYS-VAX, 8, 12, 0,
			     DIX-DT-D-FLOAT, 0, 0.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 9 TO TESTA.
    ENTER MACRO XDESCR USING DNVAX(1), DSTDAT(1), DIX-SYS-VAX, 8, 20, 0,
			     DIX-DT-DN8LO, 4, 3.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 10 TO TESTA.
    ENTER MACRO XDESCR USING PDVAX(1), DSTDAT(1), DIX-SYS-VAX, 8, 24, 0,
			     DIX-DT-PD8, 5, 2.

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.


DO-CONVERSIONS.
* (20 to vax)

    DISPLAY " Doing conversions... ".

    MOVE 11 TO TESTA.
    ENTER MACRO XCVST USING STR20(1), STRVAX(1).

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.


    MOVE 12 TO TESTA.
    ENTER MACRO XCVFB USING SBF20(1), SBFVAX(1).

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.


    MOVE 13 TO TESTA.
    ENTER MACRO XCGEN USING FLT20(1), FLTVAX(1).

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.


    MOVE 14 TO TESTA.
    ENTER MACRO XCVDN USING DN20(1), DNVAX(1).

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.


    MOVE 15 TO TESTA.
    ENTER MACRO XCVPD USING PD20(1), PDVAX(1).

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
       AND DIL-SEVERITY NOT = STS-K-INFO
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.


    IF OK DISPLAY " Tests through 15 completed successfully.".

CHECK-RESULTS.
* what we should have created is the VAX form of the record as
* described in the comments in F7T1.FOR.

*    * this is now debug only * [%O'26]
*    PERFORM SHOW-RESULTS THRU SHOW-EXIT VARYING SUB FROM 1 BY 1 UNTIL SUB > 7.

    MOVE 16 TO TESTA.
    IF DSTDAT(1) NOT = 4972569153
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "  Test 16 is checking the conversions."
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 17 TO TESTA.
    IF DSTDAT(2) NOT = -268266717
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "  Test 17 is checking the conversions."
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 18 TO TESTA.
    IF DSTDAT(3) NOT = 5528092671
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "  Test 18 is checking the conversions."
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 19 TO TESTA.
* Since the  initial  precision is  only  float-36, the  full  D_float
* precision will not be  produced in the  answer.  D_Float is  exactly
* like F_Float for the first word.  The second word consists  entirely
* of lower-order  mantissa bits.   In our  example, however,  mantissa
* bits cannot be manufactured from nowhere.  Float-36 has 26  mantissa
* bits.  F_Float has 24 (first one hidden).  Therefore, 2 bits,  which
* happen to be 10, will overflow into the second word of the  D_Float.
* The remainder of that word (vax word N+16) will be 0.  Lay this  out
* on the  chart, and  you  will see  that 20  word  n+3 will  thus  be
* 200000,,176644, or 17179934116.

    IF DSTDAT(4) NOT = 17179934116
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "  Test 19 is checking the conversions."
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 20 TO TESTA.
    IF DSTDAT(5) NOT = 30940463104
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "  Test 20 is checking the conversions."
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 21 TO TESTA.
    IF DSTDAT(6) NOT = -26500582509
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "  Test 21 is checking the conversions."
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    MOVE 22 TO TESTA.
    IF DSTDAT(7) NOT = 0
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "  Test 22 is checking the conversions."
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.


   IF OK DISPLAY " Tests through 22 completed successfully. ".

ERROR-CASES.
* try a couple of error cases.

ERROR-CASE-UNKSYS.
* get and unknown system of origin error and verify use of
* dix-c-unksys

    MOVE 23 TO TESTA.
    ENTER MACRO XDESCR USING STR20(1), SRCDAT, 3, 7, 0, 0,
			     DIX-DT-ASCII-7, 7, 0.

    IF DIL-MESSAGE NOT = DIX-C-UNKSYS
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.
 

ERROR-CASE-INVDATTYP.
* get and invalid data type error and verify use of dix-c-invdattyp

    MOVE 24 TO TESTA.
    ENTER MACRO XDESCR USING STR20(1), SRCDAT, 
			     DIX-SYS-10-20, 7, 0, 0, -75, 7, 0.

    IF DIL-MESSAGE NOT = DIX-C-INVDATTYP
	MOVE "FAILURE" TO SUCCESS-FLAG
	DISPLAY "? Failure in test " TESTA " Dil-status = " DIL-STATUS.

    IF OK DISPLAY " Tests through 24 completed successfully. "
	  DISPLAY " "
	  DISPLAY " C36T2 successfully completed.".

    STOP RUN.



INITIALIZE-DSTDAT.
    MOVE 0 TO DSTDAT(SUB).
INIT-EXIT.



SHOW-RESULTS.
* [%O'26]
*    DISPLAY "DSTDAT(" SUB ") value is: " DSTDAT(SUB).  * debug only *
SHOW-EXIT.
