;%1(65) - Version # of TWICE.CTL   14-Jan-83 Tony Wachs /TW/GMU/RCB/DPM
;
; Submit with command  .QUEUE I:=TWICE/RESTART:1/TIME:10:00
;
; Required files:  (latest released versions)
;	DIRECT.EXE
;	MACRO.EXE
;	LINK.EXE
;	LNK???.EXE
;	TECO.EXE
;	CREF.EXE
;	DDT.REL
;
; Files that must be on DSK: and must all be appropriate
; to the same monitor load; i.e., COMMOD, ONCMOD, and
; MONGEN must have no version skew.
;	TWICE.MAC
;	TWICE.RND
;
; The following files from the monitor distribution
; tape are needed:
;	COMMOD.MAC
;	FGEN.HLP
;	FILFND.MAC
;	FILIO.MAC
;	FILUUO.MAC
;	FTEJBD.MAC
;	JOBDAT.MAC
;	MONGEN.MAC
;	MONITR.VER
;	ONCMOD.MAC
;	REFSTR.MAC
;	S.MAC
;
; Output files:
;	TWICE.DOC
;	TWICE.LST
;	TWICE.LOG
;	TWICE.EXE
;	TWICE.MAP
;
;
; Use field-image files
;
.ASSIGN DEC: SYS:
.ASSIGN DEC: REL:
.ASSIGN DEC: UNV:
.ERROR ?
.LOAD TTY:+DSK:MONGEN.MAC
*FTUNSUPPORTED==-1
=^Z
*FTUNSUPPORTED==-1
=^Z
.SAVE DSK:MONGEN
DOF::
.RUN MONGEN
*
*F	;Feature test dialog
*FTNOAC	;File name
*KLFULL	;Feature set
*NO	;Standard setting
*FTAUTC,0
*FTKLP,0
*
*N	;Set each switch
.R MACRO
*=FTNOAC
*=S
DOHDW::
.RUN MONGEN
*
*HDW	;Hardware dialog
*HDWMAX	;File name
*1090	;CPU type
*1	;number of CPUs
*MAXIMAL DISK SYSTEM
*9998	;Serial number
*Y	;Exclude monitor overhead
*Y	;EBOX/MBOX runtime accounting
*Y	;Exclude PI time from user runtime
*N	;Account verification
*N	;MOS memory
*N	;Auto-configure
*8	;Number of channels
*DF10C	;Channel type
*2	;RC10s
*4	;FHAs
*4	;FHBs
*2	;RH10s for RS04s
*8	;FSAs
*8	;FSBs
*0	;RH10s for RP04s
*0	;RP10s
*0	;TM10Bs
*0	;TM02s
*DF10C	;Channel type
*0	;RC10s
*0	;RH10s for RS04s
*0	;RH10s for RP04s
*3	;RP10s
*8	;DPAs
*8	;DPBs
*8	;DPCs
*0	;TM10Bs
*0	;TM02s
*DF10C	;Channel type
*0	;RC10s
*0	;RH10s for RS04s
*3	;RH10s for RP04s
*8	;RPAs
*8	;RPBs
*8	;RPCs
*0	;RP10s
*0	;TM10Bs
*0	;TM02s
*DF10C	;Channel type
*0	;RC10s
*0	;RH10s for RS04s
*3	;RH10s for RP04s
*8	;RPDs
*8	;RPEs
*8	;RPFs
*0	;RP10s
*0	;TM10Bs
*0	;TM02s
*RH20	;Channel type
*1	;RH20s for RP04s
*8	;RPGs
*1	;RH20s for RP20s
*N	;Dual ported
*8	;RNAs
*0	;DX20s
*0	;TM02s
*0	;TM78s
*RH20	;Channel type
*1	;RH20s for RP04s
*8	;RPHs
*1	;RH20s for RP20s
*N	;Dual ported
*8	;RNBs
*0	;DX20s
*0	;TM02s
*0	;TM78s
*RH20	;Channel type
*1	;RH20s for RP04s
*8	;RPIs
*1	;RH20s for RP20s
*N	;Dual ported
*8	;RNCs
*0	;DX20s
*0	;TM02s
*0	;TM78s
*RH20	;Channel type
*1	;RH20s for RP04s
*8	;RPJs
*1	;RH20s for RP20s
*N	;Dual ported
*8	;RNDs
*0	;DX20s
*0	;TM02s
*0	;TM78s
*0	;TM10As
*1	;DTEs
*RSX20F	;Type of front end
*0	;Console front-end terminals
*0	;Console front-end line printers
*0	;Console front-end card readers
*40	;Jobs
*0	;Maximum pages core per user
*256	;Total core
*60	;Ticks per second
*0	;Real time devices
*N	;Locking
*0	;HPQs
*N	;METER
*N	;KASER
*N	;MSGSER
*Y	;PSISER
*Y	;IPCSER
*N	;ENQ/DEQ
*0	;CDRs
*N	;CDP
*N	;DIS
*0	;TD10s
*0	;LPTs
*0	;PLTs
*N	;PTP
*N	;PTR
*0	;DA28s
*0	;DAS78s
*0	;DN60s
*20	;PTYs
*	;Decimal value definitions
*A00VER,66666
*A1090,0
*RP0,360	;Device code for first RP10
*RP1,360
*RP2,360
*RP3,360
*RP4,360
*RP5,360
*RP6,360
*RP7,360
*	;End octal value definitions
*	;Sixbit value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*	;Ersatz devices
*	;Commands
*	;Terminal types
=^Z
;
; Put correct monitor version number into TWICE
;
.R TECO
*ERMONITR.VER
.IF (NOERROR) .GOTO B1
; If no version number file, make one assuming 70201
.R TECO
*EWMONITR.VERHKI70201HPEF
B1::
.R TECO
*ERMONITR.VERYAZJI00000BJ.,.+5XA
*EBHDWMAX.MACY<N66666;-5DGA0TT>EF
;
;
; Compile, load, and save
;
BUILD::
.R MACRO
*COMMOD.MAX=HDWMAX,COMMOD
*VJBDAT.MAX=FTEJBD.MAC,JOBDAT.MAC
*FILFND.MAX=FILFND.MAC
*FILIO.MAX=FILIO.MAC
*FILUUO.MAX=FILUUO.MAC
*ONCMOD.MAX=ONCMOD.MAC
*REFSTR.MAX=REFSTR.MAC
TWICE::
.R MACRO
*TWICE,TWICE/C=HDWMAX,TWICE
.R CREF
*DSK:=TWICE
LINK::
.R LINK
*/NOINITIAL /HASH:5000 TWICE/SAVE, TWICE/MAP = /LOCALS -
*VJBDAT.MAX, FILFND.MAX, FILIO.MAX, FILUUO.MAX, ONCMOD.MAX, REFSTR.MAX, -
*COMMOD.MAX, REL:DDT, DSK:TWICE -
*/NOSYSLIBRARY /PATCHSIZE:100 /GO
.R RUNOFF (TWICE)
.IF (ERROR)
;
.DIRECT /CHECKS DSK: 'NOT' ACCESS
;
;
.PLEASE TWICE successful
;
;
.GOTO B2
%ERR::  ;
%CERR::  ;
ERROR:: .PLEASE TWICE.CTL failed
.GOTO B2
B2::  ;
; Remove all temporary files
.DELETE HDWMAX.BAK
.IF (ERROR) ;Don't care if failed
%FIN::  ;
;[End of TWICE.CTL]
