DCNSPY::
;******************************************************************************
;                               DCNSPY
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
;	S.UNV		(7.03)
;	D36PAR.UNV	(7.03)
;	NETPRM.UNV	(7.03)
;	MACSYM.UNV	(7.03)
;	SCNMAC.UNV
;	UUOSYM.UNV
;	DPYDEF.UNV
;	DPY.REL
;	SCAN.REL
;	HELPER.REL
;	DCNSPY.MAC
;
;Output files:
;	DCNSPY.EXE

.GOTO TOPS10
@GOTO TOPS20
TOPS10::
;******************************************************************************
;                               DCNSPY-10
;******************************************************************************

.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
.PATH [,,DCNSPY]
.PATH FOO:/SEARCH = [10,701,MON,KL]

.SET WATCH VERSION

.DIRECT /CHECK /SLOW DCNSPY.MAC

.COMPILE /COMPILE/CREF DCNSPY.MAC
.AS DSK LPT
.CREF

.R LINK
*DCNSPY /SSAVE = DCNSPY /GO

.DIRECT /CHECK /SLOW DCNSPY.EXE

.PLEASE	DCNSPY-10 Assembly Successful
.GOTO END

%ERR::  .GOTO ERROR
%TERR:: .GOTO ERROR

ERROR:: .PLEASE Error during DCNSPY-10 assembly
.GOTO END

TOPS20::
;******************************************************************************
;                               DCNSPY-20
;******************************************************************************

@PLEASE DCNSPY-20 Assembly not supported
.GOTO END

%ERR::  @GOTO ERROR
%TERR:: @GOTO ERROR

ERROR:: @PLEASE Error during DCNSPY-20 assembly

END::
%FIN::
;[End of DCNSPY.CTL]
