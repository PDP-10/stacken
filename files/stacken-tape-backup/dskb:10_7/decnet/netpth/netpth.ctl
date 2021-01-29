NETPTH::
;******************************************************************************
;                               NETPTH
;******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;
;Required files:
;	MACTEN.UNV
;	SCNMAC.UNV
;	UUOSYM.UNV
;	SCAN.REL
;	NETPTH.MAC
;
;Output files:
;	NETPTH.EXE

.GOTO TOPS10
@GOTO TOPS20
TOPS10::
;******************************************************************************
;                               NETPTH-10
;******************************************************************************

.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
.PATH [,,NETPTH]

.SET WATCH VERSION

.DIRECT /CHECK /SLOW NETPTH.MAC

.COMPILE /COMPILE/CREF NETPTH.MAC
.AS DSK LPT
.CREF

.R LINK
*NETPTH /SSAVE = NETPTH /GO

.DIRECT /CHECK /SLOW NETPTH.EXE

.PLEASE	NETPTH-10 Assembly Successful
.GOTO END

%ERR::  .GOTO ERROR
%TERR:: .GOTO ERROR

ERROR:: .PLEASE Error during NETPTH-10 assembly
.GOTO END

TOPS20::
;******************************************************************************
;                               NETPTH-20
;******************************************************************************

@PLEASE NETPTH-20 Assembly not supported
.GOTO END

%ERR::  @GOTO ERROR
%TERR:: @GOTO ERROR

ERROR:: @PLEASE Error during NETPTH-20 assembly

END::
%FIN::
;[End of NETPTH.CTL]
