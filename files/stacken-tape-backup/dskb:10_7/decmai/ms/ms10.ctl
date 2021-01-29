!
!	Build MS Version 11
!
!	LEGAL TAGS TO START FROM ARE:
!		LNK	to just link .RELs
!		NOCOMP	to NOT force compiles on all modules
!
compile/MACRO/compile MSUNV.MAC
compile/MACRO/compile MS.MAC
compile/MACRO/compile MSCNFG.MAC
compile/MACRO/compile MSDLVR.MAC
compile/MACRO/compile MSDSPL.MAC
compile/MACRO/compile MSFIL.MAC
compile/MACRO/compile MSMCMD.MAC
compile/MACRO/compile MSGUSR.MAC
compile/MACRO/compile MSHOST.MAC
compile/MACRO/compile MSLCL.MAC
compile/MACRO/compile MSNET.MAC
compile/MACRO/compile MSSEQ.MAC
compile/MACRO/compile MSTXT.MAC
compile/MACRO/compile MSUTL.MAC
compile/MACRO/compile MSVER.MAC
compile/MACRO/compile MSUUO.MAC
!
!
!
GOTO LNK
!
!
!
NOcomp::!
!	Here to rebuild all modules
!
!
!	Compile all macro modules
!
compile/macro MSUNV.MAC
compile/macro MSDLVR.MAC
compile/macro MSDSPL.MAC
compile/macro MS.MAC
compile/macro MSFIL.MAC
compile/macro MSMCMD.MAC
compile/macro MSCNFG.MAC
compile/macro MSGUSR.MAC
compile/macro MSHOST.MAC
compile/macro MSLCL.MAC
compile/macro MSNET.MAC
compile/macro MSSEQ.MAC
compile/macro MSTXT.MAC
compile/macro MSUTL.MAC
compile/macro MSVER.MAC
compile/macro MSUUO.MAC
!
!
!
LNK::
!
!	Check Version of Link
!
Get Sys:Link
Start
*tty:/log
*/syms:low/set:.high.:600000
*rel:glxlib/excl:glxini
*/logl:5
*mscnfg
*ms/ssave/g
