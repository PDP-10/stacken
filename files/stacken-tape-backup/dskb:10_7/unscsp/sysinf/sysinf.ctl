SYSINF::
;*******************************************************************************
;				SYSINF
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	C.UNV
;Required files:
;	INFLIB.MAC
;	INFSYM.MAC
;	SYSINF.MAC
;
;Output files:
;	SYSINF.DOC
;	SYSINF.EXE
;	SYSINF.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP INFSYM.MAC,INFLIB.MAC(P,,),SYSINF.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
@SYSINF.LNK
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
COMMON::
;*******************************************************************************
;				Common Ending
;*******************************************************************************
;
;.ASSIGN DSK LPT
;.CREF
.IF (ERROR)  .GOTO DIR
;.DEASSI LPT
;
DIR::
.NOERROR
;.DIRECT /CHECKS DSK:
;
%ERR::
%CERR::
%TERR::
;
EXIT::
%FIN::
