;******************************************************************************
;BLDCST.CTL - Master control file to build unsupported cusps
;
;-----
;Running BLDCST:
;
;Submit BLDCST with the following command:
;	.SUBMIT BLDCST[,]/TAG:cusp,cusp
;where "cusp" is replaced by the cusp name, such as AID or DMPFIL.
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
AID::
;*******************************************************************************
;				AID
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
;	AID.MAC
;	KMON.MAC
;	ARITH.MAC
;	INTERP.MAC
;
;Output files:
;	AID.EXE
;	AID20A.DOC
;	AID.LST
;	KMON.LST
;	ARITH.LST
;	INTERP.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP KMON.MAC,ARITH.MAC,INTERP.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*AID/SSAVE,AID/MAP=KMON,ARITH,INTERP/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
BATCON::
;**************************************************************************
;				BATCON
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	BATCON.MAC
;
;Output files:
;	BATCON.EXE
;	BAT13.DOC
;	BATCON.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.MAKE BATPRM.MAC
*I;
;INSERT CHANGES TO DISTRIUBTED ASSEMBLY PARAMETERS HERE
;NOTE:  IF ANY PARAMETERS ARE DECIMAL NUMBERS (E.G.  DEFCOR==^D25*^D1024)
;	2 UP-ARROWS (CIRCUMFLEX) MUST BE ENTERED TO ACHIEVE 1
;		DEFCOR==^^D25*^^D1024
*;
*EX
.COMPIL /CREF /COMP BATOPR=TTY:+DSK:BATPRM.MAC+BATCON.MAC
*FTOPR==-1
=
=
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP BATPRM+BATCON.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*BATOPR/SSAVE=BATOPR,QUEUER/GO
.IF (ERROR)  .GOTO DIR
.R LINK
*BATCON/SSAVE=BATCON,QUEUER/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
BOOT11::
;*******************************************************************************
;				BOOT11
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
;	BOOT11.MAC
;
;Output files:
;	BOOT11.EXE
;	BOOT11.HLP
;	BOOT11.MEM
;	BOOT11.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP BOOT11.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*BOOT11/SSAVE=BOOT11/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
BOOTM::
;*******************************************************************************
;				BOOTM
;*******************************************************************************
;
; THIS SECTION CREATES A BOOTM FOR THE KI, KS, AND KL PROCESSORS
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	FILEX.EXE
;	RSXT10.EXE
;	CONVRT.EXE
;Required files:
;	BOOTM.MAC
;	DXLD.MAC
;	DXMCA.ADX
;	DXMPA.A8
;
;Output files:
;	BOOTMI.RDI	FOR TU70 READ-IN TAPE ON KI10
;	BOOTML.EXB	FOR RSX20F LOADING ON THE KL10
;	BOOTMS.EXE	FOR INPUT TO SMFILE TO PRODUCE KS10 VERSION
;	BOOTM.LST
;	DXLD.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP DXLD
.COMPIL /CREF /COMP TTY:+DSK:BOOTM.MAC
*MAGRIM==0	;NOT IN MAGRIM FORMAT
=
=
;
;WE NOW HAVE BOOTM.REL FOR USE WITH DXLD AND FOR LOADING ALONE TO
;PRODUCE THE KS10 BOOTM.
;
.R LINK
*DXLD/SAVE=DXLD.REL,BOOTM.REL/NOSTART/GO
.IF (ERROR) .GOTO DIR
.GET DSK:DXLD
.VERSION
.IF (ERROR) .GOTO DIR
;
;NOW MAKE BOOTMI.RDI FOR USE WITH TU70 READ-IN
.ASSIGN DSK:OUT
.RUN DXLD
.SAVE BOOTM
.COPY BOOTMI.RDI=BOOTM.RDI
;
;NOW CONVERT THE .EXE FILE TO A .SAVE FILE TO FEED INTO RSXT10
;
.R FILEX
*BOOTM.SAV=BOOTM.EXE
.IF (ERROR) .GOTO DIR
;
;NOW CONVERT THE .SAV FILE TO AN .EXB FILE FOR LOADING BY RSX20F
;
.R RSXT10
*CONVERT BOOTM.SAV BOOTML.EXB
.IF (ERROR) .GOTO DIR
;
;NOW LOAD BOOTM ALONE TO PRODUCE INPUT TO SMFILE FOR THE KS10
;
.R LINK
*BOOTMS/SAVE=BOOTM/GO
.IF (ERROR) .GOTO DIR
;
;FINALLY, CREATE BOOTMS.RDI WITH SMFILE
;WE CAN'T DO THIS UNDER BATCH BECAUSE SMFILE DOESN'T GO INTO INPUT
;WAIT SO BATCON CAN'T TELL IT WANTS ANOTHER LINE.
;
;.RUN SMFILE
;*OUTPUT MTBOOT BOOTMS.EXE BOOTMS.RDI
;*EXIT
;.IF (ERROR) .GOTO DIR
;
;NOW MAKE THE PAPER TAPE OF BOOTM IF NEEDED
;
;.COMPIL /CREF /COMP TTY:+DSK:BOOTM.MAC
;*MAGRIM==0	;NOT IN MAGRIM FORMAT
;=
;=
;.R MACRO
;*PTP:BOOTM=FTBTM,BOOTM
;THIS OBJECT PROGRAM BEING AN EXEC MODE BOOTSTRAP, THERE IS
; NO WAY TO TEST IT UNDER BATCH, SO WE LET THAT PASS.
;
.GOTO COMMON
CONFIG::
;*******************************************************************************
;				CONFIG
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
;	CONFIG.MAC
;
;Output files:
;	CONFIG.DOC
;	CONFIG.EXE
;	CONFIG.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP CONFIG.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*CONFIG/SSAVE=CONFIG/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
CONV10::
;*******************************************************************************
;				CONV10
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
;	ORNMAC.UNV
;	GLXMAC.MAC
;	UUOSYM.UNV
;	GLXINI.REL
;	OPRPAR.REL
;	CONV10.MAC
;
;Output files:
;	CONV10.EXE
;	CONV10.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMP CONV10.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*CONV10/SAVE=CONV10/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
DMPFIL::
;*******************************************************************************
;				DMPFIL
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
;	DMPFIL.MAC
;
;Output files:
;	DMPFIL.EXE
;	DML6A.DOC
;	DMPFIL.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP DMPFIL.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON

DTCOPY::
;**************************************************************************
;				DTCOPY
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	BSLDR.REL
;	COPY.MAC
;	DTCOPY.MAC
;	DTBOOT.MAC
;
;Output files:
;	DTCOPY.EXE
;	DTBOOT.REL
;	DTB4A.DOC
;	DTC007.DOC
;	DTBOOT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP COPY.MAC
.IF (ERROR)  .GOTO DIR
.SAVE
.IF (ERROR)  .GOTO DIR
.LOAD /CREF /COMP DTCOPY.MAC
.IF (ERROR)  .GOTO DIR
.SAVE
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP BSLDR.REL=TTY:+DSK:DTBOOT.MAC
*REL==1
=
=
.IF (ERROR)  .GOTO DIR
.ASSIGN DSK PTR
.RUN DTCOPY
*/L
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
DUMP::
;************************************************************************
;				DUMP
;************************************************************************
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
;	SCNMAC.MAC
;Required files:
;	C.MAC
;	DUMP.MAC
;
;Output files:
;	DUMP.EXE
;	DUMP.DOC
;	DUMP.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*=TTY:,D:C.MAC
*%.C==-3
=
*%.C==-3
=
*=TTY:,D:SCNMAC.MAC
*%.C==-3
=
*%.C==-3
=
*DUMP=DUMP
.IF (ERROR)  .GOTO DIR
.R LINK
*DUMP/SSAVE=DUMP,REL:SCAN/SEARCH,REL:HELPER/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
FAILSA::
;**************************************************************************
;				FAILSA
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	FAILSA.MAC
;
;Output files:
;	FAILSA.EXE
;	FAILSA.DOC
;	FAILSA.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP FAILSA.MAC
.IF (ERROR)  .GOTO DIR
.SAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
FILEX::
;**************************************************************************
;				FILEX
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	FILEX.MAC
;
;Output files:
;	FILEX.EXE
;	FLX17.DOC
;	FILEX.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP FILEX.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
FACTPR::
;**************************************************************************
;				FACTPR
;**************************************************************************
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
;	FACTPR.MAC
;
;OUTPUT FILES:
;	FACTPR.EXE
;	FPR2A.DOC
;	FACTPR.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP FACTPR.MAC,REL:SCAN/SEARCH
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
GET::
;*******************************************************************************
;				GET
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
;	GET.MAC
;
;Output files:
;	GET3.DOC
;	GET.EXE
;	GET.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP GET.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*GET/SSAVE=GET/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
GRIPE::
;**************************************************************************
;				GRIPE
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	C.MAC
;	GRIPE.MAC
;
;Output files:
;	GRIPE.EXE
;	GRP4.DOC
;	GRIPE.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP TTY:+DSK:C.MAC,GRIPE.MAC 
*%.C==-3
=
=
.IF (ERROR)  .GOTO DIR
.R LINK
*GRIPE/SSAVE=GRIPE/GO
.IF (ERROR)   .GOTO DIR
;
.GOTO COMMON
KJOB::
;**************************************************************************
;				KJOB
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	KJOB.MAC
;
;Output files:
;	KJOB.EXE
;	KJB50A.DOC
;	KJOB.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP KJOB.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
KNILDR::
;***********************************************************************
;		KNILDR
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
;	MACTEN.UNV
;	SCNMAC.UNV
;	UUOSYM.UNV
;	KNILDR.MAC
;
;Output files:
;	KNILDR.EXE
;	KNICOD.BIN
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP KNILDR
.IF (ERROR) .GOTO DIR
.R LINK
*KNILDR/SAVE=KNILDR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
LINED::
;**************************************************************************
;				LINED
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
:Required files:
;	LINED.MAC
;
;Output files:
;	LINED.EXE
;	LND13B.DOC
;	LINED.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP LINED.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
;FOR ANY NON-STANDARD VERSION  OF LINED ASSEMBLE AS FOLLOW:
;
;.R MACRO
;*LINED_TTY:,DSK:LINED.MAC
;PURE=0			((INCLUDE IF NON-REENTRANT WANTED))
;CCLSW=0		((INCLUDE IF CCL NOT WANTED))
;TEMP=0			((INCLUDE IF TMPCOR UUO DOES NOT EXIST))
;
;
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
GLXLGO::
;*******************************************************************************
;				GLXLGO (THE 7.03 LOGOUT)
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
;	GLXLGO.MAC
;
;Output files:
;	GLXLGO.EXE
;	GLXLGO.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*GLXLGO,GLXLGO=GLXLGO.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*GLXLGO/SSAVE=GLXLGO/GO
;ONE MUST RENAME THE FILE
;.RENAME LOGOUT.EXE=GLXLGO.EXE
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MAKVFU::
;*******************************************************************************
;				MAKVFU
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	MACTEN.UNV
;Required files:
;	MACROS.MAC
;	MAKVFU.MAC
;
;Output files:
;	MACROS.UNV
;	MAKVFU.EXE
;	MAKVFU.HLP
;	MAKVFU.LST
;	NORMAL.VFU
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL MACROS.MAC/NOBIN, MAKVFU.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*MAKVFU/SSAVE=MAKVFU/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MONEY::
;**************************************************************************
;				MONEY
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	MONEY.MAC
;
:Output files:
;	MONEY.EXE
;	MNY17B.DOC
;	MONEY.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP MONEY.MAC
.IF (ERROR)  .GOTO DIR
.SAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
MTCOPY::
;**************************************************************************
;				MTCOPY
;**************************************************************************
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
;	MTCOPY.MAC
;
;Output files:
;	MTCOPY.EXE
;	MTY3.DOC
;	MTCOPY.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP MTCOPY.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*MTCOPY/SSAVE=MTCOPY,REL:HELPER/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
NEWACT::
;*******************************************************************************
;                               NEWACT
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
;	ACTLIB.REL
;	ACTCUS.REL
;Output files:
;	NEWACT.EXE	
;
.SET WATCH VERSION FILES
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP/MACRO NEWACT
.IF (ERROR) .GOTO DIR
;
.R LINK
*NEWACT/SSAVE=/LOC/SYMSEG:LOW/SEGMENT:LOW -
*REL:GLXLIB/EXCLUD:(GLXINI,GLXOTS),-
*REL:ACTLIB/SEARCH/INCLUDE:ACTPRM, -
*NEWACT,REL:ACTLIB/SEARCH,REL:ACTCUS/SEARCH, -
*REL:OPRPAR/SEARCH,SYS:RMS,SYS:B361LB/SEARCH/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NRT::
;*******************************************************************************
;				NRT
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
;	NRT.MAC
;
;Output files:
;	NRT.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL NRT.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*NRT/SSAVE=NRT/GO
.IF (ERROR) .GOTO DIR
.GOTO COMMON
OMOUNT::
;*******************************************************************************
;				OMOUNT
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
;	OMOUNT.MAC
;
;Output files:
;	OMOUNT.EXE
;	OMOUNT.HLP
;	OMOUNT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP OMOUNT.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*OMOUNT/SAVE=OMOUNT/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
PAL10::
;*******************************************************************************
;				PAL10
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
;	PAL10.MAC
;
;Output files:
;	PAL10.EXE
;	PAL10.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL PAL10.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*PAL10/SSAVE=PAL10/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
PFH::
;*******************************************************************************
;				PFH
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
;	PFH.MAC
;
;Output files:
;	PFH.EXE
;	PFH.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP PFH
.IF (ERROR) .GOTO DIR
.R LINK
*PFH/SAVE=PFH/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
PLEASE::
;**************************************************************************
;				PLEASE
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	PLEASE.MAC
;
;Output files:
;	PLEASE.EXE
;	PLS14.DOC
;	PLEASE.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP PLEASE.MAC
.IF (ERROR)  .GOTO DIR
.SAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
MPBQUE::
;QPRM::
;**************************************************************************
;				QPRM
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	QPRM.MAC
;
;Output files:
;	QPRM.UNV
;	QPRM.LST
;	QPM2.DOC
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP TTY:+DSK:QPRM.MAC
*%.Q==-3
=
*%.Q==-3
=
.IF (ERROR)  .GOTO DIR
;
MPBQUE::
;QUEUE::
;**************************************************************************
;				QUEUE
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	QUEUE.MAC
;	C.MAC
;	SCNMAC.MAC
;
;Output files:
;	QUEUE.EXE
;	QUEUE.HLP
;	QUEUE.LST
;	QUE5.DOC
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP C.MAC+SCNMAC.MAC+QUEUE.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*QUEUE/GO
.IF (ERROR)  .GOTO DIR
.SSAVE QUEUE
;
MPBQUE::
;QUEUER::
;**************************************************************************
;				QUEUER
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	QUEUER.MAC
;
;Output files:
;	QUEUER.LST
;	QUEUER.REL
;	QUR4.DOC
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP QUEUER.MAC
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
MPBQUE::
;QMANGR::
;**************************************************************************
;				QMANGR
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	QMANGR.MAC
;
;Output files:
;	QMANGR.EXE
;	QMANGR.LST
;	QMR5A.DOC
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP QMANGR.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
;
.GOTO COMMON
REATTA::
;*******************************************************************************
;				REATTA
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
;	REATTA.MAC
;
;Output files:
;	REATTA.EXE
;	REATTA.LST
;	RTA3.DOC
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP REATTA.MAC
.IF (ERROR) .GOTO DIR
.SSAVE
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
REDALL::
;**************************************************************************
;				REDALL
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	REDALL.MAC
;
;Output files:
;	REDALL.EXE
;	REDALL.DOC
;	REDALL.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP REDALL.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SCRIPT::
;**************************************************************************
;				SCRIPT
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	SCRIPT.MAC
;
;Output files:
;	SCRIPT.EXE
;	SCT014.MEM
;	SCRIPT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP SCRIPT.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SOS::
;**************************************************************************
;				SOS
;**************************************************************************
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
;	SOS.MAC
;
;Output files:
;	SOS.EXE
;	SOS.HLP
;	SOS.LST
;	SOS21.DOC
;	SOSUG.MEM
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP SOS.MAC,REL:HELPER.REL
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SOUP::
;*******************************************************************************
;				SOUP
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
;	CAMCTL.MAC
;	CAMIO.MAC
;	CAMLOW.MAC
;	COMERG.MAC
;	CAMPAR.MAC
;	CORFIH.MAC
;	FEDCTL.MAC
;	FEDIT.MAC
;	FITRAK.MAC
;	SERVIS.MAC
;	10K.MAC
;	10KIMP.MAC
;
;Output files:
;	CAM.EXE
;	FED.EXE
;	COMP10.EXE
;	CAM.MAP
;	FED.MAP
;	COMP10.MAP
;	SOUP.HLP
;	CAMCTL.LST
;	CAMIO.LST
;	CAMLOW.LST
;	COMERG.LST
;	CAMPAR.LST
;	CORFIH.LST
;	FEDCTL.LST
;	FEDIT.LST
;	FITRAK.LST
;	SERVIS.LST
;	10K.LST
;	10KIMP.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMPIL CAMCTL.MAC,CAMIO.MAC,CAMLOW.MAC,COMERG.MAC,COMPAR.MAC,CORFIH.MAC,FEDCTL.MAC,FEDIT.MAC,FITRAK.MAC,SERVIS.MAC,10KIMP.MAC,10K.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*CAM/SSAVE=CAMLOW,CAMCTL,CAMIO,COMERG,COMPAR,CORFIH,FITRAK,SERVIS/GO
.IF (ERROR) .GOTO DIR
.COMPIL /COMPIL TTY:+DSK:CAMLOW.MAC
*CMPRSW=1
=
=
.IF (ERROR) .GOTO DIR
.R LINK
*FED/SSAVE=CAMLOW,FEDCTL,FEDIT,CAMIO,CORFIH,SERVIS/GO
.COMPIL /COMPIL TTY:+DSK:CAMIO.MAC
*BIGSW=1
=
=
.IF (ERROR) .GOTO DIR
.R LINK
*COMP10/SSAVE=10KIMP,10K,COMPAR,CAMIO/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SPACE::
;**************************************************************************
;				SPACE
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	QUEUER.REL
;Required files:
;	SPACE.MAC
;
;Output files:
;	SPACE.EXE
;	SPACE.HLP
;	SPC3.DOC
;	SPACE.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP SPACE.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*SPACE/SSAVE=SPACE,QUEUER/SEGMENT:HIGH,REL:HELPER/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
STRLIB::
;**************************************************************************
;				STRLIB
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
Required files:
;	STRCNV.MAC
;	STRDCL.MAC
;	STRERR.MAC
;	STRLOC.MAC
;	STRUSR.MAC
;	STRING.FOR
;
;Output files:
;	STRLIB.REL
;	STRLIB.MEM
;	STR1.DOC
;	STRLIB.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP STRDCL.MAC,STRUSR.MAC,STRCNV.MAC,STRLOC.MAC,STRERR.MAC
.IF (ERROR)  .GOTO DIR
.COP STRLIB.REL=STRUSR.REL,STRCNV.REL,STRLOC.REL,STRERR.REL
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SPRINT::
;**************************************************************************
;				SPRINT
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	SPRINT.MAC
;
;Output files:
;	SPRINT.BWR
;	SPRINT.EXE
;	SPRINT.HLP
;	SPT2.DOC
;	SPRINT.PLM
;	SPRINT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP SPRINT.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SPOOL::
;**************************************************************************
;				SPOOL
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	HELPER.REL
;	QUEUER.REL
;	QPRM.UNV
;	C.UNV
;Required files:
;	SPOOL.MAC
;
;Output files:
;	CDPSPL.EXE
;	CDPSLP.HLP
;	CDPSPL.LST
;	LPTSPL.EXE
;	LPTSPL.HLP
;	LPTSPL.LST
;	PLTSPL.EXE
;	PLTSPL.HLP
;	PLTSPL.LST
;	PTPSPL.EXE
;	PTPSPL.HLP
;	PTPSPL.LST
;	SPL6.DOC
;	SPOOL.BWR
;	STD.ALP
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R MACRO
*LPTSPL,LPTSPL/C=TTY:,DSK:SPOOL
*	LPTSPL==-1
=
*	LPTSPL==-1
=
*PLTSPL,PLTSPL/C=TTY:,DSK:SPOOL
*	PLTSPL==-1
=
*	PLTSPL==-1
=
*PTPSPL,PTPSPL/C=TTY:,DSK:SPOOL
*	PTPSPL==-1
=
*	PTPSPL==-1
=
*CDPSPL,CDPSPL/C=TTY:,DSK:SPOOL
*	CDPSPL==-1
=
*	CDPSPL==-1
=
.IF (ERROR)  .GOTO DIR
;
.R LINK
*QUEUER,HELPER,LPTSPL/GO
.IF (ERROR)  .GOTO DIR
.SSAVE LPTSPL
.IF (ERROR)  .GOTO DIR
.R LINK
*QUEUER,HELPER,PLTSPL/GO
.IF (ERROR)  .GOTO DIR
.SSAVE PLTSPL
.IF (ERROR)  .GOTO DIR
.R LINK
*QUEUER,HELPER,PTPSPL/GO
.IF (ERROR)  .GOTO DIR
.SSAVE PTPSPL
.IF (ERROR)  .GOTO DIR
.R LINK
*QUEUER,HELPER,CDPSPL/GO
.IF (ERROR)  .GOTO DIR
.SSAVE CDPSPL
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
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
*SYSINF /MAP/SAVE=
/SEARCH SYSINF/REQUIRE:(VERSION,INIMOD,INFEXC,INFO,INFERR,INFDAT)
*/SEARCH INFLIB
*/SEARCH SYSINF /START:INFEXC/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
TRACK::
;**************************************************************************
;				TRACK
;**************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;	MACTEN.UNV
;	UUOSYM.UNV
;Required files:
;	TRACK.MAC
;
;Output files:
;	TRACK.EXE
;	TRACK.HLP
;	TRK4.DOC
;	TRACK.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD /CREF /COMP TRACK.MAC
.IF (ERROR)  .GOTO DIR
.SSAVE
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
SDLCNV::

;*******************************************************************************
;				SDLCNV
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
;	SDLCNV.MAC
;
;Output files:
;	SDLCNV.EXE
;	SDLCNV.HLP
;	SDLCNV.DOC
;	SDLCNV.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP SDLCNV.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*SDLCNV/SSAVE=SDLCNV/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
UMOUNT::
;*******************************************************************************
;				UMOUNT
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
;	UMOUNT.MAC
;
;Output files:
;	UMOUNT.EXE
;	MOUNT.HLP
;	DISMOU.HLP
;	UMOUNT.LST
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP UMOUNT.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*UMOUNT/SSAVE=UMOUNT,REL:HELPER/GO
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
;.IF (ERROR)
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

