C F7T2
C	Test program for DEC-10/20 Fortran Version 7
C	This program performs minimal confidence test on DIX

C THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
C OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
C
C COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1985.
C ALL RIGHTS RESERVED.

C Facility: DIX-TEST
C
C Edit History:
C
C new_version (2, 0)
C
C Edit (%O'23', '13-Apr-84', 'Sandy Clemens')
C %(  Add new DIX V2 tests to DXT2:.  )%
C
C Edit (%O'26', '17-Jul-84', 'Sandy Clemens')
C %(  Change the DIX ICS tests so that they do not print out the
C     values of the destination buffers.  Since what COBOL and what
C     FORTRAN prints out is different, it causes confusion.
C     FILES:  C36T2.CBL, F7T2.FOR, F32T2.VAX-FOR
C )%
C 
C Edit (%O'31', '8-Oct-84', 'Sandy Clemens')
C %(  Put in new copyright notices.  FILES:  C36T2.CBL, C32T2.VAX-COB,
C     F7T2.FOR, F32T2.VAX-FOR  )%


C Here are a DEC-20 record, shown as seen in DEC-20 memory and as seen
C in VAX memory, in octal, decimal and binary, and a VAX record
C containing the proper converted equivalent values, represented in as
C many forms.
C
C DEC-20 FORM OF TEST RECORD:
C 
C Descr
C Nam     Fld	Type	Lng	Scal	Contents	Comments
C -----	  ---	----	---	----	--------	--------
C STR20	  1	ASCII-7	7		"Abc(12)"
C 	  2	ASCII-7	3		Nulls		Filler
C SBF20	  3	SBF36		2	21474836.47
C FLT20	  4	FLOAT-36		3.1415925E+00
C DN20	  5	DN6TS	5	3	"2479+"		Interpret as
C	  						numeric +2.479
C PD20	  6	PD9	5	2	-134.79		Sign char = dec 13;
C	  						COB36 PIC S999V99
C 
C DEC: {           27015512064            }{        -33408571294              }
C OCT: {3  1  1  2  2  0  0  0  0  0  0  0}{4  0  7  0  5  4  3  2  4  1  4  2}
C  20: {       20 WORD N+1                }{          20 WORD N               }
C INT: {  2  }{  )  }{       FILL        }X{  A  }{  b  }{  c  }{  (  }{  1  }X
C BIT: 011001001010010000000000000000000000100000111000101100011010100001100010
C VAX: <= N+8 }{         VAX WORD N+4         }{       VAX WORD N             }
C OCT: 5  4  4}{2 4  4  0  0  0  0  0  0  1  0}{0 7  0  5  4  3  2  4  1  4  2}
C DEC: <=     }{      -1543503864             }{          951167074           }
C 
C -----------------------------------------------------------------------------
C 
C DEC: {          17553718994             }{        2147483647                }
C OCT: {2  0  2  6  2  2  0  7  7  3  2  2}{0  1  7  7  7  7  7  7  7  7  7  7}
C  20: {         20 WORD N+3              }{       20 WORD N+2                }
C INT: {   FLOAT-36: 3.1415926E+00        }{   SBF36: 2147483647              }
C BIT: 010000010110010010000111111011010010000001111111111111111111111111111111
C VAX: <= N+16        }{        VAX WORD N+12         }{      VAX WORD N+8   =>
C OCT: <=4  0  5  4  4}{2 0  7  7  3  2  2  0  1  7  7}{3 7  7  7  7  7  7  7=>
C DEC: <=             }{      -2014502785             }{      -156           =>
C 
C -----------------------------------------------------------------------------
C 
C DEC: {          2568829440              }{         19669029568              }
C OCT: {0  2  3  1  0  7  2  3  5  0  0  0}{2  2  2  4  2  7  3  1  1  3  0  0}
C  20: {         20 WORD N+5              }{       20 WORD N+4                }
C INT: {         PD9 -134.79		  }{       DN6TS: 2479+               }
C BIT: 000010011001000111010011101000000000010010010100010111011001001011000000
C VAX: <= WORD N+24           }{        VAX WORD N+20         }{  WORD N+16  =>
C OCT:  0  2  3  1  0  7  2  3}{2 4  0  0  1  1  1  2  1  3  5}{2 2  2  6  0  0
C DEC: <=    627155           }{     -1610312611              }{ -1832894108 =>
C 
C -----------------------------------------------------------------------------
C 
C BIT:                                                                 00000000
C VAX:                                                                 { N+24=>
C OCT:                                                                 {0 0  0
C DEC:                                                                 {     =>
C 
C =============================================================================
C 
C VAX FORM OF TEST RECORD:
C 
C Descr
C Nam	  Fld	Type	Lng	Scal	Contents	Comments
C -----	  ---	----	---	----	--------	--------
C STRVAX  1	ASCII-8	7		"Abc(12)"
C 	  2	ASCII-8	1		Nulls		Filler
C SBFVAX  3	SBF32		2	21474836.47
C FLTVAX  4	D-FLOAT			3.141592562198639E0
C DNVAX	  5	DN8LO	4	3	"2479"		Interpret as
C	  						numeric +2.479
C PDVAX	  6	PD8	5	2	-134.79		Sign char = dec 13,
C							COB32 PIC S999V99
C 
C Note: The value given here for the D_Float field is the correct
C conversion from SBF36 3.1415926E0.  Since D_Float is a form of greater
C precision, there is no difficulty in conversion:  The same string of
C mantissa bits, properly represented for the other system, is used.
C 
C DEC: {         2699825              }{          677601857           }
C OCT: {0 0  0  1  2  2  3  1  0  6  1}{0 5  0  3  0  6  6  1  1  0  1}
C VAX: {       VAX WORD N+4           }{        VAX WORD N            }
C INT: {      }{  )   }{  2   }{   1  }{  (   }{  c   }{   b  }{  A   }
C BIT: 0000000000101001001100100011000100101000011000110110001001000001
C  20: <=      20 WORD N+1        }{             20 WORD N            }
C OCT:   0  0  0  5  1  1  4  4  3}{0  4  5  0  3  0  6  6  1  1  0  1}
C DEC: <=    -268266717           }{           4972569153             }
C 
C DEC: {       2147483647             }
C OCT: {1 7  7  7  7  7  7  7  7  7  7}
C VAX: {       VAX WORD N+8           }
C INT: {       21474836.47            }
C BIT: 01111111111111111111111111111111
C  20: <=    20 WORD N+2      }{ N+1 =>
C OCT:  3  7  7  7  7  7  7  7}{7  7 6
C DEC: <=    5528092671       }{     =>
C 
C -----------------------------------------------------------------------------
C 
C DEC: {         16384                }{         265961801            }
C OCT: {0 0  0  0  0  0  4  0  0  0  0}{0 1  7  6  6  4  4  0  5  1  1}
C VAX: {         VAX WORD N+16        }{         VAX WORD N+12        }
C INT: {                3.1415926E00                                  }
C BIT: 0000000000000000010000000000000000001111110110100100000101001001
C  20: <=  20 WORD N+4}{        20 WORD N+3               }{  N+2    =>
C OCT:   0  0  0  0  0}{2  0  0  0  0  0  1  7  6  6  4  4}{0  5  1  1 
C DEC: <=             }{        17179934116               }{         =>
C 
C -----------------------------------------------------------------------------
C 
C DEC: {         10307347             }{          959919154           }
C OCT: {0 0  0  4  7  2  4  3  4  2  3}{0 7  1  1  5  6  3  2  0  6  2}
C VAX: {         VAX WORD N+24        }{         VAX WORD N+20        }
C INT: {       	  PD8 -134.79	      }{         DN8LO "2479"         }
C BIT: 0000000010011101010001110001001100111001001101110011010000110010
C  20: <= N+6 }{           20 WORD N+5            }{    20 WORD N+4  =>
C OCT: 0  0  0}{4  7  2  4  3  4  2  3  1  6  2  3}{3  4  6  4  1  4  4
C DEC: <= 0   }{          -26500582509            }{    30940463104  =>
C 
C -----------------------------------------------------------------------------
C 
C BIT:                                    {0000000000000000000000000000
C 20:                                     {                          =>
C OCT:                                    { 0  0  0  0  0  0  0  0  0=>
C DEC:                                    {                          =>
C

C	Include the DIL interface files
	INCLUDE 'SYS:DILV7'
	INCLUDE 'SYS:DIXV7'

C	Foreign field descriptors
	INTEGER STR20 (3), SBF20 (3), FLT20 (3), DN20 (3), PD20 (3)
	INTEGER STRVAX (3), SBFVAX (3), FLTVAX (3), DNVAX (3), PDVAX (3)

C	BUFFERS
	INTEGER SRCDAT (6)
	INTEGER DSTDAT (7)

C	VARIABLES
	INTEGER TEST, STAT

C	Initialize foreign field descriptors
	TEST = 1
	STAT = XDESCR (STR20, SRCDAT, SYS36, 7, 0, 0, ASCII7, 7, 0)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 2
	STAT = XDESCR (SBF20, SRCDAT, SYS36, 36, 2, 0, SBF36, 0, 2)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 3
	STAT = XDESCR (FLT20, SRCDAT, SYS36, 36, 3, 0, FLOT36, 0, 0)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 4
	STAT = XDESCR (DN20, SRCDAT, SYS36, 6, 24, 0, DN6TS, 5, 3)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 5
	STAT = XDESCR (PD20, SRCDAT, SYS36, 9, 20, 0, PD9, 5, 2)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 6
	STAT = XDESCR (STRVAX, DSTDAT, SYSVAX, 8, 0, 0, ASCII8, 7, 0)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 7
	STAT = XDESCR (SBFVAX, DSTDAT, SYSVAX, 8, 8, 0, SBF32, 0, 2)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 8
	STAT = XDESCR (FLTVAX, DSTDAT, SYSVAX, 8, 12, 0, DFLOAT, 0, 0)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 9
	STAT = XDESCR (DNVAX, DSTDAT, SYSVAX, 8, 20, 0, DN8LO, 4, 3)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 10
	STAT = XDESCR (PDVAX, DSTDAT, SYSVAX, 8, 24, 0, PD8, 5, 2)
	IF (STAT.NE.NORMAL) GOTO 777

C	INITIALIZE SRC BUFFER
C 	Data is as described at top.
	SRCDAT (1) = -33408571294
	SRCDAT (2) = 27015512064
	SRCDAT (3) = 2147483647
	SRCDAT (4) = 17553718994
	SRCDAT (5) = 19669029568
	SRCDAT (6) = 2568829440

C	INITIALIZE DESTINATION BUFFER TO ZEROS
	DO 10 I = 1, 7
10	DSTDAT (I) = 0

C	DO CONVERSIONS
	WRITE (5, 1001)
1001	FORMAT (' Doing conversions')
C
	TEST = 11
	STAT = XCVST (STR20, STRVAX)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 12
	STAT = XCVFB (SBF20, SBFVAX)
	IF (STAT.NE.NORMAL) GOTO 777
	TEST = 13
	STAT = XCGEN (FLT20, FLTVAX)
	IF (STAT.NE.NORMAL) GOTO 777

	TEST = 14
	STAT = XCVDN (DN20, DNVAX)
	IF (STAT.NE.NORMAL) GOTO 777

	TEST = 15
	STAT = XCVPD (PD20, PDVAX)
	IF (STAT.NE.NORMAL) GOTO 777

	WRITE (5, 781)
781	FORMAT (' Tests through 15 completed successfully')

C	GO TO 100			[%O'26']
	GO TO 101

C	PRINT ERROR INFORMATION

777	WRITE (5, 778) TEST, STAT
778	FORMAT (' ? Failure in test ', I4, ' Status = ', I10)
	STOP


C	CHECK RESULTS
C	What we should have created is the VAX form of the record as 
C	described in the comments at the head of this program.

C this is now debug only		[%O'26']
C 100	DO 20 I = 1, 7			[%O'26']
C 20	WRITE (5, 779) I, DSTDAT (I)	[%O'26']
C 779	FORMAT (' DSTDAT sub ', I3, ' = ', I12)	[%O'26']

101	TEST = 16
	IF (DSTDAT (1) .NEQ. 4972569153) GO TO 777
	TEST = 17
	IF (DSTDAT (2) .NEQ. -268266717) GO TO 777
	TEST = 18
	IF (DSTDAT (3) .NEQ. 5528092671) GO TO 777
	TEST = 19


C	Since the initial precision is only float-36, the full D_float
C	precision will not be produced in the answer.
C	D_Float is exactly like F_Float for the first word.  The second
C	word consists entirely of lower-order mantissa bits.  In our
C	example, however, mantissa bits cannot be manufactured from nowhere.
C	Float-36 has 26 mantissa bits.  F_Float has 24 (first one hidden).
C	Therefore, 2 bits, which happen to be 10, will overflow into the
C	second word of the D_Float.  The remainder of that word
C       (vax word N+16) will be 0.  Lay this out on the chart, and you will
C	see that 20 word n+3 will thus be 200000,,176644, or 17179934116.
	IF (DSTDAT (4) .NEQ. 17179934116) GO TO 777
	TEST = 20
	IF (DSTDAT (5) .NEQ. 30940463104) GO TO 777
	TEST = 21
	IF (DSTDAT (6) .NEQ. -26500582509) GO TO 777
	TEST = 22
	IF (DSTDAT (7) .NEQ. 0) GO TO 777

	WRITE (5, 780)
780	FORMAT (' Tests through 22 successfully completed')

C	TRY A COUPLE OF ERROR CASES

C	GET AN UNKNOWN SYSTEM OF ORIGIN ERROR AND VERIFY USE OF UNKSYS
	TEST = 23
	STAT = XDESCR (STR20, SRCDAT, 3, 7, 0, 0, ASCII7, 7, 0)
	IF (STAT .NEQ. UNKSYS) GO TO 777

C	GET AN INVALID DATA TYPE ERROR AND VERIFY USE OF DATTYP
	TEST = 24
	STAT = XDESCR (STR20, SRCDAT, SYS36, 7, 0, 0, -75, 7, 0)
	IF (STAT .NEQ. DATTYP) GO TO 777
	
	WRITE (5, 782)
782	FORMAT (' Tests through 24 successfully completed')

	WRITE (5, 783)
783	FORMAT (' F7T2 successfully completed')

	END
