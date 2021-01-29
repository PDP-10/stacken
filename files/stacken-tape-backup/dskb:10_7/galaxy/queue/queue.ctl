;[QUEUE.CTL]
;
; This control file will build the GALAXY user queue-class command
; interface and the MPB/GALAXY interface for a DECsystem-10, and the
; MPB/GALAXY interface for a DECsystem-20.  In the following list of
; files, a (10) indicates the file is required for TOPS-10 and a (20)
; for TOPS-20.
;
; Sources:	QUENCH.MAC(10)
;
; Input:	GLXMAC.UNV	HELPER.REL	ORNMAC.UNV	QSRMAC.UNV
;		SCAN.REL	SCNMAC.UNV	WILD.REL	UUOSYM.UNV
;
; Output:	QUEUE.EXE

TOPS10::
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC REL
.ASSIGN DEC UNV

.DIRECT /CHECK /SLOW QUEUE.MAC

.COMPILE/COMPILE QUEUE.MAC

.R LINK
*QUEUE/SSAVE = /LOCALS /SYMSEG:HIGH QUEUE /GO

.DIRECT /CHECK /SLOW QUEUE.EXE

.PLEASE	QUEUE Assembly Successful
.NOERROR
.DEASSIGN SYS
.SUBMIT GALAXY = /MODIFY /DEPEND:-1
.GOTO END

%CERR:: .GOTO ERROR
%ERR::  .GOTO ERROR
%TERR:: .GOTO ERROR

ERROR:: .PLEASE Error during QUEUE assembly

END::
;[End of QUEUE.CTL]
