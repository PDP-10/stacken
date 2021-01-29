! Compile TOPS-10 form of DIT library on a TOPS-10 system.
!
! This control file does a build from the connected directory
! only using DEC: for SYS:
!
!
! Facility: DIT
! 
! Edit History:
!
! new_version (2, 0)
!
! Edit (%O'65', '11-Apr-84', 'Sandy Clemens')
! %(  Add DIT V2 files to DT2:. )%
!
! Edit (%O'103', '28-Sep-84', 'Sandy Clemens')
!   %( Update DTCM10.10-CTL to make the build easier for Release
!      Engineering and customers.  FILES: DTCM10.10-CTL, DITHST.BLI )%
!
! new_version (2, 1)
! 
! Edit (%O'112', '1-Jun-86', 'Sandy Clemens')
!   %( Add sources for version 2.1.  Update copyright notices. )%
! **EDIT**
!
! Files needed in this directory:
!	RMSUSR.R36	DITHST.BLI	DAPPER.B36	TTT.MAC     FT10.MAC
!	FIELDS.BLI	VERSION.REQ	STAR36.BLI
!
! System files needed:
!	MACRO.EXE	BLISS.EXE	CREF.EXE
!
! Files produced on connected directory:
! FILEDS.L36	STAR36.L36	VERSION.L36	TTT.REL		DAPPER.REL
! DITHST.REL
!
! 
! For release engineering or any other build from a single directory
! containing everything using vanilla tools.
!
.ERROR ?
.R BLISS
*FIELDS,FIELDS=FIELDS/LIB/TOPS10/KL
*STAR36,STAR36=STAR36/LIB/TOPS10/KL
*VERSIO,VERSIO=VERSIO/LIB/TOPS10/KL
*DAPPER,DAPPER=DAPPER.B36/TOPS10/KL
*DITHST,DITHST=DITHST/TOPS10/KL
.R MACRO
*TTT.REL=FT10.MAC,TTT.MAC
.
!
!
.QUEUE INP:DLMK10=/MODIFY/DEPEND:-1
%ERR::
.GOTO ERRRTN
%TERR::
ERRRTN::
! [%O'103'] Remove canceling of next jobs.
!
ENDEND::
%FIN::
.
