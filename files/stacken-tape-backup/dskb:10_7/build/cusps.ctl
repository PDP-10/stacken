;*******************************************************************************
;CUSPS.CTL - Master control file to build cusps
;
;VERSION 1(17)
;EDIT 1 - BEGUN MAY 1979 BY R/E.
;[2] CHANGE NETWOR TO LOAD SCAN AND HELPER
;[3] REMOVE /CREF FROM SYSERR SINCE WITH LISTING FILES IT WOULD REQUIRE TOO MUCH DISK SPACE
;[4] ADD KDPLDR SECTION
;[5] UPDATE BOOTS SECTION
;[6] CHANGE AVAIL TO USE /R FOR SELF CONTAINED PROGRAM
;[7] BRING INITIA AND OPSER SECTIONS UPTODATE
;[10] USE LINK AND /SSAVE TO GET REPRODUCIBLE CHECKSUMS
;[11] FIX UP THE BOOTM SECTION TO BUILD ALL NECESSARY VERSIONS
;[12] ADD SECTION TO BUILD BOOT
;[13] TAKE BOOT OUT; NOW ON MONITOR TAPE
;[14] TAKE BOOTS OUT; NOW ON UNSUPPORTED TAPE
;     ALSO FIX UP A FEW OTHER FILES
;[15] Add build procedure for DDT11.
;[16] Add build procedures for CATLOG, NCPTAB, NFT, NRT, and SWIL.
;[17] Add LP20 build procedures.
;[20] Fix for LOGIN/LOGOUT final merge.
;
;-----
;Running CUSPS:
;
;Submit CUSPS with the following command:
;	.SUBMIT CUSPS[,]/TAG:cusp,cusp
;where "cusp" is replaced by the cusp name, such as SETSRC or BACKUP.
;
;-----
;Requirements:
;1)	The sources and associated files that make up a cusp are located
;	in an SFD dedicated to that cusp.
;2)	Programs required to build the cusp(s) reside in the UFD. These
;	are Macro, Link, Cref, etc.
;
;Note:	This control file will also work if SFDs are not used. However,
;	the directory may contain other files not associated with the
;	particular cusp being built.
;
;-----
;If this control file is not started at a specific tag, a checksummed directory
;of the files needed to build all cusps will be taken.
;*******************************************************************************
;
.SET WATCH VERSION
.NOERROR
.DIRECT/CHECKS MACRO.EXE,LINK.EXE,LNK???.EXE,CREF.EXE,COMPIL.EXE,DIRECT.EXE
;
.GOTO EXIT
ACCT::
;*******************************************************************************
;                               ACCT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	UUOSYM.UNV
;	GLXMAC.UNV
;	ORNMAC.UNV
;	QSRMAC.UNV
;	ACTSYM.UNV
;	RMSINT.UNV
;	RMS.REL
;	B36LIB.REL
;	GLXINI.REL
;	ACTDAE.MAC
;	ACTLIB.MAC
;	ACTCUS.MAC
;	REACT.MAC
;Output files:
;	ACTDAE.EXE
;	REACT.EXE
.SET WATCH VERSION FILES
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP/MACRO ACTLIB,ACTCUS,REACT,ACTDAE,ACTRCD
.IF (ERROR) .GOTO DIR
;
.R LINK
*ACTDAE/SSAVE=/LOC/SYMSEG:LOW/SEGMENT:LOW -
*ACTDAE,ACTLIB/SEARCH,ACTCUS/SEARCH, -
*OPRPAR/SEARCH,SYS:RMS,SYS:B361LB/SEARCH/GO
.IF (ERROR) .GOTO DIR
.R LINK
*REACT/SSAVE=/LOC/SYMSEG:LOW/SEGMENT:LOW -
*ACTLIB/SEARCH/INCLUDE:ACTPRM, -
*REACT,ACTLIB/SEARCH,ACTCUS/SEARCH, -
*OPRPAR/SEARCH,SYS:RMS,SYS:B361LB/SEARCH/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
ACTSYM::
;*******************************************************************************
;				ACTSYM
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	ACTSYM.MAC
;
;Output files:
;	ACTSYM.UNV
;	ACTSYM.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL ACTSYM.MAC
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
BACKUP::
;*******************************************************************************
;				BACKUP
;*******************************************************************************
;
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	BACKRS.MAC
;	BACKUP.MAC
;	ENDECR.MAC
;	USGSUB.MAC
;
;Output files:
;	BACKUP.EXE
;	BACKUP.HLP
;	BACKUP.LST
;	ENDECR.REL
;	USGSUB.REL
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP ENDECR.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP USGSUB.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP BACKUP.MAC,BACKRS.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*BACKUP/SSAVE=BACKUP,BACKRS/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
CTHNRT::
;*******************************************************************************
;				CTHNRT
;*******************************************************************************
;
;
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	CTHNRT.MAC
;Output files:
;	CTHNRT.HLP
;	CTHNRT.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /COMP CTHNRT.MAC
.IF (ERROR)  .GOTO DIR
;
.R LINK
*CTHNRT/SSAVE=CTHNRT/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
BOOTDX::
;*******************************************************************************
;				BOOTDX
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	BOOTDX.HLP
;	BOOTDX.MAC
;	DXMCA.ADX
;	DXMPA.A8
;
;Output files:
;	BOOTDX.EXE
;	BOOTDX.MEM
;	BOOTDX.LST
;	A8DDT.MEM
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP BOOTDX.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*BOOTDX/SAVE=BOOTDX/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
COMPIL::
;*******************************************************************************
;				COMPIL
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	COMPIL.MAC
;
;Output files:
;	COMPIL.EXE
;	COMPIL.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP COMPIL.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*COMPIL/SSAVE=COMPIL/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
CREF::
;*******************************************************************************
;				CREF
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	CREF.MAC
;
;Output files:
;	CREF.EXE
;	CREF.HLP
;	CREF.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP CREF.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*CREF/SSAVE=CREF,REL:HELPER/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
CRSCPY::
;*******************************************************************************
;				CRSCPY
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN
;Required files:
;	CRSCPY.MAC
;
;Output files:
;	CRSCPY.EXE
;	CRSCPY.HLP
;	CRSCPY.MEM
;	CRSCPY.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP CRSCPY.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*CRSCPY/SSAVE=CRSCPY/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DAEMON::
;*******************************************************************************
;				DAEMON
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	DAEMON.MAC
;
;Output files:
;	DAEMON.EXE
;	DAEMON.LST
;
;
.COMPIL /CREF /COMP DAEMON.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*DAEMON/SSAVE=DAEMON/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
D60JSY::
;*******************************************************************************
;				D60JSY
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	D60JSY.MAC
;	D60UNV.MAC
;
;Output files:
;	D60JSY.REL
;	D60UNV.UNV
;	
;
.ASSIGN DEC SYS
.ASSIGN DEC REL
.ASSIGN DEC UNV
;
.COMPIL /COMP D60UNV.MAC
.IF (ERROR) .GOTO DIR
.COMPIL /COMP D60JSY.MAC
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON

DDT::
;*******************************************************************************
;				DDT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	JOBDAT.REL
;	MACTEN.REL
;	UUOSYM.REL
;	JOBDAT.UNV
;	MACTEN.UNV
;	UUOSYM.UNV
;Required files:
;	DDT.MAC
;	F1EDDT.MAC
;	F1FDDT.MAC
;	F1UDDT.MAC
;	F1VDDT.MAC
;
;Output files:
;	DDT41A.MEM
;	DDT.EXE		(EXECUTABLE DDT WITH SYMBOLS)
;	DDT.LST
;	DDT.REL		(USER MODE DDT)
;	EDDT.REL	(EXEC MODE DDT)
;	FILDDT.REL	(FILE DDT)
;	VMDDT.REL	(USER MODE VIRTUAL MEMORY DDT)
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
;Make DDT.REL
.COMPILE /CREF /COMP DDT.REL=F1UDDT.MAC+DDT.MAC
.IF (ERROR)  .GOTO DIR
;
;Make EDDT.REL
.COMPILE /CREF /COMP EDDT.REL=F1EDDT.MAC+DDT.MAC
.IF (ERROR)  .GOTO DIR
;
;Make FILDDT.REL
.COMPILE /CREF /COMP FILDDT.REL=F1FDDT.MAC+DDT.MAC
.IF (ERROR)  .GOTO DIR
;
;Make VMDDT.REL
.COMPILE /CREF /COMP VMDDT.REL=F1VDDT.MAC+DDT.MAC
.IF (ERROR)  .GOTO DIR
;
;HERE TO MAKE THE NEW .EXE FILES REPLETE WITH SYMBOLS
LOAD::
.CHKPNT LOAD
.ERROR ?
;
;Make DDT.EXE
.R LINK
*/NOINITIAL/LOCALS/SYMSEG:LOW/PATCHS:2K DDT.REL/NOLOCALS, -
*REL:JOBDAT.REL, REL:MACTEN.REL, REL:UUOSYM.REL/GO
.IF (ERROR)  .GOTO DIR
.DDT
=HRLZ 1,.JBSYM^[X
=HRR 1,.JBSYM^[X
=MOVE 2,.JBFF^[X
=SUB 2,.JBREL^[X
=ADDI 2,1777^[X
=SUBI 1,(2)^[X
=MOVE 2,.JBREL^[X
=SUBI 2,2000^[X
=HRRM 1,.JBUSY^[X
=HRRM 1,.JBSYM^[X
=BLT 1,(2)^[X
=MOVSI 3,1(2)^[X
=IORI 3,DDT^[X
=HRLM 2,.JBCOR^[X
=CORE 2,^[X
=MOVEM 3,.JBSA^[X
=HLRM 3,.JBFF^[X
=HRRM 3,.JBREN^[X
=.JBVER/
*%%DDT
=PAT../
*D:
=0<17>0^[Z
=05M
*^C
.SAVE DDT
;
;Make FILDDT.EXE
.R LINK
*FILDDT/SAVE=FILDDT.REL/GO
.IF (ERROR)  .GOTO DIR
;
;Make VMDDT.EXE
.R LINK
*VMDDT/SAVE=VMDDT.REL/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
DDT11::
;*******************************************************************************
;				DDT11
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	DDTSYM.MAC
;	DDTGP.MAC
;	DDTFIL.MAC
;	DDTSIM.MAC
;	DDT11.MAC
;
;Output files:
;
;	DDT11.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/COMP DDTSYM
.IF (ERROR) .GOTO DIR
.COMPIL/COMP DDTGP
.IF (ERROR) .GOTO DIR
.COMPIL/COMP DDTFIL
.IF (ERROR) .GOTO DIR
.COMPIL/COMP DDTSIM
.IF (ERROR) .GOTO DIR
.COMP/COMP DDT11
.IF (ERROR) .GOTO DIR
.R LINK
*DDT11/SAVE
*DDTFIL,DDTGP,DDTSIM,DDT11
*/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DECLAR::
;*******************************************************************************
;				DECLAR
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	DECLAR.MAC
;
;Output files:
;	DECLAR.EXE
;	DECLAR.HLP
;	DECLAR.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP DECLAR.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*DECLAR/SSAVE=DECLAR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DIRECT::
;*******************************************************************************
;				DIRECT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	DIRECT.MAC
;
;Output files:
;	DIRECT.EXE
;	DIRECT.HLP
;	DIRECT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP DIRECT.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*DIRECT/SSAVE=DIRECT/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DTELDR::
;*******************************************************************************
;				DTELDR
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	DTELDR.MAC
;
;Output files:
;	DTELDR.EXE
;	DTELDR.HLP
;	DTELDR.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP DTELDR.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*DTELDR/SSAVE=DTELDR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
F11::
;*******************************************************************************
;				F11
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	F11.MAC
;
;Output files:
;
;	F11.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMP F11.MAC
.IF (ERROR) .GOTO COMMON
;
R LINK
*F11/SSAVE=F11/GO
.IF (ERROR) .GOTO COMMON
;
.GOTO COMMON
FAL::
;*******************************************************************************
;				FAL
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	JOBDAT.UNV
;	MACTEN.UNV
;	UUOSYM.UNV
;	ACTSYM.UNV
;	SWIL.UNV
;	GLXMAC.UNV
;	QSRMAC.UNV
;	ORNMAC.UNV
;	SWIL.REL
;	GLXLIB.REL

;	FAL.MAC
;
;Output files:
;	FAL.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /COMP FAL.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*FAL/SSAVE=/LOC/SYMSEG:LOW FAL/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
FILCOM::
;*******************************************************************************
;				FILCOM
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	FILCOM.MAC
;
;Output files:
;	FILCOM.EXE
;	FILCOM.HLP
;	FILCOM.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP FILCOM.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*FILCOM/SSAVE=FILCOM/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
HELP::
;*******************************************************************************
;				HELP
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	HELP.MAC
;
;Output files:
;	HELP.EXE
;	HELP.HLP
;	HELP.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP HELP.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*HELP/SSAVE=HELP/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
INITIA::
;*******************************************************************************
;				INITIA
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	INITIA.MAC
;
;Output files:
;	INITIA.EXE
;	INITIA.HLP
;	INITIA.LST
;	INITIA.MEM
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/CREF /COMP INTPRM
.COMPIL /CREF /COMP INITIA.MAC,INTCUS.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*INITIA/SSAVE=INITIA,INTCUS/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
JOBDAT::
;*******************************************************************************
;				JOBDAT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	JOBDAT.MAC
;
;Output files:
;	JOBDAT.LST
;	JOBDAT.REL
;	JOBDAT.UNV
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP JOBDAT.MAC
.IF (ERROR)  .GOTO DIR
;
;MAKE TEMP FILE TO FORCE UNIVERSALS
.COPY UNV.MAC=TTY:
	%..UNV==0

;
;COMPILE AGAIN TO GET JOBDAT.UNV
.R MACRO
*JOBDAT=UNV.MAC,JOBDAT.MAC
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
KDPLDR::
;***********************************************************************
;		KDPLDR
;****************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;Required files:
;	KDPLDR.MAC
;
;Output files:
;	KDPLDR.EXE
;	KDPLDR.HLP
;	KDPLDR.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP KDPLDR
.IF (ERROR) .GOTO DIR
.R LINK
*KDPLDR/SAVE=KDPLDR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
LOGIN::
;*******************************************************************************
;				LOGIN
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	LOGIN.MAC
;	ACTSYM.UNV
;
;Output files:
;	LOGIN.EXE
;	LOGOUT.EXE
;	LOGIN.HLP
;	LOGIN.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP LOGIN.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*LOGIN/SSAVE=LOGIN/GO
.IF (ERROR) .GOTO DIR
.COPY LOGOUT.EXE=LOGIN.EXE
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
LP20::
;*******************************************************************************
;				LP20
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	GLXMAC.UNV
;	ORNMAC.UNV
;	OPRPAR.REL
;Required files:
;	LP20.MAC
;
;Output files:
;	LP20.EXE
;	LP20.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP LP20.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*LP20/SSAVE=LP20/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MACRO::
;*******************************************************************************
;				MACRO
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	MACRO.MAC
;
;Output files:
;	MACRO.EXE
;	MACRO.HLP
;	MACRO.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP MACRO.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*MACRO/SSAVE=MACRO/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MACSYM::
;*******************************************************************************
;				MACSYM
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	MACSYM.MAC
;
;Output files:
;	MACSYM.UNV
;	MACSYM.MEM
;	MACSYM.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*MACSYM,MACSYM/C=MACSYM
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
MAKLIB::
;*******************************************************************************
;				MAKLIB
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	MAKLIB.MAC
;
;Output files:
;	MAKLIB.EXE
;	MAKLIB.HLP
;	MAKLIB.LST
;	MAKLIB.MAN
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP MAKLIB.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*MAKLIB/SSAVE=MAKLIB/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MIC::
;*******************************************************************************
;				MIC
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	MIC.MAC
;
;Output files:
;	MIC.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP MIC.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*MIC/SSAVE=MIC/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MONSYM::
;*******************************************************************************
;				MONSYM
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	MONSYM.MAC
;
;Output files:
;	MONSYM.UNV
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*MONSYM,MONSYM=MONSYM
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NCPTAB::
;*******************************************************************************
;				NCPTAB
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;Required files:
;	NCPTAB.MAC
;
;Output files:
;	NCPTAB.REL
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*NCPTAB,NCPTAB=NCPTAB
.IF (ERROR) .GOTO DIR
;
.ERROR %
;CHECK FOR THE BLISSABLE PROGRAM.  IF IT'S AVAILABLE, MAKE APPROPRIATE NCPTABS
.DIR SYS:MONINT.EXE
.IF (ERROR) .GO TO COMMON
.ERROR ?

.R MONINT
*NCPTAB
.IF (ERROR) .GOTO DIR

.R BLISS
*NCPTAB=NCPTAB/LIBRARY
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NETGEN::
;*******************************************************************************
;				NETGEN
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	UUOSYM.UNV
;	GLXMAC.UNV
;	ORNMAC.UNV
;	MACSYM.UNV
;	GLXINI.REL
;	OPRPAR.REL
;	NGNMAC.MAC
;	NETGEN.MAC
;	NGNPRM.MAC
;	NGNPRS.MAC
;	NGNDEV.MAC
;	NGNDIA.MAC
;	NGNCNF.MAC
;	NGNFIN.MAC
;	NGNDAT.MAC
;
;Output files:
;	NETGEN.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL NGNMAC.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NETGEN.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NGNPRM.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NGNPRS.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NGNDEV.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NGNDIA.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NGNCNF.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NGNFIN.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL NGNDAT.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*/ERRORLEVEL:1,/SYMSEG:LOW,/SEGMENT:LOW,NETGEN/SAVE
*GLXLIB/EXCLUDE:GLXINI
*NETGEN.REL,NGNPRS.REL,NGNPRM.REL,NGNDEV.REL,NGNCNF.REL,NGNFIN.REL,NGNDIA.REL,NGNDAT.REL,OPRPAR.REL 
/SAVE/GO
;
.GOTO COMMON
NFT::
;*******************************************************************************
;				NFT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	NFT.MAC
;	NIP.MAC
;	TSC.MAC
;
;Output files:
;	NFT.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL NFT.MAC , NIP.MAC , TSC.MAC
.IF (ERROR) .GOTO DIR
.R LINK
/LOCALS/SYMSEG:HIGH NFT/SAV=NFT/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NIPGEN::
;*******************************************************************************
;				NIPGEN
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	UUOSYM.UNV
;	GLXMAC.UNV
;	GLXINI.REL
;	NIPGEN.MAC
;
;Output files:
;	NIPGEN.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL NIPGEN.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*NIPGEN/SAVE=NIPGEN/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NETLDR::
;*******************************************************************************
;				NETLDR
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	NETLDR.MAC
;
;Output files:
;	NETLDR.EXE
;	NETLDR.HLP
;	NETLDR.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP NETLDR.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*NETLDR/SSAVE=NETLDR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NETWOR::
;*******************************************************************************
;				NETWOR
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;Required files:
;	NETWOR.MAC
;
;Output files:
;	NETWOR.EXE
;	NETWOR.HLP
;	NETWOR.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF/COMP NETWOR
.IF (ERROR)  .GOTO DIR
.R LINK
*NETWOR/SSAVE=NETWOR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NOPAG0::
;*******************************************************************************
;				NOPAG0
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	NOPAG0.MAC
;
;Output files:
;	NOPAG0.EXE
;	NOPAG0.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP NOPAG0.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*NOPAG0/SSAVE=NOPAG0/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
OPSER::
;*******************************************************************************
;				OPSER
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	OPSER.MAC
;
;Output files:
;	OPSER.EXE
;	OPSER.HLP
;	OPSER.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP OPSER.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*OPSER/SSAVE=OPSER/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
PATH::
;*******************************************************************************
;			PATH
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	SCNMAC.UNV
;	JOBDAT.UNV
;	MACTEN.UNV
;	UUOSYM.UNV
;
;Required files:
;	PATH.MAC
;
;Output files:
;	PATH.EXE
;	PATH.HLP
;	PATH.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMP PATH.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*PATH/SSAVE=PATH/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
PIP::
;*******************************************************************************
;				PIP
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	PIP.MAC
;
;Output files:
;	PIP.EXE
;	PIP.HLP
;	PIP.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP PIP.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*PIP/SSAVE=PIP/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
PROJCT::
;*******************************************************************************
;				PROJCT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	ACTRCD.REL
;	MACTEN.REL
;	UUOSYM.REL
;Required files:
;	PROJCT.MAC
;
;Output files:
;	PROJCT.EXE
;	PROJCT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP PROJCT.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*PROJCT/SAVE=PROJCT/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
QUOLST::
;*******************************************************************************
;				QUOLST
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	QUOLST.MAC
;
;Output files:
;	QUOLST.EXE
;	QUOLST.HLP
;	QUOLST.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP QUOLST.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*QUOLST/SSAVE=QUOLST/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
RSXT10::
;*******************************************************************************
;				RSXT10
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	MACSYM.UNV
;	UUOSYM.UNV
;Required files:
;	RSXT10.MAC
;	RSXCMN.MAC
;	RSXTTL.MAC
;
;Output files:
;	RSXT10.EXE
;	RSXFMT.HLP
;	RSXT10.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMPILE/CREF RSXTTL.MAC+RSXT10.MAC+RSXCMN.MAC
.IF (ERROR)  .GOTO DIR
;
.R LINK
*RSXT10/SAVE=RSXCMN/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SCDSET::
;*******************************************************************************
;				SCDSET
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	FORT??.REL
;Required files:
;	SCDSET.FOR
;	SCDEXE.MAC
;
;Output files:
;	SCDSET.EXE
;	SCDSET.LST
;	SCDSET.MEM
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP SCDSET.FOR,SCDEXE.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*SCDSET/SSAVE=/OTS:NONSHARE SCDSET,SCDEXE /SEG:LOW/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SETSRC::
;*******************************************************************************
;				SETSRC
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	SETSRC.MAC
;
;Output files:
;	SETSRC.EXE
;	SETSRC.HLP
;	SETSRC.LST
;	SETSRC.MEM
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP SETSRC.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*SETSRC/SSAVE=SETSRC/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SYSTAT::
;*******************************************************************************
;				SYSTAT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	SYSTAT.MAC
;
;Output files:
;	SYSTAT.EXE
;	SYSTAT.HLP
;	SYSTAT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP SYSTAT
.IF (ERROR)  .GOTO DIR
.R LINK
*SYSTAT/SSAVE=SYSTAT/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
TECO::
;*******************************************************************************
;				TECO
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	TECO.MAC
;	TECO.ERR
;
;Output files:
;	TECO.EXE
;	TECO.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP TECO.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*TECO/SSAVE=TECO/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
TKB36::
;*******************************************************************************
;				TKB36
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	BLISS.EXE
;	BCREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;
;	ANYBLK.REQ	FILE.REQ	PSECT.REQ	TFIO10.BLI
;	B361LB.REL	FILSW.REQ	RLDD.REQ	TKB36.BLI
;	BCOR.BLI	GLOBL.REQ	RLDH.REQ	TKBLIB.R36
;	BFIO.BLI	LIBR.REQ	ROOT.REQ	TSKDEF.REQ
;	BLOCKH.REQ	MISC.BLI	STGM.BLI	WMAP.BLI
;	BLOCKT.REQ	MODU.REQ	TEXTD.REQ	WSTB.BLI
;	CHAIN.REQ	MSGH.BLI	TEXTH.REQ	WTSK.BLI
;	CMDS.BLI	PCHN.BLI
;
;
;
;Output files:
;	TKB36.EXE
;
.SET WATCH FILES
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R BLISS
*TKBLIB,TKBLIB=TKBLIB/LIBRARY/KL10/CREF
*BCOR,BCOR,BCOR=BCOR/KL10/CREF
*BFIO,BFIO,BFIO=BFIO/KL10/CREF
*CMDS,CMDS,CMDS=CMDS/KL10/CREF
*MISC,MISC,MISC=MISC/KL10/CREF
*MSGH,MSGH,MSGH=MSGH/KL10/CREF
*PCHN,PCHN,PCHN=PCHN/KL10/CREF
*STGM,STGM,STGM=STGM/KL10/CREF
*TFIO10,TFIO10,TFIO10=TFIO10/KL10/CREF
*TKB36,TKB36,TKB36=TKB36/KL10/CREF
*WMAP,WMAP,WMAP=WMAP/KL10/CREF
*WSTB,WSTB,WSTB=WSTB/KL10/CREF
*WTSK,WTSK,WTSK=WTSK/KL10/CREF
.IF (ERROR)  .GOTO DIR
;

.R BCREF
*TKB36.XRF=BCOR,BFIO,CMDS,MISC,MSGH,PCHN,STGM,TFIO10,TKB36,WMAP,WSTB,WTSK
.IF (ERROR)  .GOTO DIR
;
.R LINK
*/LOCALS/SYMSEG:HIGH/ERRORLEVEL:5 -
*BCOR,BFIO,CMDS,MISC,MSGH,PCHN,STGM,TFIO10,TKB36,WMAP,WSTB,WTSK
*TKB36/SSAVE/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
UFDSET::
;******************************************************************************
;				UFDSET
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	JOBDAT.UNV
;Required files:
;	UFDSET.MAC
;
;Output files:
;	UFDSET.REL
;	UFDSET.LST
;	UFDPRM.UNV
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP UFDSET.MAC
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
UUOSYM::
;*******************************************************************************
;				UUOSYM
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	UUOSYM.MAC
;
;Output files:
;	UUOSYM.REL
;	UUOSYM.UNV
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*UUOSYM,UUOSYM=UUOSYM
.IF (ERROR) .GOTO DIR

.ERROR %
;CHECK FOR THE BLISSABLE PROGRAM.  IF IT'S AVAILABLE, MAKE APPROPRIATE UUOSYMS
.DIR SYS:MONINT.EXE
.IF (ERROR) .GO TO COMMON
.ERROR ?

.R MONINT
*UUOSYM
.IF (ERROR) .GOTO DIR

.R BLISS
*UUOSYM=UUOSYM/LIBRARY
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
VNP36::
;*******************************************************************************
;				VNP36
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	BCREF.EXE
;	BLISS.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	ANYBLK.REQ	GLOBL.REQ	PSECT.REQ	VFIO10.BLI
;	BLOCKH.REQ	MCBFNC.BLI	RSTB.BLI	VNP36.BLI
;	BLOCKT.REQ	MISC.BLI	RSXFNC.BLI	VNPDAT.REQ
;	CBTA.BLI	MODU.REQ	RTXT.BLI	VNPDML.REQ
;	CHAIN.REQ	MSGH.BLI	STGM.BLI	VNPLIB.R36
;	FILE.REQ	PCHN.BLI	TSKDEF.REQ	VNPVAL.REQ
;	
;
;Output files:
;
;	VNP36.EXE
;
.SET WATCH FILES
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R BLISS
*VNPLIB,VNPLIB=VNPLIB/LIBRARY/KL10/CREF
*CBTA,CBTA,CBTA=CBTA/KL10/CREF
*MCBFNC,MCBFNC,MCBFNC=MCBFNC/KL10/CREF
*MISC,MISC,MISC=MISC/KL10/CREF
*MSGH,MSGH,MSGH=MSGH/KL10/CREF
*PCHN,PCHN,PCHN=PCHN/KL10/CREF
*STGM,STGM,STGM=STGM/KL10/CREF
*RSTB,RSTB,RSTB=RSTB/KL10/CREF
*RSXFNC,RSXFNC,RSXFNC=RSXFNC/KL10/CREF
*RTXT,RTXT,RTXT=RTXT/KL10/CREF
*VFIO10,VFIO10,VFIO10=VFIO10/KL10/CREF
*VNP36,VNP36,VNP36=VNP36/KL10/CREF
.IF (ERROR)  .GOTO DIR
;
.R BCREF
*VNP36.XRF=CBTA,MCBFNC,MISC,MSGH,PCHN,STGM,RSTB,RSXFNC,RTXT,VFIO10,VNP36
.IF (ERROR)  .GOTO DIR
;
.R LINK
*/LOCALS/SYMSEG:HIGH/ERRORLEVEL:5 -
*CBTA,MCBFNC,MISC,MSGH,PCHN,STGM,RSTB,RSXFNC,RTXT,VFIO10,VNP36
*VNP36/SSAVE/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
;*******************************************************************************
;BUILD.CTL - Master control file to build 'Special Catagory A' cusps
;
;-----
;Running BUILD:
;
;Submit BUILD with the following command:
;	.SUBMIT BUILD[,]/TAG:cusp,cusp
;where "cusp" is replaced by the cusp name, such as SETSRC or BACKUP.
;
;-----
;Requirements:
;1)	The sources and associated files that make up a cusp are located
;	in an SFD dedicated to that cusp.
;2)	Programs required to build the cusp(s) reside in the UFD. These
;	are Macro, Link, Cref, etc.
;
;Note:	This control file will also work if SFDs are not used. However,
;	the directory may contain other files not associated with the
;	particular cusp being built.
;
;-----
;If this control file is not started at a specific tag, a checksummed directory
;of the files needed to build all cusps will be taken.
;*******************************************************************************
;
.SET WATCH VERSION
.NOERROR
.DIRECT/CHECKS MACRO.EXE,LINK.EXE,LNK???.EXE,CREF.EXE,COMPIL.EXE,DIRECT.EXE
;
.GOTO EXIT
AVAIL::
;*************************************************************************
;			AVAIL
;*************************************************************************
;
;Required cusps:
;	COMPIL.exe
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	COBOL?.EXE
;	LIBOL.EXE
;Required files:
;	AVAIL.CBL
;	AVLLOD.CCL
;	ERRUNV.MAC
;	REDERR.MAC
;	SYRUNV.MAC
;
;Output files:
;	AVAIL.EXE
;	AVAIL.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*SYRUNV=SYRUNV
.IF (ERROR) .GOTO DIR
.R MACRO
*ERRUNV=ERRUNV
.IF (ERROR) .GOTO DIR
;
.COMPILE /COMP /CREF REDERR
.IF (ERROR) .GOTO DIR
;
;COMPILE WITH /R TO FORCE LIBOL INTO HIGH SEGMENT
;  YIELDING A SELF CONTAINED PROGRAM
.R COBOL
*AVAIL=AVAIL/O/P/R
.IF (ERROR) .GOTO DIR
.R LINK
*@AVLLOD
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
C::
;*******************************************************************************
;				C
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;	PIP.EXE
;Required files:
;	CHEAD.MAC
;	MACTEN.MAC
;	UUOSYM.MAC
;
;Output files:
;	C.MAC
;	C.UNV
;	C.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R PIP
*C.MAC=CHEAD.MAC,MACTEN.MAC,UUOSYM.MAC
.IF (ERROR) .GOTO DIR
.COMPIL /CREF /COMPIL TTY:+DSK:C.MAC
*%.C==-3
=
=
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
CREDIR::
;*******************************************************************************
;				CREDIR
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;	C.UNV
;Required files:
;	CREDIR.MAC
;
;Output files:
;	CREDIR.EXE
;	CREDIR.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL CREDIR.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*CREDIR/SSAVE=CREDIR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DELFIL::
;*******************************************************************************
;				DELFIL
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	DELFIL.MAC
;
;Output files:
;	DELFIL.EXE
;	DELFIL.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMPIL DELFIL.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*DELFIL/SSAVE=DELFIL/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DSKLST::
;*******************************************************************************
;				DSKLST
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	DSKLST.MAC
;
;Output files:
;	DSKLST.EXE
;	DSKLST.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL DSKLST.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*DSKLST/SSAVE=DSKLST/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DSKRAT::
;*******************************************************************************
;				DSKRAT
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	DSKRAT.MAC
;
;Output files:
;	DSKRAT.EXE
;	DSKRAT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL DSKRAT.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*DSKRAT/SSAVE=DSKRAT/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
FE::
;*******************************************************************************
;				FE
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	MACSYM.UNV
;Required files:
;	FE.MAC
;
;Output files:
;	FE.EXE
;	FE.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL FE.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*FE/SSAVE=FE/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
FEFILE::
;*******************************************************************************
;				FEFILE
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	FEFILE.MAC
;
;Output files:
;	FEFILE.EXE
;	FEFILE.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL FEFILE.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*FEFILE/SSAVE=FEFILE/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
FILDAE::
;*******************************************************************************
;				FILDAE
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	SCAN.REL
;Required files:
;	FILDAE.MAC
;
;Output files:
;	FILDAE.EXE
;	FILDAE.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL FILDAE.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*FILDAE/SAVE =/SEGMENT:LOW FILDAE,REL:SCAN/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
GLOB::
;*******************************************************************************
;				GLOB
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;Required files:
;	GLOB.MAC
;
;Output files:
;	GLOB.EXE
;	GLOB.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL GLOB.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*GLOB/SSAVE=GLOB/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
HELPER::
;*******************************************************************************
;				HELPER
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;	MACTEN.UNV
;	UUOSYM.UNV
;Required files:
;	HELPER.MAC
;
;Output files:
;	HELPER.REL
;	HELPER.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL HELPER.MAC
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
MACTEN::
;*******************************************************************************
;				MACTEN
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	MACTEN.MAC
;
;Output files:
;	MACTEN.UNV
;	MACTEN.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL MACTEN.MAC
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
RUNOFF::
;*******************************************************************************
;				RUNOFF
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	SCAN.REL
;	WILD.REL
;Required files:
;	RUNOFF.MAC
;
;Output files:
;	RUNOFF.EXE
;	RUNINP.HLP
;	RUNOFF.HLP
;	RUNOFF.KDB
;	RUNOFF.MCR
;	RUNOFF.LST
;	RNFDOC.STD
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL RUNOFF.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*RUNOFF/SSAVE=RUNOFF/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SCAN::
;*******************************************************************************
;				SCAN
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;	MACTEN.UNV
;	UUOSYM.UNV
;Required files:
;	SCAN.MAC
;	SCNMAC.MAC
;
;Output files:
;	SCAN.REL
;	SCAN.LST
;	SCNMAC.LST
;	SCNMAC.UNV
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMP TTY:+DSK:SCNMAC.MAC(P,,),SCAN.MAC(P,,)
*%.C==-3
=
=
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SMFILE::
;*******************************************************************************
;				SMFILE
;*******************************************************************************
;
;Required cusps:
;	MACRO.EXE
;	LINK.EXE
;	LNK???.EXE
;
;Required files:
;	GMAC.MAC
;	GSCN.MAC
;	GKBD.MAC
;	GCOM.MAC
;	SMFILE.MAC
;	SMPREB.MAC
;
;Output file:
;
;	SMFILE.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC REL
.ASSIGN DEC UNV
.ASSIGN DEC BLI
;
.R MACRO
*GMAC,GMAC=GMAC
*SMFILE,SMFILE=SMFILE
*GSCN,GSCN=GSCN,GKBD,GCOM
*SMPREB,SMPREB=SMPREB
.IF (ERROR) .GOTO DIR
;
.R LINK
*SMFILE.EXE/SAV=SMFILE,SMPREB,GSCN/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SOUPR::
;*******************************************************************************
;				SOUPR
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	CAMPAR.MAC
;	MERGE.MAC
;	PARSE.MAC
;	PRS.MAC
;	UPDATE.MAC
;
;Output files:
;	COMPAR.EXE
;	MERGE.EXE
;	UPDATE.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /COMPILE /CREF PRS,PARSE,COMPAR,MERGE,UPDATE
.IF (ERROR) .GOTO DIR
.R LINK
*COMPAR/SSAVE=COMPAR,PARSE/SEARCH/GO
.IF (ERROR) .GOTO DIR
.R LINK
*UPDATE/SSAVE=UPDATE,PARSE/SEARCH/GO
.IF (ERROR) .GOTO DIR
.R LINK
*MERGE/SSAVE=MERGE,PARSE/SEARCH/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SWIL::
;*******************************************************************************
;				SWIL
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	SWIL.MAC
;	SWIFIL.MAC
;	SWIWLD.MAC
;	SWILIO.MAC
;	SWINET.MAC
;	SWISCN.MAC
;	SWIHLP.MAC
;	SWIQUE.MAC
;	SWIERM.MAC
;	SWITOU.MAC
;	SWIMEM.MAC
;	SWIMSC.MAC
;
;Output files:
;	SWIL.REL
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
SWIL=SWIL
SWIFIL=SWIFIL
SWIWLD=SWIWLD
SWILIO=SWILIO
SWINET=SWINET
SWISCN=SWISCN
SWIHLP=SWIHLP
SWIQUE=SWIQUE
SWIERM=SWIERM
SWITOU=SWITOU
SWIMEM=SWIMEM
SWIMSC=SWIMSC
.IF (ERROR) .GOTO DIR
;COMBINE INTO SWIL.REL
.R PIP
SWIL.REL/I = SWIFIL.REL, SWIWLD.REL, SWILIO.REL, SWINET.REL, SWISCN.REL, SWIHLP.REL, SWIQUE.REL, SWIERM.REL, SWITOU.REL, SWIMEM.REL, SWIMSC.REL
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SYSDPY::
;*******************************************************************************
;				SYSDPY
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	SYSDPU.MAC
;	SYSDPY.MAC
;
;Output files:
;	SYSDPY.EXE
;	SYSDPA.EXE
;	SYSDPB.EXE
;	SYSVBX.EXE
;	SYSV50.EXE
;	SYSV52.EXE
;	SYSV61.EXE
;	SYSHZL.EXE
;	SYSDLT.EXE
;	SYSANS.EXE
;	SYSDPY.LST
;	SYSDPA.LST
;	SYSDPB.LST
;	SYSVBX.LST
;	SYSV50.LST
;	SYSV52.LST
;	SYSV61.LST
;	SYSHZL.LST
;	SYSDLT.LST
;	SYSANS.LST
;	SYSDPY.MAN
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
;MAKE A KL F.MAC SINCE WE DON'T SHIP IT ANYMORE WITH 7.03
.R MONGEN
*NO
*PROMPT
*F
*FKL.MAC
*KL10
*YES
.R MACRO
*NUL:=FKL/U
*NUL:=S/U
*NUL:=NETPRM/U
*NUL:=MACSYM/U
*NUL:=D36PAR/U
*NUL:=SYSDPU/U
.IF (ERROR) .GOTO SYSDP2
*SYSDPY=TTY:,DSK:SYSDPY
*V.DISP==0			;VT06 terminal
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSDPA=TTY:,DSK:SYSDPY
*V.DISP==1			;VT05A terminal
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSDPB=TTY:,DSK:SYSDPY
*V.DISP==2			;VT05B terminal
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSVBX=TTY:,DSK:SYSDPY
*V.DISP==3			;VB10C display
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSV50=TTY:,DSK:SYSDPY
*V.DISP==5			;VT50 DECscope
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSV52=TTY:,DSK:SYSDPY
*V.DISP==6			;VT52 DECscope
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSV61=TTY:,DSK:SYSDPY
*V.DISP==4			;VT61 DECscope
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSHZL=TTY:,DSK:SYSDPY
*V.DISP==20			;Hazeltine 2000 terminal
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSDLT=TTY:,DSK:SYSDPY
*V.DISP==21			;Delta Data Telterm terminal
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
*SYSANS=TTY:,DSK:SYSDPY
*V.DISP==7			;VT100 or other ANSI terminal
=^Z
=^Z
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSDPY/SSAVE=SYSDPY/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSDPA/SSAVE=SYSDPA/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSDPB/SSAVE=SYSDPB/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSVBX/SSAVE=SYSVBX/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSV50/SSAVE=SYSV50/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSV52/SSAVE=SYSV52/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSV61/SSAVE=SYSV61/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSHZL/SSAVE=SYSHZL/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSDLT/SSAVE=SYSDLT/GO
.IF (ERROR) .GOTO SYSDP2
.R LINK
*SYSANS/SSAVE=SYSANS/GO
.IF (ERROR) .GOTO SYSDP2
;
.GOTO COMMON
SYSDP2::
.DELETE FKL.MAC
.GOTO DIR
WILD::
;*******************************************************************************
;				WILD
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;	HELPER.REL
;	MACTEN.UNV
;	UUOSYM.UNV
;Required files:
;	WILD.MAC
;
;Output files:
;	WILD.REL
;	WILD.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL WILD.MAC
.IF (ERROR)  .GOTO DIR
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
