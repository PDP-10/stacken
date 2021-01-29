DTS::
;******************************************************************************
;                                   DTS
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
;	JOBDAT.UNV
;	MACSYM.UNV
;	MACTEN.UNV
;	NSCAN.UNV
;	UUOSYM.UNV
;	DTSPRM.MAC
;	DTSCOM.MAC
;	DTS.MAC
;
;Output files:
;	DTS.EXE

;.ASSIGN DEC SYS
;.ASSIGN DEC UNV
;.ASSIGN DEC REL
;.DECLARE DIRECT/KILL

.SET WATCH VERSION

.DIRECT /CHECK /SLOW DTSPRM.MAC, DTSCOM.MAC, DTS.MAC

.COMPILE /COMPILE/CREF DTSPRM.MAC, DTSCOM.MAC, DTS.MAC
.AS DSK LPT
.CREF

.R LINK
*DTS /SSAVE = DTS, DTSCOM /GO

.DIRECT /CHECK /SLOW DTS.EXE

.PLEASE	DTS Assembly Successful
.GOTO END

%ERR::  .GOTO ERROR
%TERR:: .GOTO ERROR

ERROR:: .PLEASE Error during DTS assembly

END::
%FIN::
;[End of DTS.CTL]
