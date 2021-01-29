! This CTL file builds the library and relocatable object file which
! make up the RMS extensions used by FTS and the DIL.
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
!	BLI:TENDEF.R36		Require file for system things
!
! Source files needed:
!	RMSUSR.R36		Require file for using RMS
!	RMS.R36			Require file for RMS
!	RMSBLK.R36		Require file for RMS blocks
!	RMSLIB.R36		Require file for RMS
!	CONDIT.REQ		Require file for condition handling
!	RMSERR.B36		RMS error handler source
!	UUODEF.R36		Require file for UUO usage
!
! Other files that live in this directory:
!	RMSINT.R36		Require file for using RMS internal routines
!
! Output files created:
!	RMSUSR.L36		Library file for using RMS
!	RMS.L36			Library file for RMS
!	RMSBLK.L36		Library file for RMS blocks
!	RMSLIB.L36		Library file for RMS
!	CONDIT.L36		Library file for condition handling
!	RMSERR.REL		RMS error handler .REL file
!	UUODEF.L36		Require file for UUO usage
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'1', '12-Apr-84', 'Sandy Clemens'
!  %( Add the TOPS-10 sources for the RMS extensions needed by DAPLIB-10
!     for DIL V2.  The sources which are the same as the TOPS-20 sources
!     are not included in the library.  Just use the 20 sources which are
!     in the library.  The names of the 10 sources are the same as the 20
!     sources, except that the 10-specific files have the 10-*** extensions.
!   )%
!
! Edit (%O'4', '28-Sep-84', 'Sandy Clemens')
!  %( Update EXT1A.10-CTL to make the build easier for Release Engineering
!     and customers.  FILES:  EXT1A.10-CTL and EXTHST.BLI  )%
! **EDIT**
WORK::
.GOTO COMBIN

MASTER::
.GOTO COMBIN

RENG::
.GOTO COMBIN

COMBIN::
! Show logical names actually chosen.
.path/list:all
.NOERROR
! Do Bliss compilations
.R BLISS
*RMSUSR,RMSUSR=RMSUSR/LIB/TOPS10/KL
*RMS,RMS=BLI:XPORT,DSK:RMSUSR,DSK:RMS/LIB/TOPS10/KL
*RMSBLK,RMSBLK=RMSBLK/LIB/TOPS10/KL
*RMSLIB,RMSLIB=RMSLIB/LIB/TOPS10/KL
*CONDIT,CONDIT=CONDIT/LIB/TOPS10/KL
*RMSERR,RMSERR=RMSERR/TOPS10/KL
*UUODEF,UUODEF=UUODEF/TOPS10/LIB/KL
! Record exactly what was produced
.DIRECTORY/CHECK RMSUSR.L36,RMS.L36,RMSBLK.L36,RMSLIB.L36,CONDIT.L36,RMSERR.REL,UUODEF.L36
! [%O'4'] Modify next job.
.QUEUE INP:XPN1A=/MODIFY/DEPEND:-1
.GOTO ENDEND
%ERR::
ENDEND::
%FIN::
