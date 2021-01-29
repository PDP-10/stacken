!
!
! File:	LINK.CTL
! Date:	27-SEP-85
! Edit History:
!
! 15-Jul-82	PAH	Move high segment origin to 540000.
!
! This control file is provided for information purposes only.
! The  purpose  of the file is to document the procedures used
! to build the distributed software.  It  is  unlikely  to  be
! able  to  be executed without modification on other systems.
! In particular, attention should be given to  ersatz  devices
! and  structure names, PPNs and other such system parameters.
! Submit times may vary depending on configuration  and  load.
! The  availability  of  sufficient  disk  space  and  core is
! mandatory.  This  control  file  has  not  been  extensively
! tested  on  alternate  configurations.   It  has  been  used
! successfully for the purpose for which it is  intended:   to
! build the distributed software.
!
!
! Required files (latest released versions):
!
! DEC:	MACRO.EXE
!	LINK.EXE
!	LNK???.EXE
!
!	COMPIL.EXE
!	DIRECT.EXE
!
!	SCNMAC.UNV
!	MACTEN.UNV
!	UUOSYM.UNV
!
!	JOBDAT.REL
!	SCAN.REL
!	HELPER.REL
!
! DSK:	LNK???.MAC
!	PLT???.MAC
!	OVRLAY.MAC
!
!	C1PLNK.CMD
!	C1POVL.CMD
!
!	L1PLNK.CCL
!	LNK???.CCL
!
!
! Output files:
!
!	LINK.EXE
!	LNKSCN.EXE
!	LNKLOD.EXE
!	LNKMAP.EXE
!	LNKXIT.EXE
!	LNKERR.EXE
!	LNK999.EXE
!	LNKOV1.EXE
!	LNKOV2.EXE
!
!	OVRLAY.REL
!
!
! Output listings:
!
!	LINK.MAP
!	LNK???.MAP
!
!
!
!
! Make batch stream restartable from this point.
!
LINK::
.CHKPNT LINK
!
!
!
! Record software versions being used.
!
.SET WATCH VERSION FILES
!
!
! Use field image software for build procedure.
!
.ASSIGN DEC: SYS:
.ASSIGN DEC: REL:
.ASSIGN DEC: UNV:
!
!
! Delete intermediate files in case this control file is being restarted.
!
.NOERROR
.DELETE LNK???.REL,OVRLAY.REL,FORMSC.UNV,LNK???.UNV
.DELETE LNK???.MAP,LNK???.EXE,LINK.EXE
.ERROR
!
!
! Record checksums of input source, REL, and UNV files.
!
.DIRECT/CHECKSUM LNK*.MAC,OVRLAY.MAC
.DIRECT/CHECKSUM REL:JOBDAT.REL,REL:SCAN.REL,REL:HELPER.REL
.DIRECT/CHECKSUM UNV:SCNMAC.UNV,UNV:MACTEN.UNV,UNV:UUOSYM.UNV
!
!
! Compile the source files.
!
.TYPE C1PLNK.CMD
!
.COMPILE/COMPILE @C1PLNK.CMD
!
!
.compile/compile @c1povl.cmd
!
!
! Load multi-segment LINK, using the LNK??? chain of LINK command files.
!
.TYPE L1PLNK.CCL,LNK*.CCL
!
.R LINK
*@L1PLNK.CCL
!
!
! Try it to make sure that the build procedure succeeded.
! This also records the version of OVRLAY.REL.
!
.RUN LINK
*OVRLAY.REL/VALUE:%OVRLA
!
!
! Record checksums of the output files.
!
.DIR/CHECKSUM LINK.EXE,LNK???.EXE,OVRLAY.REL
!
!
! Delete intermediate files.
!
!.DELETE LNK???.REL,FORMSC.UNV,LNK???.UNV
!
!
! Avoid DUMP command from BATCON in case of error.
!
%TERR::
%CERR::
%ERR::
%FIN::
!
!
! [End of LINK.CTL]
!
