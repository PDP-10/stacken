DTR::
;******************************************************************************
;                                   DTR
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
;	DTR.MAC
;
;Output files:
;	DTR.EXE

;.ASSIGN DEC SYS
;.ASSIGN DEC UNV
;.ASSIGN DEC REL
;.DECLARE DIRECT/KILL

.SET WATCH VERSION

.DIRECT /CHECK /SLOW DTSPRM.MAC, DTSCOM.MAC, DTR.MAC

.COMPILE /COMPILE/CREF DTSPRM.MAC, DTSCOM.MAC, DTR.MAC
.AS DSK LPT
.CREF

.R LINK
*DTR /SSAVE = DTR, DTSCOM /GO

.DIRECT /CHECK /SLOW DTR.EXE

.PLEASE	DTR Assembly Successful
.GOTO END

%ERR::  .GOTO ERROR
%TERR:: .GOTO ERROR

ERROR:: .PLEASE Error during DTR assembly

END::
%FIN::
;[End of DTR.CTL]
