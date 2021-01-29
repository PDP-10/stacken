*******************************************************************************
;Running TOOLS:
;
;Submit TOOLS with the following command:
;	.SUBMIT TOOLS[,]/TAG:TOOL,TOOL
;where "TOOL" is replaced by the TOOL name.
;
;-----
;Requirements:
;1)	The sources and associated files that make up a tool are located
;	in an SFD dedicated to that tool.
;2)	Programs required to build the tool(s) reside in the UFD. These
;	are Macro, Link, Cref, etc.
;
;Note:	This control file will also work if SFDs are not used. However,
;	the directory may contain other files not associated with the
;	particular tool being built.
;
;-----
;If this control file is not started at a specific tag, a checksummed directory
;of the files needed to build all tools will be taken.
;*******************************************************************************
;
.SET WATCH VERSION
.NOERROR
.DIRECT/CHECKS MACRO.EXE,LINK.EXE,LNK???.EXE,CREF.EXE,COMPIL.EXE,DIRECT.EXE
;
.GOTO EXIT
CICTRS::
;*******************************************************************************
;                               CICTRS
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
;	GLXMAC.UNV
;	ORNMAC.UNV
;	OPRPAR.REL
;	CICTRS.MAC
;Output files:
;	CICTRS.EXE
;	
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP CICTRS.MAC 
.IF (ERROR) .GOTO DIR
;
.R LINK
*CICTRS/SSAVE=CICTRS/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
CISTS::
;*******************************************************************************
;                               CISTS
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
;	MSCPAR.UNV
;	SCAPRM.UNV
;	CISTS.MAC

;Output files:
;	CISTS.EXE
;	
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R DEC:MONGEN
*NO
*PROMPT
*F	;WHICH GEN
*F.MAC	;OUTPUT
*KL10	;FEATURE SET
*YES	;STANDARD SETTING?
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP F.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP S.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP DEVPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP KLPPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMPILE SCAPRM.MAC 
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMPILE MSCPAR.MAC 
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMPILE CISTS.MAC 
.IF (ERROR) .GOTO DIR
;
.R LINK
*CISTS/SSAVE=CISTS/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
CONFIG::
;*******************************************************************************
;                               CONFIG
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
;	CNFORN.MAC (FROM GALAXY)
;	CNFTAB.MAC (FROM GALAXY)
;	CNFHDW.MAC (FROM GALAXY)
;	GLXLIB.REL (FROM GALAXY)
;	OPRPAR.REL (FROM GALAXY)
;
;Output files:
;
;	CONFIG.EXE
;	
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /COM CONFIG.MAC,CNFORN.MAC,CNFTAB.MAC,CNFHDW.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*CONFIG/SSAVE = /LOCALS /SYMSEG:HIGH REL:GLXLIB/EXCLUDE:GLXINI, -
*CONFIG, CNFORN, CNFTAB, REL:OPRPAR /GO
.IF (ERROR) .GOTO DIR
;
;
.GOTO COMMON
CPU::
;*******************************************************************************
;                               CPU
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
;	DPYSUB.REL
;	DPYNEW.REL
;	CPU.FOR
;Output files:
;	CPU.CMD
;	CPU.EXE
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP CPU.FOR 
.IF (ERROR) .GOTO DIR
;
.R LINK
*CPU/SSAVE=CPU.REL,DPYSUB.REL,DPYNEW.REL/OTS:NONSHARE/SEG:LOW/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
CSHDPY::
;*******************************************************************************
;				CSHDPY
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
;	CSHDMP.MAC
;	CSHDPY.FOR
;	CSHDPY.CMD
;	DPYSUB.REL
;	DPYNEW.REL
;	FORLIB.REL
;	MACUNV.UNV
;	MACLIB.REL
;	MAP.FOR
;Output files:
;	CSHDPY.EXE
;	CSHDMP.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL CSHDMP.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL CSHDPY.FOR(,,F66)
.IF (ERROR) .GOTO DIR
;
.R LINK
*CSHDMP/SSAVE=CSHDMP/GO
.IF (ERROR) .GOTO DIR
.R LINK
*CSHDPY/SSAVE =  CSHDPY,REL:MAP.REL,REL:DPYSUB.REL,REL:DPYNEW.REL/OTS:NONSHARE/SEG:LOW/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DBUSY::
;*******************************************************************************
;				DBUSY
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
;Required files:
;	DBUSY.MAC
;
;Output files:
;	DBUSY.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP DBUSY.MAC
.IF (ERROR)  .GOTO DIR
;
.R LINK
*DBUSY/SSAVE=DBUSY/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DCN::
;*******************************************************************************
;				DCN
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
;	DCN.MAC
;	UUOSYM.UNV
;	JOBDAT.UNV
;	MACTEN.UNV
;	NSCAN.UNV
;Output files:
;	DCN.UNV
;	DCN.REL
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMP DCN.MAC
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DCNSPY::
;*******************************************************************************
;				DCNSPY
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
;	D36PAR.UNV
;	SCNMAC.UNV
;	S.UNV
;	F.UNV
;	UUOSYM.UNV
;	DPYDEF.UNV
;	NETPRM.UNV
;	MACSYM.UNV
;	DCNSPY.MAC
;	DPY.REL
;
;
;Output files:
;
;	DCNSPY.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R DEC:MONGEN
*NO
*PROMPT
*F	;WHICH GEN
*F.MAC	;OUTPUT
*KL10	;FEATURE SET
*YES	;STANDARD SETTING?

.COMPILE/COMP F.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP S.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COM NETPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP D36PAR.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP DCNSPY.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*DCNSPY/SSAVE=DCNSPY/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DDBDPY::
;*******************************************************************************
;                               DDBDPY
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
;	MACTEN.UNV
;	UUOSYM.UNV
;	DDBDPY.MAC
;Output files:
;	DDBDPY.EXE
;	
;	
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP DDBDPY.MAC 
.IF (ERROR) .GOTO DIR
;
.R LINK
*DDBDPY/SAVE=/SET:.HIGH.:200000 DDBDPY/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DPY::
;*******************************************************************************
;				DPY
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
;	DPYDEF.MAC
;	UUOSYM.UNV
;	DPY.MAC
;
;Output files:
;	DPYDEF.UNV	;USED FOR DCNSPY BUILD
;	DPY.REL
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMP DPYDEF.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP DPY.MAC
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DNSNUP::
;*******************************************************************************
;				DNSNUP
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
;	MACSYM.UNV
;	UUOSYM.UNV
;	SWIL.UNV
;	MACTEN.UNV
;	DNSNUP.MAC
;	F.MAC
;	S.MAC
;	NETPRM.MAC
;	D36PAR.MAC
;
;Output files:
;
;	DNSNUP.EXE
;
.SET WATCH FILES
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R DEC:MONGEN
*NO
*PROMPT
*F	;WHICH GEN
*F.MAC	;OUTPUT
*KL10	;FEATURE SET
*YES	;STANDARD SETTING?

.COMPILE/COMP F.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP S.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP NETPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP D36PAR.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE /COMP DNSNUP.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*DNSNUP/SSAVE=DNSNUP/GO
.IF(ERROR) .GOTO DIR
;
.GOTO COMMON
DNTATL::
;*******************************************************************************
;				DNTATL
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
;	MACSYM.UNV
;	UUOSYM.UNV
;	SWIL.UNV
;	MACTEN.UNV
;	DNTATL.MAC
;	F.MAC
;	S.MAC
;	NETPRM.MAC
;	D36PAR.MAC
;
;Output files:
;
;	DNTATL.EXE
;
.SET WATCH FILES
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R DEC:MONGEN
*NO
*PROMPT
*F	;WHICH GEN
*F.MAC	;OUTPUT
*KL10	;FEATURE SET
*YES	;STANDARD SETTING?

.COMPILE/COMP F.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP S.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP NETPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP D36PAR.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE /COMP DNTATL.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*DNTATL/SSAVE=DNTATL/GO
.IF(ERROR) .GOTO DIR
;
.GOTO COMMON
DTS::
;*******************************************************************************
;				DTR/DTS
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
;	DTSPRM.MAC
;	DTSCOM.MAC
;	JOBDAT.UNV
;	MACSYM.UNV
;	UUOSYM.UNV
;	NSCAN.UNV
;	MACTEN.UNV
;	DTR.MAC
;	DTS.MAC
;
;Output files:
;
;	DTR.EXE
;	DTS.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMP DTSPRM.MAC,DTSCOM.MAC,DTR.MAC,DTS.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*DTR/SSAVE=DTR,DTSCOM/GO
.IF (ERROR) .GOTO DIR
;
.R LINK
*DTS/SSAVE=DTS,DTSCOM/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DPYPAK::
;*******************************************************************************
;				DPYPAK
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
;	DPYPAK.MAC
;	DPYSUB.MAC
;	DPYNEW.MAC
;
;Output files:
;	DPYPAK.REL
;	DPYSUB.REL
;	DPYNEW.REL
;	DPYNEW.DOC
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/COMP DPYPAK.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL/COMP DPYSUB.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL/COMP DPYNEW.MAC
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
DSKDMP::
;*******************************************************************************
;				DSKDMP
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
;	DSKDMP.MAC
;Output files:
;	DSKDMP.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP DSKDMP.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*DSKDMP/SSAVE=DSKDMP/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
DTECO::
;*******************************************************************************
;				DTECO
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
;Required files:
;	DTECO.MAC
;
;Output files:
;	DTECO.EXE
;	DTECO.MEM
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP DTECO
.IF (ERROR)  .GOTO DIR
;
.R LINK
*DTECO/SSAVE=DTECO/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
FAST::
;*******************************************************************************
;				FAST
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
;	FAST.MAC
;	SCAN.REL
;	WILD.REL
;	HILOW.UNV
;Output files:
;	FAST.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP FAST.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*FAST/SSAVE=FAST/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
FEDEL::
;*******************************************************************************
;				FEDEL
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
;	FEDEL.MAC
;
;Output files:
;	FEDEL.EXE
;	FEDEL.HLP
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP FEDEL.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*FEDEL/SSAVE=FEDEL/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON

FRCINI::
;*******************************************************************************
;				FRCINI
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
;	FRCINI.MAC
;
;Output files:
;	FRCINI.HLP
;	FRCINI.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP FRCINI.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*FRCINI/SSAVE=FRCINI/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
FRECOR::
;*******************************************************************************
;				FRECOR
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
;	FRECOR.MAC
;
;Output files:
;	FRECOR.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMP FRECOR.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*FRECOR/SAVE= /SET:CODE:314000 -
*FRECOR,
*/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
FSCOPY::
;*******************************************************************************
;				FSCOPY
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
;	FSCOPY.MAC
;	MACUNV.UNV
;	MACLIB.REL
;
;Output files:
;	FSCOPY.REL
;	FSCOPY.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /COMP FSCOPY.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*FSCOPY/SSAVE=FSCOPY/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
GALTOL::
;*******************************************************************************
;				GALTOL
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
;	DMOPRM.MAC
;	DMOTAB.MAC
;	DEMO.MAC
;	GALDPY.MAC
;	GALKIL.MAC
;	GALTRK.MAC
;	QSRCV2.MAC
;	QSRCV4.MAC
;	TYPIDS.MAC
;	VEREDT.MAC
;	OPRPAR.REL
;
;Output files:
;	DEMO.DOC
;	GALDPY.EXE
;	GALKIL.EXE
;	GALTRK.EXE
;	TYPIDS.EXE
;	VEREDT.EXE
;	QSRMV2.UNV
;	QSRMV4.UNV
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /COMP QSRCV2.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /COMP QSRCV4.MAC
.IF (ERROR)  .GOTO DIR
;
.COMPIL /CREF /COMP GALDPY.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP GALKIL.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP GALTRK.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP TYPIDS.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP VEREDT.MAC
.IF (ERROR)  .GOTO DIR
;
;
.R LINK
*GALDPY/SSAVE=GALDPY/GO
.IF (ERROR) .GOTO DIR
;
.R LINK
*GALKIL/SSAVE=GALKIL/GO
.IF (ERROR) .GOTO DIR
;
.R LINK
*GALTRK/SSAVE=GALTRK/GO
.IF (ERROR) .GOTO DIR
;
.R LINK
*TYPIDS/SSAVE=TYPIDS/GO
.IF (ERROR) .GOTO DIR
;
.R LINK
*VEREDT/SSAVE=VEREDT,REL:OPRPAR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
GETNOD::
;*******************************************************************************
;				GETNOD
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
;	GETNOD.MAC
;
;Output files:
;	GETNOD.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP GETNOD.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*GETNOD/SSAVE=GETNOD/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
INFTST::
;*******************************************************************************
;				INFTST
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
;	INFTST.MAC
;
;Output files:
;	INFTST.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP INFTST.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*INFTST/SSAVE=INFTST/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
KDPDPY::
;*******************************************************************************
;				KDPDPY
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
;	KDPDPY.MAC
;	DPY.REL			;FROM DECNET DPY TOOL BUILD
;	DPYDEF.REL		;FROM DECNET DPY TOOL BUILD
;	NETPRM.UNV		;FROM LATEST KS10 MONITOR BUILD
;
;
;Output files:
;	KDPDPY.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R DEC:MONGEN
*NO
*PROMPT
*F	;WHICH GEN
*F.MAC	;OUTPUT
*KS10	;FEATURE SET
*YES	;STANDARD SETTING?

.COMPILE/COMP F.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP S.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP NETPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP KDPDPY.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*KDPDPY/SSAVE=KDPDPY/GO
;
.GOTO COMMON
KILL::
;*******************************************************************************
;				KILL
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
;	KILL.MAC
;	
;Output files:
;	KILL.EXE 
;	KILL.HLP
;	KILL.DOC
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP KILL.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*KILL/SSAVE=KILL/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
KLBPA::
;*******************************************************************************
;				KLBPA
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;Required files:
;	KLBPA.MAC
;
;Output files:
;	KLBPA.DOC
;	KLBPA.EXE
;	KLBPA.HLP
;	KLBPA.MAN
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP KLBPA.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*KLBPA/SSAVE=KLBPA/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
KLEPTO::
;*******************************************************************************
;				KLEPTO
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;Required files:
;	KLEPTO.MAC
;	MAC10.MAC
;	COMMOD.UNV
;	CMMD.MAC
;
;Output files:
;	KLEPTO.HLP
;	KLEPTO.EXE
;	MAC10.UNV
;	702062.TXT
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/COMP MAC10.MAC
.IF (ERROR) .GOTO DIR
;
.COMPIL /CREF /COMP KLEPTO.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*KLEPTO/SSAVE=KLEPTO/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
KSONLY::
;*******************************************************************************
;				KSONLY - ANF AND DECNET
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
;	UUOSYM.UNV
;	ANF.MAC
;	DECNET.MAC
;
;Output files:
;
;	ANF.EXE
;	DECNET.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMP ANF.MAC,DECNET.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*ANF/SSAVE=ANF/GO
.IF (ERROR) .GOTO DIR
.R LINK
*DECNET/SSAVE=DECNET/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
LINCLN::
;*******************************************************************************
;				LINCLN
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;Required files:
;	LINCLN.MAC
;	DCN.UNV
;
;Output files:
;
;	LINCLN.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP LINCLN.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*LINCLN/SSAVE=LINCLN/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
LNM::
;*******************************************************************************
;				LNM
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;Required files:
;	LNM.MAC
;
;Output files:
;
;	LNM.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP LNM.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*LNM/SSAVE=LNM/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MAKSYM::
;*******************************************************************************
;				MAKSYM
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;	LINK.EXE
;
;Required Files:
;	MAKSYM.MAC
;	JOBDAT.UNV
;	MACTEN.UNV
;	UUOSYM.UNV
;	SCNMAC.UNV
;	SCAN.REL
;	HELPER.REL
;
;Output files:
;
;	MAKSYM.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMPILE MAKSYM.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*=TTY:/LOG/LOGL:10/CORE:40P/HASH:1K
*MAKSYM/SSAVE,MAKSYM/MAP=/LOCALS/SYMSEG:LOW MAKSYM/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MAP::
;*******************************************************************************
;				MAP
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;
;Required Files:
;	MAP.MAC
;
;Output files:
;	MAP.REL
;	MAP.FOR
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.PA FROM: = BLKY:[7,2,MAP]
.R NFT
*@BLKX:MAP.MOV[7,3,BLDMIC]
.COMPIL /CREF /COMP MAP.MAC
.IF (ERROR) .GOTO DIR
.COMPIL /COMP MAP.FOR=TTY:+DSK:MAP.MAC
*FTFORTRAN==-1
=^Z
=^Z
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MBR::
;*******************************************************************************
;				MBR
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
;	MBR.MAC
;
;Output files:
;	
;	MBR.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP MBR.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*MBR/SSAVE=MBR,SYS:DDT/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
MONDM4::
;*******************************************************************************
;				MONDM4
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
;	MONDM4.MAC
;	Q.UNV
;
;Output files:
;	MONDM4.EXE
;
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP MONDM4.MAC
.IF (ERROR)  .GOTO DIR
;
.R LINK
*MONDM4/SSAVE=MONDM4/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
MONITR::
;***********************************************************************
;		MONITR
;****************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	MONITR.MAC
;
;Output files:
;	
;	MONITR.EXE
;	MONITR.HLP
;	
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF /COMP MONITR
.IF (ERROR) .GOTO DIR
.R LINK
*MONITR/SAVE=MONITR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NETPTH::
;*******************************************************************************
;				NETPTH
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
;	NETPTH.MAC
;	UUOSYM.UNV
;	MACTEN.UNV
;	SCNMAC.UNV
;;Output files:
;
;	NETPTH.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMP NETPTH.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*NETPTH/SSAVE=NETPTH/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NETTST::
;*******************************************************************************
;				NETTST
;*******************************************************************************
;
;Required cusps:
;	PIP.EXE
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	JOBDAT.UNV
;	MACTEN.UNV
;	UUOSYM.UNV
;	ACTSYM.UNV
;	DTEPRM.UNV
;	SWIL.UNV,.REL
;	NETTST.MAC
;	MACLIB.MAC
;	NETLIB.MAC
;	TULIP.MAC
;	TULLIB.MAC
;	
;
;Output files:
;	NETTST.EXE
;
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R DEC:MONGEN
*NO
*PROMPT
*F	;WHICH GEN
*F.MAC	;OUTPUT
*KL10	;FEATURE SET
*YES	;STANDARD SETTING?
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP F.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP S.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP DTEPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPIL /COMP TULIP,TULLIB,MACLIB,NETLIB,NETTST 
.IF (ERROR)  .GOTO DIR
.R LINK
*NETTST/SSAVE=NETTST/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
NODNAM::
;*******************************************************************************
;				NODNAM
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
;	NODNAM.MAC
;
;Output files:
;	NODNAM.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP NODNAM.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*NODNAM/SSAVE=NODNAM/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
PIVOT::
;*******************************************************************************
;				PIVOT
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
;	PIVOT.MAC
;
;Output files:
;	PIVOT.EXE
;	
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP PIVOT.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*PIVOT/SSAVE=PIVOT/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
PSTHRU::
;*******************************************************************************
;				PSTHRU
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
;	PSTHRU.MAC
;	PMR.MAC
;	NETPRM.UNV
;Output files:
;	PSTHRU.PLM
;	PSTHRU.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.R DEC:MONGEN
*NO
*PROMPT
*F	;WHICH GEN
*F.MAC	;OUTPUT
*KL10	;FEATURE SET
*YES	;STANDARD SETTING?

.COMPILE/COMP F.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COMP S.MAC
.IF (ERROR) .GOTO DIR
;
.COMPILE/COM NETPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPIL /CREF /COMP PSTHRU.MAC
.IF (ERROR)  .GOTO DIR
;
.R LINK
*PSTHRU/SSAVE=PSTHRU/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
RDREG::
;*******************************************************************************
;				RDREG
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;Required files:
;	DX20.MAC
;	RDRMAC.MAC
;	RDREG.MAC
;	
;Output files:
;	RDREG.HLP
;	DX20.EXE
;
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL RDRMAC.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL DX20.MAC
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL RDREG.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*DX20/SSAVE=RDREG/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
REDCTR::
;*******************************************************************************
;				REDCTR
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;Required files:
;	
;	REDCTR.MAC
;	
;	
;Output files:
;	   
;	REDCTR.EXE
;
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/COMP REDCTR.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*REDCTR/SSAVE=REDCTR/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
RELOAD::
;*******************************************************************************
;				RELOAD
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;Required files:
;	RELOAD.MAC
;	
;Output files:
;	RELOAD.EXE
;
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /COMPIL RELOAD.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*RELOAD/SSAVE=RELOAD/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
RMTCON::
;*******************************************************************************
;				RMTCON
;*******************************************************************************
;
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	MACRO.EXE
;Required files:
;	RMTCOM.MAC
;	RMTCOT.MAC
;	RMTCOP.MAC
;Output files:
;	RMTCON.EXE
;
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.LOAD/CREF RMTCOT,RMTCOP,RMTCOM
.SAVE
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
RP20::
;*******************************************************************************
;				RP20
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
;	RNXPRT.FOR
;	RNXTRC.MAC
;
;Output files:
;	RNXTRC.EXE
;	RNXPRT.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL RNXPRT.FOR
.IF (ERROR) .GOTO DIR
.COMP /CREF /COMPIL RNXTRC.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*RNXPRT/SSAVE=RNXPRT/OTS:NONSHARE/SEG:LOW/GO
.IF (ERROR) .GOTO DIR
.R LINK
*RNXTRC/SSAVE=RNXTRC/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SEARCH::
;*******************************************************************************
;				SEARCH
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
;	SEARCH.MAC
;
;Output files:
;	SEARCH.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL SEARCH.MAC
.IF (ERROR) .GOTO DIR
.R LINK
*SEARCH/SSAVE=SEARCH/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SED::
;*******************************************************************************
;				SED
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
;	SEDSYM.MAC
;	SED.CMD		;AND THE LIST OF FILES THEREIN
;Output files:
;	SED.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE/COMP SEDSYM
.IF (ERROR) .GOTO .DIR
;
.COMPILE @SED.CMD
.IF (ERROR) .GOTO DIR
;
.R LINK
*/SYMSEG:HIGH/SET:.HIGH.:650000,SED/SSAVE,-
*SEDTTY,SED1ST,SED1MV,SED1CM,SED1FI,SED1DS,SED1SW,SED1EX,SED1JO,SED1SU,SED1DT
*/GO
;
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SNOOPY::
;*******************************************************************************
;				SNOOPY
;*******************************************************************************
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	SNOOPY.MAC
;	TATTLE.FOR
;	TATSUB.MAC
;
;Output files:
;	SNOOPY.EXE
;	TATTLE.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/COMP/CREF SNOOPY,TATSUB
.IF (ERROR) .GOTO DIR
.COMPIL/COMP/CREF TATTLE.FOR
.IF (ERROR) .GOTO DIR
.R LINK
*SNOOPY/SSAVE=SNOOPY/GO
.IF (ERROR) .GOTO DIR
.R LINK
*TATTLE/SAVE= /set:.high.:600000 TATTLE/OTS:NONSHARABLE, TATSUB/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
SNUP::
;*******************************************************************************
;				SNUP
;*******************************************************************************
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	SNUP.MAC
;	MSTCKS.MAC
;
;Output files:
;	SNUP.REL
;	SNUP.UNV
;	MSTCKS.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/COMP SNUP.MAC,MSTCKS.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*MSTCKS/SSAVE=MSTCKS/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
STOPCD::
;*******************************************************************************
;				STOPCD
;*******************************************************************************
;Required cusps:
;	COMPIL.EXE
;	CREF.EXE
;	DIRECT.EXE
;	LINK.EXE
;	LNK???.EXE
;	MACRO.EXE
;Required files:
;	STOPCD.MAC
;
;Output files:
;	STOPCD.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL/COMP STOPCD.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*STOPCD/SSAVE=STOPCD/GO
;
.GOTO COMMON
TRMTYP::
;*******************************************************************************
;				TRMTYP
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
;	TRMTYP.MAC
;
;Output files:
;	TRMTYP.EXE
;	TRMTYP.HLP
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMP /CREF /COMPIL TRMTYP.MAC
.IF (ERROR) .GOTO DIR
;
.R LINK
*TRMTYP/SSAVE=TRMTYP/GO
.IF (ERROR) .GOTO DIR
.GOTO COMMON
TSTSUP::
;*******************************************************************************
;				TSTSUP
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
;	TSTSUP.MAC
;
;Output files:
;	
;	TSTSUP.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP TSTSUP.MAC
.IF (ERROR)  .GOTO DIR
.R LINK
*TSTSUP/SSAVE=TSTSUP/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
USAGE::
;*******************************************************************************
;				USAGE
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
;	ACCCHK.MAC
;	SPCUSG.MAC
;	USRENT.MAC
;	VALID.MAC
;	QPRM.UNV
;
;Output files:
;	ACCCHK.EXE
;	SPCUSG.EXE
;	VALID.EXE
;	USGFUN.MEM
;	USRENT.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COPY FOO.MAC=TTY:
 %.Q==-3
^Z
.COMPIL/COMP FOO+QPRM.MAC
.IF (ERROR) .GOTO DIR
;
.COMPIL /CREF /COMP ACCCHK.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP SPCUSG.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP VALID.MAC
.IF (ERROR)  .GOTO DIR
.COMPIL /CREF /COMP USRENT.MAC
.IF (ERROR)  .GOTO DIR
;
.R LINK
*ACCCHK/SSAVE=ACCCHK/GO
.IF (ERROR)  .GOTO DIR
.R LINK
*SPCUSG/SSAVE=SPCUSG/GO
.IF (ERROR)  .GOTO DIR
.R LINK
*VALID/SSAVE=VALID/GO
.IF (ERROR)  .GOTO DIR
.R LINK
*USRENT/SSAVE=USRENT/GO
.IF (ERROR)  .GOTO DIR
;
.GOTO COMMON
USERS::
;*******************************************************************************
;				USERS
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
;	USERS.MAC
;
;Output files:
;	
;	USERS.EXE
;	
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPILE /CREF/COMP USERS
.IF (ERROR)  .GOTO DIR
.R LINK
*USERS/SSAVE=USERS/GO
.IF (ERROR) .GOTO DIR
;
.GOTO COMMON
WHYCRS::
;*******************************************************************************
;				WHYCRS
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
;	WHYCRS.MAC
;	DMPAVL.MAC
;
;Output files:
;	WHYCRS.HLP
;	WHYCRS.EXE
;	DMPAVL.EXE
;
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC UNV
.ASSIGN DEC REL
;
.COMPIL /CREF /COMP WHYCRS.MAC
.IF (ERROR)  .GOTO DIR
;
.COMPIL /CREF /COMP DMPAVL.MAC
.IF (ERROR)  .GOTO DIR
;
.R LINK
*WHYCRS/SSAVE=WHYCRS/GO
;
.R LINK
*DMPAVL/SSAVE=DMPAVL/GO
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
