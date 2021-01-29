;***************************************************************************
;GEN  --  Master MONGEN dialog control file
;
;Unless otherwise stated, all monitors include the following, excepting of
;course any hardware limitations due to processor type:
;		All disk drivers
;		All printer drivers
;		All magtape drivers
;		ANF-10
;		DECnet-10
;		DECtape service
;		Ethernet
;		IBM commumications
;		KA10 floating point simulation
;		LAT service
;***************************************************************************
.DECLARE@BUILDS.DCL

;Standard KL "Features" MONGEN dialog
MKL::
.PA =KL:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*F	;Feature test dialog
*F	;File name
*KL10	;Option
*YES	;Standard switch settings
=^Z

;Standard/FTMP=0 KL "Features" MONGEN dialog
MKLF::
.PA =KLF:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*F	;Feature test dialog
*F	;File name
*KL10	;Option
*NO	;Standard switch settings
*MP,OFF	;No multiprocessor support
*
=^Z

;Standard KS "Features" MONGEN dialog
MKS::
.PA =KS:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*F	;Feature test dialog
*F	;File name
*KS10	;Option
*Y	;Standard switch settings
=^Z
;KL1322 "RA" MONGEN dialog
;
;	Standalone KL monitor
M1322A::
.PA =A:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*SYS	;Hardware dialog
*	;File name
*KL	;Processor type
*1	;# of CPUs
*RA###  DEC10 Development
*1322	;CPU0 serial number
*Y	;Exclude monitor overhead ?
*Y	;EBOX/MBOX runtime accounting ?
*Y	;Exclude PI time ?
*N	;Account verification ?
*Y	;MOS memory?
*YES	;SCA support?
*YES	;Ethernet support?
*NO	;SA10s
*NO	;RP03s
*NO	;Drums
*NO	;RS04s
*NO	;RPXKON (prompt)
*NO	;RNXKON
*YES	;RAXKON
*YES	;TM2KON
*YES	;TX1KON
*YES	;TD2KON
*YES	;T78KON
*NO	;TM10Bs
*NO	;TC10Cs
*YES	;LPTSER
*NO	;DLPSER
*NO	;PLTSER
*NO	;CDRSER
*NO	;DCRSER
*YES	;CDPSER
*YES	;PTPSER
*YES	;PTRSER
*Y	;D8SINT
*Y	;D6SINT
*Y	;MCB
*NO	;DC10
*16	;M0TTDN
*CTY	;OPR
*	;Data set lines
*40	;Jobs
*	;Pages core/user
*2048	;Total core
*4	;Real time devices
*10	;Core for non-locking jobs
*50	;Pages of EVM
*15	;# HPQs
*NO	;METER
*Y	;KASER ?
*Y	;MPXSER ?
*Y	;PSISER ?
*Y	;IPCSER ?
*Y	;ENQ/DEQ ?
*10	;Disk set
*NO	;Device loop
*20	;# PTYs
*Y	;Networks supported ?
;Central site name
*KL1322
*20	;# remote TTYs
*YES	;ANF-10 software?
*	;Default node name
*10	;Node number
*YES	;SET HOST inbound
*YES	;Network virtual terminals ?
*YES	;CDRs ?
*YES	;LPTs ?
*NO	;PTP
*NO	;PTR
*NO	;PLT
*YES	;DDPs ?
*YES	;RDXs ?
*YES	;TSKs ?
*50	;# of devices that can be connected
*YES	;DECnet software?
*	;Default node name
*7	;DECnet area number
*169	;DECnet node number
*ROUTING;DECnet router type
*	;Default xmit password
*YES	;NRTSER
*YES	;LAT software?
*	;Default service name
*	;Maximum number of LAT circuits
*	;Default to no service groups
*TTDMOS,96	;Make -20F strings longer
*MSGMAX,596	;Large network message size to accomodate DECnetwork
*FLCDEF,0	;Default filler class 
*TTYWID,80	;default tty width
*TTCHKS,8	;Larger tty chunk size
*TTYLCT,0	;TTY LC
*%RTBEA,512	;Maximum DECnet broadcast endnode adjacencies
*%DLBSZ,1476	;Maximum DECnet message size on ethernet
*	;End decimal value definitions
*CHGPPP,<20040,,0> ;Poke or Admin privs to do CHGPPN
*PRVPRV,<^-40,,0> ;No admin privs for automatic jobs
*PRVFIL,055
*RTCH1,1
*MTDLTP,0	;Standard magtape labels are bypass
*ANFNIP,60026	;ANF Ethernet protocol 60-16
*M.EDIT,1	;Enable TTY EDITOR
*M.DNMX,140000	;Maximum for DECnet freecore
*	;End octal value definitions
*	;End SIXBIT value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*	;End user defined ersatz device names
*PIVOT,,RUNFLG,,
*PATH,,RUNFLG,UNIQ.2,
*<<>,PATH,RUNFLG!APPFLG,,
*<=>,PATH,RUNFLG!APPFLG,,
*<>>,PATH,RUNFLG!APPFLG,,
*WHO,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,WHO
*LINE,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,
*STRUCT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*UNIT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*NCOPY,#RUNNFT,RUNFLG,,
*NDELET,#RUNNFT,RUNFLG,,
*NDIREC,#RUNNFT,RUNFLG,,
*NMOVE,#RUNNFT,RUNFLG,,
*NRENAM,#RUNNFT,RUNFLG,,
*NREVIE,#RUNNFT,RUNFLG,,
*NTYPE,#RUNNFT,RUNFLG,,
*TLINK,#RUNNFT,RUNFLG,,
*TRANSL,,RUNFLG!APPFLG,,
*TYLOG,,RUNFLG!APPFLG,,
*FMAINT,,RUNFLG,,
*	;End user defined commands
*DUMB					;NEW CLASS
*80					;WIDTH
*0					;LENGTH
*0					;FILL
*XON,CRLF,LC				;BITS
*0					;TABLE ADDRESSES
*0
*0					;CONFORMANCE LEVELS
*0
*					;NO ATTRIBUTES
*					;NO MEMBER TYPES
*					;DONE DEFINING CLASSES
*VT52					;CLASS TO EXTEND
*H19					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT52
*VT100					;CLASS TO EXTEND
*H19A					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT100
*VT200					;CLASS TO EXTEND
*DAS21A					;NEW MEMBER TYPE
*					;ADD NO BITS
*VFW					;NO 132-COLUMN MODE
*					;DONE EXTENDING VT200
*					;DONE EXTENDING CLASSES
*DUMB					;DEFAULT TTY TYPE FOR SYSTEM
=^Z
;KL1322 "RB" MONGEN dialog
;
;	Standard KL single-processor
;		No networks
M1322B::
.PA =B:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*SYS	;Hardware dialog
*	;File name
*KL	;Processor type
*1	;# of CPUs
*RB###  DEC10 Development
*1322	;CPU0 serial number
*Y	;Exclude monitor overhead ?
*Y	;EBOX/MBOX runtime accounting ?
*Y	;Exclude PI time ?
*N	;Account verification ?
*Y	;MOS memory?
*YES	;SCA support?
*NO	;Ethernet support
*NO	;SA10s
*NO	;RP01
*NO	;DRUMS
*NO	;RS04
*NO	;RPXKON (prompt)
*NO	;RNXKON
*YES	;RAXKON
*YES	;TM2KON
*YES	;TX1KON
*YES	;TD2KON
*YES	;T78KON
*NO	;TM10B
*NO	;TC10C
*YES	;LPTSER
*NO	;DLPSER
*NO	;PLTSER
*NO	;CDRSER
*NO	;DCRSER
*YES	;CDPSER
*YES	;PTPSER
*YES	;PTRSER
*N	;D8SINT
*N	;D6SINT
*N	;MCB
*NO	;DC10
*16	;M0TTDN
*CTY	;OPR
*	;Data set lines
*40	;Jobs
*	;Pages core/user
*2048	;Total core
*4	;Real time devices
*10	;Core for non-locking jobs
*50	;Pages of EVM
*15	;# HPQs
*NO	;METER
*Y	;KASER ?
*Y	;MPXSER ?
*Y	;PSISER ?
*Y	;IPCSER ?
*Y	;ENQ/DEQ ?
*10	;Disk set
*NO	;Device loop
*20	;# PTYs
*N	;Network support
*TTDMOS,96	;Make -20F strings longer
*MSGMAX,596	;Large network message size to accomodate DECnetwork
*FLCDEF,0	;Default filler class 
*TTYWID,80	;default tty width
*TTCHKS,8	;Larger tty chunk size
*TTYLCT,0	;TTY LC
*	;End decimal value definitions
*CHGPPP,<20040,,0> ;Poke or Admin privs to do CHGPPN
*PRVPRV,<^-40,,0> ;No admin privs for automatic jobs
*PRVFIL,055
*RTCH1,1
*MTDLTP,0	;Standard magtape labels are bypass
*M.EDIT,1	;Enable TTY EDITOR
*	;End octal value definitions
*	;End SIXBIT value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*MDC,5,100,SYS	;Local ersatz device names (Monitor DoCumentation)
*ASG,66,3024,JOB	;SPR transfer area (DSKB: only)
*	;End user defined ersatz device names
*PIVOT,,RUNFLG,,
*PATH,,RUNFLG,UNIQ.2,
*<<>,PATH,RUNFLG!APPFLG,,
*<=>,PATH,RUNFLG!APPFLG,,
*<>>,PATH,RUNFLG!APPFLG,,
*WHO,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,WHO
*LINE,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,
*STRUCT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*UNIT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*NCOPY,#RUNNFT,RUNFLG,,
*NDELET,#RUNNFT,RUNFLG,,
*NDIREC,#RUNNFT,RUNFLG,,
*NMOVE,#RUNNFT,RUNFLG,,
*NRENAM,#RUNNFT,RUNFLG,,
*NREVIE,#RUNNFT,RUNFLG,,
*NTYPE,#RUNNFT,RUNFLG,,
*TLINK,#RUNNFT,RUNFLG,,
*TRANSL,,RUNFLG!APPFLG,,
*TYLOG,,RUNFLG!APPFLG,,
*FMAINT,,RUNFLG,,
*	;End user defined commands
*DUMB					;NEW CLASS
*80					;WIDTH
*0					;LENGTH
*0					;FILL
*XON,CRLF,LC				;BITS
*0					;TABLE ADDRESSES
*0
*0					;CONFORMANCE LEVELS
*0
*					;NO ATTRIBUTES
*					;NO MEMBER TYPES
*					;DONE DEFINING CLASSES
*VT52					;CLASS TO EXTEND
*H19					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT52
*VT100					;CLASS TO EXTEND
*H19A					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT100
*VT200					;CLASS TO EXTEND
*DAS21A					;NEW MEMBER TYPE
*					;ADD NO BITS
*VFW					;NO 132-COLUMN MODE
*					;DONE EXTENDING VT200
*					;DONE EXTENDING CLASSES
*DUMB					;DEFAULT TTY TYPE FOR SYSTEM
=^Z
M2476F::
.PA =F:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*SYS	;Hardware dialog
*	;File name
*KL	;Processor type
*1	;# of CPUs
*RF###  DEC10 Development
*2476	;CPU0 serial number
*Y	;Exclude monitor overhead ?
*Y	;EBOX/MBOX runtime accounting ?
*Y	;Exclude PI time ?
*Y	;Account verification ?
*Y	;MOS memory?
*YES	;SCA support?
*YES	;Ethernet support
*NO	;SA10s
*NO	;RP01
*NO	;DRUMS
*NO	;RS04
*NO	;RPXKON (Prompt)
*NO	;RNXKON
*YES	;RAXKON
*YES	;TM2KON
*NO	;TX1KON
*NO	;TD2KON
*YES	;T78KON
*NO	;TM10B
*NO	;TC10C
*NO	;LPTSER
*YES	;DLPSER
*NO	;PLTSER
*NO	;CDRSER
*NO	;DCRSER
*N	;CDPSER
*N	;PTPSER
*N	;PTRSER
*N	;D8SINT
*Y	;D6SINT
*N	;MCB
*NO	;DC10
*16	;M0TTDN
*CTY	;OPR
*	;Data set lines
*50	;Jobs
*	;Pages core/user
*2048	;Total core
*4	;Real time devices
*10	;Core for non-locking jobs
*50	;Pages of EVM
*15	;# HPQs
*NO	;METER
*Y	;KASER ?
*Y	;MPXSER ?
*Y	;PSISER ?
*Y	;IPCSER ?
*Y	;ENQ/DEQ ?
*6	;Disk set
*NO	;Device loop
*20	;# PTYs
*Y	;Networks supported ?
;Central site name
*KL2476
*100	;# remote TTYs
*YES	;ANF-10 software?
*	;Default node name
*67	;Node number
*YES	;SET HOST inbound
*YES	;Network virtual terminals ?
*YES	;CDRs ?
*YES	;LPTs ?
*NO	;PTP
*NO	;PTR
*NO	;PLT
*YES	;DDPs ?
*YES	;RDXs ?
*YES	;TSKs ?
*50	;# of devices that can be connected
*YES	;DECnet software?
*	;Default node name
*7	;DECnet area number
*80	;DECnet node number
*ROUTING;DECnet router type
*	;Default xmit password
*YES	;NRTSER
*YES	;LAT software?
*	;Default service name
*	;Maximum number of LAT circuits
*3-4,7,10,18,29,45-46	;Service groups enabled
*TTDMOS,96	;Make -20F strings longer
*MSGMAX,596	;Large network message size to accomodate DECnetwork
*M.CBMX,400	;Big disk cache for big SIRS ufds
*FLCDEF,0	;Default filler class 
*TTYWID,80	;default tty width
*TTCHKS,8	;Larger tty chunk size
*TTYLCT,0	;TTY LC
*%RTBEA,512	;Maximum DECnet broadcast endnode adjacencies
*%DLBSZ,1476	;Maximum DECnet message size on ethernet
*	;End decimal value definitions
*CHGPPP,<20040,,0> ;Poke or Admin privs to do CHGPPN
*PRVPRV,<^-40,,0> ;No admin privs for automatic jobs
*PRVFIL,055
*RTCH1,1
*MTDLTP,0	;Standard magtape labels are bypass
*ANFNIP,60026	;ANF Ethernet protocol 60-16
*M.EDIT,1	;Enable TTY EDITOR
*M.DNMX,140000	;Maximum for DECnet freecore
*	;End octal value definitions
*	;End SIXBIT value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*MDC,5,100,SYS	;Local ersatz device names (Monitor DoCumentation)
*ASG,66,3024,JOB	;SPR transfer area (DSKB: only)
*	;End user defined ersatz device names
*PIVOT,,RUNFLG,,
*PATH,,RUNFLG,UNIQ.2,
*<<>,PATH,RUNFLG!APPFLG,,
*<=>,PATH,RUNFLG!APPFLG,,
*<>>,PATH,RUNFLG!APPFLG,,
*WHO,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,WHO
*LINE,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,
*STRUCT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*UNIT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*NCOPY,#RUNNFT,RUNFLG,,
*NDELET,#RUNNFT,RUNFLG,,
*NDIREC,#RUNNFT,RUNFLG,,
*NMOVE,#RUNNFT,RUNFLG,,
*NRENAM,#RUNNFT,RUNFLG,,
*NREVIE,#RUNNFT,RUNFLG,,
*NTYPE,#RUNNFT,RUNFLG,,
*TLINK,#RUNNFT,RUNFLG,,
*TRANSL,,RUNFLG!APPFLG,,
*TYLOG,,RUNFLG!APPFLG,,
*FMAINT,,RUNFLG,,
*	;End user defined commands
*DUMB					;NEW CLASS
*80					;WIDTH
*0					;LENGTH
*0					;FILL
*XON,CRLF,LC				;BITS
*0					;TABLE ADDRESSES
*0
*0					;CONFORMANCE LEVELS
*0
*					;NO ATTRIBUTES
*					;NO MEMBER TYPES
*					;DONE DEFINING CLASSES
*VT52					;CLASS TO EXTEND
*H19					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT52
*VT100					;CLASS TO EXTEND
*H19A					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT100
*VT200					;CLASS TO EXTEND
*DAS21A					;NEW MEMBER TYPE
*					;ADD NO BITS
*VFW					;NO 132-COLUMN MODE
*					;DONE EXTENDING VT200
*					;DONE EXTENDING CLASSES
*DUMB					;DEFAULT TTY TYPE FOR SYSTEM
=^Z
;KL1322 "RK" MONGEN dialog
;
;	KLAD-10 KL monitor
MKLAD::
.PA =K:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*SYS	;Hardware dialog
*	;File name
*KL	;Processor type
*1	;# of CPUs
*RK###  DEC10 Development
*1	;CPU0 serial number
*Y	;Exclude monitor overhead ?
*Y	;EBOX/MBOX runtime accounting ?
*Y	;Exclude PI time ?
*N	;Account verification ?
*Y	;MOS memory?
*YES	;SCA support?
*YES	;Ethernet support?
*NO	;SA10s
*NO	;RP03s
*NO	;Drums
*NO	;RS04s
*NO	;RPXKON (prompt)
*YES	;RNXKON
*YES	;RAXKON
*YES	;TM2KON
*YES	;TX1KON
*YES	;TD2KON
*YES	;T78KON
*NO	;TM10Bs
*NO	;TC10Cs
*YES	;LPTSER
*YES	;DLPSER
*YES	;PLTSER
*YES	;CDRSER
*YES	;DCRSER
*YES	;CDPSER
*YES	;PTPSER
*YES	;PTRSER
*Y	;D8SINT
*Y	;D6SINT
*Y	;MCB
*NO	;DC10
*16	;M0TTDN
*CTY	;OPR
*	;Data set lines
*40	;Jobs
*	;Pages core/user
*2048	;Total core
*4	;Real time devices
*10	;Core for non-locking jobs
*50	;Pages of EVM
*15	;# HPQs
*NO	;METER
*Y	;KASER ?
*Y	;MPXSER ?
*Y	;PSISER ?
*Y	;IPCSER ?
*Y	;ENQ/DEQ ?
*36	;Disk set
*NO	;Device loop
*20	;# PTYs
*Y	;Networks supported ?
;Central site name
*KLAD10
*20	;# remote TTYs
*YES	;ANF-10 software?
*	;Default node name
*36	;Node number
*YES	;SET HOST inbound
*YES	;Network virtual terminals ?
*YES	;CDRs ?
*YES	;LPTs ?
*NO	;PTP
*NO	;PTR
*NO	;PLT
*YES	;DDPs ?
*YES	;RDXs ?
*YES	;TSKs ?
*50	;# of devices that can be connected
*YES	;DECnet software?
*	;Default node name
*7	;DECnet area number
*236	;DECnet node number
*ROUTING;DECnet router type
*	;Default xmit password
*YES	;NRTSER
*YES	;LAT software?
*	;Default service name
*	;Maximum number of LAT circuits
*	;Default to no service groups
*TTDMOS,96	;Make -20F strings longer
*MSGMAX,596	;Large network message size to accomodate DECnetwork
*FLCDEF,0	;Default filler class 
*TTYWID,80	;default tty width
*TTCHKS,8	;Larger tty chunk size
*TTYLCT,0	;TTY LC
*%RTBEA,512	;Maximum DECnet broadcast endnode adjacencies
*%DLBSZ,1476	;Maximum DECnet message size on ethernet
*	;End decimal value definitions
*PRVPRV,<^-40,,0> ;No admin privs for automatic jobs
*PRVFIL,055
*RTCH1,1
*MTDLTP,0	;Standard magtape labels are bypass
*ANFNIP,60026	;ANF Ethernet protocol 60-16
*M.EDIT,1	;Enable TTY EDITOR
*M.DNMX,140000	;Maximum for DECnet freecore
*	;End octal value definitions
*	;End SIXBIT value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*	;End user defined ersatz device names
*PIVOT,,RUNFLG,,
*PATH,,RUNFLG,UNIQ.2,
*<<>,PATH,RUNFLG!APPFLG,,
*<=>,PATH,RUNFLG!APPFLG,,
*<>>,PATH,RUNFLG!APPFLG,,
*WHO,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,WHO
*LINE,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,
*STRUCT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*UNIT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*NCOPY,#RUNNFT,RUNFLG,,
*NDELET,#RUNNFT,RUNFLG,,
*NDIREC,#RUNNFT,RUNFLG,,
*NMOVE,#RUNNFT,RUNFLG,,
*NRENAM,#RUNNFT,RUNFLG,,
*NREVIE,#RUNNFT,RUNFLG,,
*NTYPE,#RUNNFT,RUNFLG,,
*TLINK,#RUNNFT,RUNFLG,,
*TRANSL,,RUNFLG!APPFLG,,
*TYLOG,,RUNFLG!APPFLG,,
*FMAINT,,RUNFLG,,
*	;End user defined commands
*DUMB					;NEW CLASS
*80					;WIDTH
*0					;LENGTH
*0					;FILL
*XON,CRLF,LC				;BITS
*0					;TABLE ADDRESSES
*0
*0					;CONFORMANCE LEVELS
*0
*					;NO ATTRIBUTES
*					;NO MEMBER TYPES
*					;DONE DEFINING CLASSES
*VT52					;CLASS TO EXTEND
*H19					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT52
*VT100					;CLASS TO EXTEND
*H19A					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT100
*VT200					;CLASS TO EXTEND
*DAS21A					;NEW MEMBER TYPE
*					;ADD NO BITS
*VFW					;NO 132-COLUMN MODE
*					;DONE EXTENDING VT200
*					;DONE EXTENDING CLASSES
*DUMB					;DEFAULT TTY TYPE FOR SYSTEM
=^Z
;KL1026 "RL" MONGEN dialog
;
;	Standard KL triple-processor
;		DECtapes
;		KA10 floating point simulation
M1026L::
.PA =L:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*SYS	;Hardware dialog
*	;File name
*KL	;Processor type
*3	;# of CPUs
*RL###  DEC10 Development
*1026	;CPU0 serial number
*1042	;CPU1 serial number
*1322	;CPU2 serial number
*Y	;Exclude monitor overhead ?
*Y	;EBOX/MBOX runtime accounting ?
*Y	;Exclude PI time ?
*Y	;Account verification ?
*Y	;MOS memory?
*YES	;SCA support?
*YES	;Ethernet support
*NO	;SA10s
*NO	;RP01
*NO	;DRUMS
*NO	;RS04
*YES	;RPXKON (Prompt)
*2,2,2	;Kontrollers per CPU
*NO	;Done
*NO	;RNXKON
*YES	;RAXKON
*PROMPT	;TM2KON
*1,1,2	;Kontrollers per CPU
*NO	;DONE
*YES	;TX1KON
*YES	;TD2KON
*YES	;T78KON
*NO	;TM10B
*NO	;TC10C
*PROMPT	;LPTSER
*0,1,0	;Per-CPU reservations
*NO	;DONE
*NO	;DLPSER
*NO	;PLTSER
*NO	;CDRSER
*NO	;DCRSER
*PROMPT	;CDPSER
*0,0,1	;DEVICES PER CPU
*NO	;DONE
*PROMPT	;PTPSER
*0,0,1	;DEVICES PER CPU
*NO	;DONE
*PROMPT	;PTRSER
*0,0,1	;DEVICES PER CPU
*NO	;DONE
*Y	;D8SINT
*Y	;D6SINT
*Y	;MCB
*NO	;DC10
*16	;M0TTDN
*16	;M1TTDN
*16	;M2TTDN
*CTY	;OPR
*	;Data set lines
*100	;Jobs
*	;Pages core/user
*2048	;Total core
*4	;Real time devices
*10	;Core for non-locking jobs
*50	;Pages of EVM
*15	;# HPQs
*NO	;METER
*Y	;KASER ?
*Y	;MPXSER ?
*Y	;PSISER ?
*Y	;IPCSER ?
*Y	;ENQ/DEQ ?
*26	;Disk set
*YES	;Device loop
*NO	;DIS device
*0	;# TD10s
*0	;DA28s
*0	;DAS78s
*0	;DN60s
*0	;DN87s
*1	;# TD10s
*4	;# DTAs
*0	;# TD10s
*20	;# PTYs
*Y	;Networks supported ?
;Central site name
*KL1026
*50	;# remote TTYs
*YES	;ANF-10 software?
*	;Default node name
*26	;Node number
*YES	;SET HOST inbound
*YES	;Network virtual terminals ?
*YES	;CDRs ?
*YES	;LPTs ?
*NO	;PTP
*NO	;PTR
*NO	;PLT
*YES	;DDPs ?
*YES	;RDXs ?
*YES	;TSKs ?
*250	;# of devices that can be connected
*YES	;DECnet software?
*	;Default node name
*7	;DECnet area number
*110	;DECnet node number
*NONROUTING;DECnet router type
*	;Default xmit password
*YES	;NRTSER
*YES	;LAT software?
*	;Default service name
*	;Maximum number of LAT circuits
*3-4,7,10,18,29,45-46	;Service groups enabled
*TTDMOS,96	;Make -20F strings longer
*MSGMAX,596	;Large network message size to accomodate DECnetwork
*M.CBMX,400	;Big disk cache for big SIRS ufds
*FLCDEF,0	;Default filler class 
*TTYWID,80	;default tty width
*TTCHKS,8	;Larger tty chunk size
*TTYLCT,0	;TTY LC
*%RTBEA,512	;Maximum DECnet broadcast endnode adjacencies
*%DLBSZ,1476	;Maximum DECnet message size on ethernet
*	;End decimal value definitions
*CHGPPP,<20040,,0> ;Poke or Admin privs to do CHGPPN
*PRVPRV,<^-40,,0> ;No admin privs for automatic jobs
*PRVFIL,055
*RTCH1,1
*MTDLTP,0	;Standard magtape labels are bypass
*ANFNIP,60026	;ANF Ethernet protocol 60-16
*M.EDIT,1	;Enable TTY EDITOR
*M.DNMX,140000	;Maximum for DECnet freecore
*	;End octal value definitions
*	;End SIXBIT value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*MDC,5,100,SYS	;Local ersatz device names (Monitor DoCumentation)
*ASG,66,3024,JOB	;SPR transfer area (DSKB: only)
*	;End user defined ersatz device names
*PIVOT,,RUNFLG,,
*PATH,,RUNFLG,UNIQ.2,
*<<>,PATH,RUNFLG!APPFLG,,
*<=>,PATH,RUNFLG!APPFLG,,
*<>>,PATH,RUNFLG!APPFLG,,
*WHO,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,WHO
*LINE,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,
*STRUCT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*UNIT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*NCOPY,#RUNNFT,RUNFLG,,
*NDELET,#RUNNFT,RUNFLG,,
*NDIREC,#RUNNFT,RUNFLG,,
*NMOVE,#RUNNFT,RUNFLG,,
*NRENAM,#RUNNFT,RUNFLG,,
*NREVIE,#RUNNFT,RUNFLG,,
*NTYPE,#RUNNFT,RUNFLG,,
*TLINK,#RUNNFT,RUNFLG,,
*TRANSL,,RUNFLG!APPFLG,,
*TYLOG,,RUNFLG!APPFLG,,
*FMAINT,,RUNFLG,,
*	;End user defined commands
*DUMB					;NEW CLASS
*80					;WIDTH
*0					;LENGTH
*0					;FILL
*XON,CRLF,LC				;BITS
*0					;TABLE ADDRESSES
*0
*0					;CONFORMANCE LEVELS
*0
*					;NO ATTRIBUTES
*					;NO MEMBER TYPES
*					;DONE DEFINING CLASSES
*VT52					;CLASS TO EXTEND
*H19					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT52
*VT100					;CLASS TO EXTEND
*H19A					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT100
*VT200					;CLASS TO EXTEND
*DAS21A					;NEW MEMBER TYPE
*					;ADD NO BITS
*VFW					;NO 132-COLUMN MODE
*					;DONE EXTENDING VT200
*					;DONE EXTENDING CLASSES
*DUMB					;DEFAULT TTY TYPE FOR SYSTEM
=^Z
;KL2476 "RP" MONGEN dialog
;
;	Single processor Autopatch monitor
;		CI disks
;		Front end printers
;		Massbus disks
;		No DECtapes
;		TM02/TM03 magtapes
;		TM78 magtapes
M2476P::
.PA =P:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*SYS	;Hardware dialog
*	;File name
*KL	;Processor type
*1	;# of CPUs
*RP###  DEC10 Development
*2476	;CPU0 serial number
*Y	;Exclude monitor overhead ?
*Y	;EBOX/MBOX runtime accounting ?
*Y	;Exclude PI time ?
*Y	;Account verification ?
*Y	;MOS memory?
*YES	;SCA support?
*YES	;Ethernet support
*NO	;SA10s
*NO	;RP01
*NO	;DRUMS
*NO	;RS04
*NO	;RPXKON (Prompt)
*NO	;RNXKON
*YES	;RAXKON
*YES	;TM2KON
*NO	;TX1KON
*NO	;TD2KON
*YES	;T78KON
*NO	;TM10B
*NO	;TC10C
*NO	;LPTSER
*YES	;DLPSER
*NO	;PLTSER
*NO	;CDRSER
*NO	;DCRSER
*N	;CDPSER
*N	;PTPSER
*N	;PTRSER
*N	;D8SINT
*Y	;D6SINT
*N	;MCB
*NO	;DC10
*16	;M0TTDN
*CTY	;OPR
*	;Data set lines
*50	;Jobs
*	;Pages core/user
*2048	;Total core
*4	;Real time devices
*10	;Core for non-locking jobs
*50	;Pages of EVM
*15	;# HPQs
*NO	;METER
*Y	;KASER ?
*Y	;MPXSER ?
*Y	;PSISER ?
*Y	;IPCSER ?
*Y	;ENQ/DEQ ?
*6	;Disk set
*NO	;Device loop
*20	;# PTYs
*Y	;Networks supported ?
;Central site name
*KL2476
*100	;# remote TTYs
*YES	;ANF-10 software?
*	;Default node name
*67	;Node number
*YES	;SET HOST inbound
*YES	;Network virtual terminals ?
*YES	;CDRs ?
*YES	;LPTs ?
*NO	;PTP
*NO	;PTR
*NO	;PLT
*YES	;DDPs ?
*YES	;RDXs ?
*YES	;TSKs ?
*50	;# of devices that can be connected
*YES	;DECnet software?
*	;Default node name
*7	;DECnet area number
*80	;DECnet node number
*ROUTING;DECnet router type
*	;Default xmit password
*YES	;NRTSER
*YES	;LAT software?
*	;Default service name
*	;Maximum number of LAT circuits
*3-4,7,10,18,29,45-46	;Service groups enabled
*TTDMOS,96	;Make -20F strings longer
*MSGMAX,596	;Large network message size to accomodate DECnetwork
*M.CBMX,400	;Big disk cache for big SIRS ufds
*FLCDEF,0	;Default filler class 
*TTYWID,80	;default tty width
*TTCHKS,8	;Larger tty chunk size
*TTYLCT,0	;TTY LC
*%RTBEA,512	;Maximum DECnet broadcast endnode adjacencies
*%DLBSZ,1476	;Maximum DECnet message size on ethernet
*	;End decimal value definitions
*CHGPPP,<20040,,0> ;Poke or Admin privs to do CHGPPN
*PRVPRV,<^-40,,0> ;No admin privs for automatic jobs
*PRVFIL,055
*RTCH1,1
*MTDLTP,0	;Standard magtape labels are bypass
*ANFNIP,60026	;ANF Ethernet protocol 60-16
*M.EDIT,1	;Enable TTY EDITOR
*M.DNMX,140000	;Maximum for DECnet freecore
*	;End octal value definitions
*	;End SIXBIT value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*MDC,5,100,SYS	;Local ersatz device names (Monitor DoCumentation)
*ASG,66,3024,JOB	;SPR transfer area (DSKB: only)
*	;End user defined ersatz device names
*PIVOT,,RUNFLG,,
*PATH,,RUNFLG,UNIQ.2,
*<<>,PATH,RUNFLG!APPFLG,,
*<=>,PATH,RUNFLG!APPFLG,,
*<>>,PATH,RUNFLG!APPFLG,,
*WHO,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,WHO
*LINE,WHO,RUNFLG!NOLOGIN!APPFLG,UNIQ.1!UNIQ.2,
*STRUCT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*UNIT,WHO,RUNFLG!NOLOGIN!APPFLG,,
*NCOPY,#RUNNFT,RUNFLG,,
*NDELET,#RUNNFT,RUNFLG,,
*NDIREC,#RUNNFT,RUNFLG,,
*NMOVE,#RUNNFT,RUNFLG,,
*NRENAM,#RUNNFT,RUNFLG,,
*NREVIE,#RUNNFT,RUNFLG,,
*NTYPE,#RUNNFT,RUNFLG,,
*TLINK,#RUNNFT,RUNFLG,,
*TRANSL,,RUNFLG!APPFLG,,
*TYLOG,,RUNFLG!APPFLG,,
*FMAINT,,RUNFLG,,
*	;End user defined commands
*DUMB					;NEW CLASS
*80					;WIDTH
*0					;LENGTH
*0					;FILL
*XON,CRLF,LC				;BITS
*0					;TABLE ADDRESSES
*0
*0					;CONFORMANCE LEVELS
*0
*					;NO ATTRIBUTES
*					;NO MEMBER TYPES
*					;DONE DEFINING CLASSES
*VT52					;CLASS TO EXTEND
*H19					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT52
*VT100					;CLASS TO EXTEND
*H19A					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT100
*VT200					;CLASS TO EXTEND
*DAS21A					;NEW MEMBER TYPE
*					;ADD NO BITS
*VFW					;NO 132-COLUMN MODE
*					;DONE EXTENDING VT200
*					;DONE EXTENDING CLASSES
*DUMB					;DEFAULT TTY TYPE FOR SYSTEM
=^Z
;TWINKY "RS" MONGEN dialog
;
;	Standard KS single-processor
M4097S::
.PA =S:
.RUN DSK:MONGEN
*N	;Write no MONGEN.MIC
*SHORT	;Type of help desired
*SYS	;Hardware dialog
*	;File name
*KS	;Processor type
*RS###  Hostess Twinky
*4097	;CPU0 serial number
*Y	;Exclude monitor overhead ?
*Y	;Account verification ?
*NO	;Ethernet support
*NO	;RPXKON (prompt)
*YES	;TM2KON
*YES	;UNIBUS line printer service
*YES	;UNIBUS card reader service
*8	;# DZ lines
*CTY	;OPR
*0-6	;Data set lines
*	;End of data set lines
*30	;Jobs
*	;Pages core/user
*512	;Total core
*60	;Ticks/sec
*Y	;Allow locking ?
*10	;Core for non-locking jobs
*10	;Pages of EVM
*2	;# HPQs
*NO	;METER
*Y	;KASER ?
*Y	;MPXSER ?
*Y	;PSISER ?
*Y	;IPCSER ?
*Y	;ENQ/DEQ ?
*7	;Disk set
*YES	;Weird hardware
*1	;# RX211 Floppy disk controllers
*2	;# RX02 drives
*2	;# KMC/DUP-11s
*ANF10	;Default for line 0 (Goes to NOVA/KL1026)
*DECNET	;Default for line 1 (Goes to JINX/KL1026)
*0	;# DMR11s
*15	;# PTYs
*Y	;Networks supported ?
;Central site name
*TWINKY
*32	;# remote TTYs
*YES	;ANF-10 software?
*	;Default node name
*77	;Node number
*YES	;SET HOST inbound
*YES	;Network virtual terminals ?
*YES	;CDRs ?
*YES	;LPTs ?
*NO	;PTP
*NO	;PTR
*NO	;PLT
*NO	;DDPs ?
*YES	;RDXs ?
*YES	;TSKs ?
*32	;# of devices that can be connected
*YES	;DECnet softwre?
*	;Default node name
*7	;DECnet area number
*117	;Our central site node number
*ROUTING;DECnet router type
*	;Default xmit password
*YES	;NRTSER
*MSGMAX,596	;Large network message size to accomodate DECnetwork
*TTYWID,80	;default tty width
*TTCHKS,8	;increased chunk size
*TTYLCT,0	;default tty lc
*	;End decimal value definitions
*CHGPPP,<20040,,0> ;Poke or Admin privs to do CHGPPN
*PRVPRV,<^-40,,0> ;No admin privs for automatic jobs
*PRVFIL,055
*RTCH1,1
*MTDLTP,0	;Standard magtape labels are bypass
*M.EDIT,1	;Enable TTY EDITOR
*	;End octal value definitions
*	;Sixbit value definitions
*	;DEV,PI
*	;DEV,PI,#
*	;DEV,PI,AC
*MDC,5,100,SYS	;Local ersatz device names (Monitor DoCumentation)
*ASG,66,3024,JOB	;SPR transfer area (DSKB: only)
*	;End user defined ersatz device names
*PIVOT,,RUNFLG,,
*PATH,,RUNFLG,UNIQ.2,
*<<>,PATH,RUNFLG!APPFLG,,
*<=>,PATH,RUNFLG!APPFLG,,
*<>>,PATH,RUNFLG!APPFLG,,
*WHO,,RUNFLG!NOLOGIN,UNIQ.1!UNIQ.2,WHO
*LINE,WHO,RUNFLG!NOLOGIN,UNIQ.1!UNIQ.2,
*NCOPY,#RUNNFT,RUNFLG,,
*NDELET,#RUNNFT,RUNFLG,,
*NDIREC,#RUNNFT,RUNFLG,,
*NMOVE,#RUNNFT,RUNFLG,,
*NRENAM,#RUNNFT,RUNFLG,,
*NREVIE,#RUNNFT,RUNFLG,,
*NTYPE,#RUNNFT,RUNFLG,,
*TLINK,#RUNNFT,RUNFLG,,
*TRANSL,,RUNFLG!APPFLG,,
*TYLOG,,RUNFLG!APPFLG,,
*FMAINT,,RUNFLG,,
*	;End user defined commands
*DUMB					;NEW CLASS
*80					;WIDTH
*0					;LENGTH
*0					;FILL
*XON,CRLF,LC				;BITS
*0					;TABLE ADDRESSES
*0
*0					;CONFORMANCE LEVELS
*0
*					;NO ATTRIBUTES
*					;NO MEMBER TYPES
*					;DONE DEFINING CLASSES
*VT52					;CLASS TO EXTEND
*H19					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT52
*VT100					;CLASS TO EXTEND
*H19A					;NEW MEMBER TYPE
*					;NORMAL BITS
*
*					;DONE EXTENDING VT100
*VT200					;CLASS TO EXTEND
*DAS21A					;NEW MEMBER TYPE
*					;ADD NO BITS
*VFW					;NO 132-COLUMN MODE
*					;DONE EXTENDING VT200
*					;DONE EXTENDING CLASSES
*DUMB					;DEFAULT TTY TYPE FOR SYSTEM
=^Z
