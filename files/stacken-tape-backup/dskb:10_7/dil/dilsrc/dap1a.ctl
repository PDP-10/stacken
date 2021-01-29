! This CTL file builds the library and relocatable object files which
! make up the DAP machine for FTS and the DIL.
!
! Start at tag WORK to build from the connected directory followed by
! the ALU libraries.
!
! Start at tag MASTER to build from the ALU libraries.
!
! Start at tag RENG to build from the connected directory only, using
! field-image tools.
!
! Input files implicitly required:
!	BLI:XPORT.L36		XPORT definitions
!	BLI:TENDEF.L36		Monitor library
!	CONDIT.L36		Condition handling (should be in [,,EXT])
!	BLSNET.L36		Blissnet library (should be in [,,XPN])
!	RMSBLK.L36		RMS blocks (should be in [,,EXT])
!	RMSLIB.L36		RMS user interface (should be in [,,EXT])
!	RMSERR.REL		RMS error handler (should be in [,,EXT])
!
! Source files needed:
!	DAPMAC.REQ		Macros to do DAP
!	DAPBLK.REQ		DAP blocks
!	DAPCOD.REQ		DAP messages
!	COPYRI.BLI		Copyright notice
!	CPYRIT.MAC		Copyright notice
!	DAP.BLI			DAP message processing routines
!	DAPERR.BLI		DAP error handling
!	DAPSUB.BLI		Get and put DAP objects
!	DIRECT.BLI		Handle directories
!	DIRLST.BLI		Directory listing routine
!	DIR10.B36		Handle TOPS10 filespecs
!	STRING.B36		String-handling functions
!	SETAI.BLI		Handle access information
!	NXTFIL.BLI		Get next file
!	NXTF20.B36		Get next local file
!	DAPT10.B36		TOPS10 DAP routines
!	GETPUT.BLI		GET, PUT, and CONNECT
!	OPEN.BLI		Open a file
!	RDWRIT.B36		Block I/O
!	TRACE.BLI		Trace code
!	M11FIL.B36		MACY11 file service
!
! Output files produced:
!	DAP.L36			DAP macros library
!	COPYRI.REL		Copyright notice
!	CPYRIT.REL		Copyright notice
!	DAP.REL			DAP message processing routines
!	DAPERR.REL		DAP error handling
!	DAPSUB.REL		Get and put DAP objects
!	DAPT10.REL		TOPS10 DAP routines
!	DIR10.REL		Handle TOPS10 filespecs
!	DIRECT.REL		Handle directories
!	DIRLST.REL		Directory listing routine
!	GETPUT.REL		GET, PUT, and CONNECT
!	M11FIL.REL		MACY11 file service
!	NXTF20.REL		Get next local file
!	NXTFIL.REL		Get next file
!	OPEN.REL		Open a file
!	RDWRIT.REL		Block I/O
!	SETAI.REL		Handle access information
!	STRING.REL		String-handling functions
!	TRACE.REL		Trace code
!	DAP1V1.REL		Autopatch library for DAP routines
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'1', '12-Apr-84', 'Sandy Clemens')
! %( Add the TOPS-10 DAP sources for DIL V2.  Use the standard DIL
!    edit history format.
! )%
!
! Edit (%O'4', '28-Sep-84', 'Sandy Clemens')
!  %( Update DAP1A.10-CTL to make the build easier for Release Engineering
!     and customers.  FILES:  DAP1A.10-CTL and DAPHST.BLI  )%
! **EDIT**
WORK::
.path lib:/search=[,,ext],[,,xpn]
.GOTO COMBIN

MASTER::
.path lib:/search=[,,ext],[,,xpn]
.GOTO COMBIN

RENG::
.GOTO COMBIN

! Now build DAP machine.
COMBIN::
! Show logical names actually chosen.
.path /list:all
.NOERROR
! Do Bliss compilations
.R BLISS
*COPYRI,COPYRI=COPYRI/TOPS10/KL
*DAP,DAP=DAPMAC,DAPBLK,DAPCOD/TOPS10/KL/LIB
*DAP,DAP=DAP/TOPS10/KL
*DAPERR,DAPERR=DAPERR/TOPS10/KL
*DAPSUB,DAPSUB=DAPSUB/TOPS10/KL
*DIRECT,DIRECT=DIRECT/TOPS10/KL
*DIRLST,DIRLST=DIRLST/TOPS10/KL
*DIR10,DIR10=DIR10/TOPS10/KL
*STRING,STRING=STRING/TOPS10/KL
*SETAI,SETAI=SETAI/TOPS10/KL
*NXTFIL,NXTFIL=NXTFIL/TOPS10/KL
*NXTF20,NXTF20=NXTF20/TOPS10/KL
*DAPT10,DAPT10=DAPT10/TOPS10/KL
*GETPUT,GETPUT=GETPUT/TOPS10/KL
*OPEN,OPEN=OPEN/TOPS10/KL
*RDWRIT,RDWRIT=RDWRIT/TOPS10/KL
*TRACE,TRACE=TRACE/TOPS10/KL
*M11FIL,M11FIL=M11FIL/TOPS10/KL
! Do MACRO routines
.R MACRO
*CPYRIT,=CPYRIT
! Record checksums of what we produced
.DIRECTORY/CHECK DAP.L36,CPYRIT.REL,DAP.REL,DAPERR.REL,DAPSUB.REL,COPYRI.REL
.DIRECTORY/CHECK DAPT10.REL,DIR10.REL,DIRECT.REL,DIRLST.REL,GETPUT.REL
.DIRECTORY/CHECK M11FIL.REL,NXTF20.REL,NXTFIL.REL,OPEN.REL,RDWRIT.REL
.DIRECTORY/CHECK SETAI.REL,STRING.REL,TRACE.REL
! Delete old library
.DELETE DAP1V1.REL
! Construct new library
.COPY DAP1V1.REL=CPYRIT.REL,OPEN.REL,GETPUT.REL,M11FIL.REL,RDWRIT.REL,DAP.REL,DAPERR.REL,DAPSUB.REL,DAPT10.REL,DIRECT.REL,DIR10.REL,DIRLST.REL,NXTF20.REL,NXTFIL.REL,SETAI.REL,STRING.REL,TRACE.REL,COPYRI.REL,RMSERR.REL
! Record what was produced
.DIRECTORY/CHECK DAP1V1.REL
! [%O'4'] Modify next job.
.QUEUE INP:DXCM10= /MODIFY /DEPEND:-1
.GOTO ENDEND
%ERR::
ENDEND::
%FIN::
