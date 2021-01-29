;[GALAXY.CTL]
;
; This control file and its subordinate files generate a GALAXY system
; for a DECsystem-10 or DECSYSTEM-20.
;
; Before submitting this control file:
;
;	1.  Perform monitor instalation to ensure current copies
;	    of required system universal and REL files and a running
;	    batch system.
;
;	2.  Insure the GALGEN portion of this control file contains
;	    answers appropriate for your site.
;
;	3.  SUBMIT GALAXY.CTL
;
; Description:
;
;	GALAXY.CTL requires several subordinate control files for
;	the individual components.  Each of these files may be used
;	independently to generate that particluar component.  This
;	control file also builds the GALAXY library.
;
;	In the following list of files, a (10) indicates the file is
;	required for a TOPS-10 GALAXY and a (20) for a TOPS-20 GALAXY.
;
; Sources:	GLXCOM.MAC	GLXFIL.MAC	GLXFUN.MAC	GLXIPC.MAC
;		GLXINI.MAC	GLXINT.MAC	GLXKBD.MAC	GLXLNK.MAC
;		GLXMAC.MAC	GLXMEM.MAC	GLXOTS.MAC	GLXSCN.MAC
;		GLXTXT.MAC	GLXUTL.MAC	GLXVER.MAC
;
;		OPRPAR.MAC	ORNMAC.MAC	QSRMAC.MAC
;
; Input:	GALGEN.EXE	MONSYM.UNV(20)
;
; Output:	GALCNF.MAC	GLXMAC.UNV	GLXLIB.REL	GLXLIB.EXE
;
;		OPRPAR.REL	ORNMAC.UNV	QSRMAC.UNV
;
; Subordinate control files:
;
;	BATCON.CTL	builds the batch controller
;	CATLOG.CTL	builds the System Catalog Manager
;	CDRIVE.CTL	builds the card reader spooler
;	GALGEN.CTL	builds the GALAXY system generator
;	GLXLIB.CTL	builds the linkable and OTS GALAXY library
;	NEBULA.CTL(10)	builds the DQS spooler
;	OPERAT.CTL	builds operator interface programs
;	PLEASE.CTL	builds the user/operator interface
;	PULSAR.CTL(10)	builds tape/disk label processor
;	QUASAR.CTL	builds GALAXY queue manager and scheduler
;	QUEUE.CTL	builds the QUEUE program and QMANGR
;	SPRINT.CTL	builds card reader interpreter
;

.GOTO TOPS10
@GOTO TOPS20
TOPS10::
.SUBMIT GALGEN/UNIQUE:YES/TIME:00:20:00/RESTART:YES
.SUBMIT GALAXY/TIME:00:30:00/TAG:START/RESTART:YES/DEP:1
.GOTO END
START::
.SET WATCH VERSION
.ASSIGN DEC SYS
.ASSIGN DEC REL
.ASSIGN DEC UNV
.DIRECT /CHECK -
*GLXCOM.MAC, GLXFIL.MAC, GLXIPC.MAC, GLXINI.MAC, -
*GLXINT.MAC, GLXKBD.MAC, GLXLNK.MAC, GLXMAC.MAC, -
*GLXMEM.MAC, GLXOTS.MAC, GLXSCN.MAC, GLXTXT.MAC, -
*GLXUTL.MAC, GLXVER.MAC, -
*OPRPAR.MAC, ORNMAC.MAC, QSRMAC.MAC

.RUN GALGEN
*		;Dialog length
*		;Operator log file name
*		;Redundant master queue file
*		;Master queue file structure
*		;Maximum priority for non-privileged users
*		;Default priority
*		;Maximum length of PID name
*YES		;Optional Application support
*YES		;Support for LCP command set
*YES		;Support for NCP command set
*NO		;No user-defined applications
*		;Default batch job runtime
*		;Default spooled LPT limit
*		;Default spooled CDP limit
*		;Default spooled PTP limit
*		;Default spooled PLT limit
*		;Default /OUTPUT
*		;Core limit enforcement
*		;Default core limit
*		;Number of LPT banner pages
*		;Number of LPT trailer pages
*		;Number of LPT file header pages
*		;Standard output forms name
*		;Forms name uniqueness
*YES		;Special printer drivers
*LPTL01		;LN01 driver
*YES		;More special printer drivers
*LPTL03		;LN03 driver
*NO		;No more special printers
*YES		;MDA included
*		;Default magtape label type
*		;Default 9-track magtape density
*		;Default 7-track magtape density
*		;Default magtape track type
*		;BYPASS labels allowed for un-privileged users
*		;Standard limit computation
*		;Default output-limit-exceeded action
*		;Default FAL stream network
*		;Default number of minutes demand spoolers tolerate idleness
*YES		;Define some symbols
*	XP FTDQS,-1	;We plan to support DQS/NEBULA
*		;Done with random defines

; Create GALAXY configuration universal
.COMPILE/COMPILE GALCNF.MAC

; Build the linkable GALAXY library
.COPY GLXPUR.MAC=TTY:
*GLXPURE==0
=^Z
.COMPILE /COMPILE GLXPUR.MAC+GLXVER.MAC+GLXMAC.MAC
.COMPILE /COMPILE ORNMAC.MAC

.COMPILE /COMPILE GLXINI.MAC
.COMPILE /COMPILE GLXUTL.MAC
.COMPILE /COMPILE GLXCOM.MAC
.COMPILE /COMPILE GLXFIL.MAC
.COMPILE /COMPILE GLXFUN.MAC
.COMPILE /COMPILE GLXINT.MAC
.COMPILE /COMPILE GLXIPC.MAC
.COMPILE /COMPILE GLXKBD.MAC
.COMPILE /COMPILE GLXLNK.MAC
.COMPILE /COMPILE GLXMEM.MAC
.COMPILE /COMPILE GLXOTS.MAC
.COMPILE /COMPILE GLXSCN.MAC
.COMPILE /COMPILE GLXTXT.MAC
.R PIP 
*GLXLIB.REL=GLXINI.REL,GLXMAC.REL,GLXUTL.REL,GLXOTS.REL,GLXCOM.REL,GLXIPC.REL,GLXFIL.REL,GLXFUN.REL,GLXTXT.REL,GLXLNK.REL,GLXSCN.REL,GLXKBD.REL,GLXMEM.REL,GLXINT.REL
.R MAKLIB
*GLXLIB.REL=GLXLIB.REL/INDEX/EXIT

; Build the GALAXY object time system
.COPY GLXPUR.MAC=TTY:
*GLXPURE==-1
=^Z
.COMPILE /COMPILE GLXPUR.MAC+GLXVER.MAC+GLXMAC.MAC
.COMPILE /COMPILE GLXINI.MAC
.COMPILE /COMPILE GLXCOM.MAC
.COMPILE /COMPILE GLXFIL.MAC
.COMPILE /COMPILE GLXFUN.MAC
.COMPILE /COMPILE GLXINT.MAC
.COMPILE /COMPILE GLXIPC.MAC
.COMPILE /COMPILE GLXKBD.MAC
.COMPILE /COMPILE GLXLNK.MAC
.COMPILE /COMPILE GLXMEM.MAC
.COMPILE /COMPILE GLXOTS.MAC
.COMPILE /COMPILE GLXSCN.MAC
.COMPILE /COMPILE GLXTXT.MAC
.COMPILE /COMPILE GLXUTL.MAC
.R LINK
*GLXLIB/SSAVE = -
*/SET:.HIGH.:622000 /SET:DATA:674000 /SYMSEG:PSECT:.HIGH. /LOCALS -
*GLXMAC, GLXOTS, GLXCOM, GLXIPC, GLXFIL, GLXFUN, GLXKBD, -
*GLXLNK, GLXMEM, GLXSCN, GLXTXT, GLXUTL, GLXINT -
*/GO

; Create required UNV and REL files
.COMPILE/COMPILE QSRMAC.MAC
.COMPILE/COMPILE OPRPAR.MAC

; Delete unneeded REL files
.DELETE GLXMAC.REL,QSRMAC.REL

.DIRECT /CHECK -
*GLXLIB.REL, GLXLIB.EXE, -
*GALCNF.UNV, -
*OPRPAR.REL, ORNMAC.UNV, QSRMAC.UNV

.DEASSIGN SYS

;Resubmit ourself to finish up after all modules have completed
.SUBMIT GALAXY /BATLOG:APPEND /OUTPUT:NOLOG /TAG:FINISH /DEPEND:11

;SUBMIT Subordinates
.SUBMIT BATCON /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:10:00 /RESTART:YES
.SUBMIT CATLOG /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:15:00 /RESTART:YES
.SUBMIT CDRIVE /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:03:00 /RESTART:YES
.SUBMIT LPTSPL /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:10:00 /RESTART:YES
.SUBMIT NEBULA /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:20:00 /RESTART:YES
.SUBMIT OPERAT /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:20:00 /RESTART:YES
.SUBMIT PLEASE /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:03:00 /RESTART:YES
.SUBMIT PULSAR /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:20:00 /RESTART:YES
.SUBMIT QUASAR /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:20:00 /RESTART:YES
.SUBMIT QUEUE  /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:03:00 /RESTART:YES
.SUBMIT SPRINT /UNIQUE:YES /OUTPUT:NOLOG /TIME:00:07:00 /RESTART:YES

;Finally wait for completion of all modules
.GOTO END

FINISH::
.DIRECT /CHECK /SLOW .EXE -
*BATCON, CDRIVE, LPTSPL, NEBULA, OPR,    -
*ORION,  PLEASE, PULSAR, QUASAR, QUEUE,  -
*SPRINT
.PLEASE	GALAXY Generation Successful
.GOTO END

%CERR:: .GOTO ERROR
%ERR::  .GOTO ERROR
%TERR:: .GOTO ERROR
ERROR:: .PLEASE Error During GALAXY Generation
END::
%FIN::
;[End of GALAXY.CTL]
