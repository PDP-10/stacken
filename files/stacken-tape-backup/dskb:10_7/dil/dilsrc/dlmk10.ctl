! This file makes the TOPS-10 version of the DIL from the existing REL
! files.
!
! This command file makes the dil libraries (for autopatch) and then
! the DIL.REL file itself, assuming the existence of the .REL files
! in canonical places (defined by logical names for the different modes
! this file can be sugmitted in).  Results are placed in DSTDL:.
!
! Start at at tag RENG to build from connected directory ONLY,
! using DEC: tools.
!
! Facility: DIL
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'72', '23-Feb-83', 'David Dyer-Bennet')
! %(  Add TOPS-10 native build procedure.  Related to DIX edit 33.
!     DLMK10.10-CTL: New procedure to build on tops-10
! )%
! Edit (%O'73', '10-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules.
! )%
! new_version (2, 0)
! 
! Edit (%O'75', '12-Apr-84', 'Sandy Clemens')
!  %( Put all Version 2 DIL development files under edit control.  Some
!     of the files listed below have major code edits, or are new
!     modules.  Others have relatively minor changes, such as cleaning
!     up a comment.
!     FILES:  COMPDL.CTL, DIL.RNH, DIL2VAX.CTL, DILBLD.10-MIC,
!     DILHST.BLI, DILINT.BLI, DILOLB.VAX-COM, DILV6.FOR, DILV7.FOR,
!     INTERFILS.CTL, MAKDIL.CTL, MASTER-DIL.CMD, POS20.BLI, POSGEN.BLI,
!     DLCM10.10-CTL, DLMK10.10-CTL
!  )%
! 
! Edit (%O'116', '9-Jul-84', 'Sandy Clemens')
!  %(  Fix DLMK10.10-CTL so that it is easy for Release Engineering
!      to use for a build in a single directory.  Change LIBARY to
!      CPYLIB in INTERFILS.CTL.  Remove references to DILV6.FOR in
!      INTERFILS.CTL and INTR10.10-CTL.
!  )%
!
! Edit (%O'133', '28-Sep-84', 'Sandy Clemens')
!  %( Update TOPS-10 build procedure to make the build easier for 
!     Release Engineering and customers.  Make the TOPS-10 and TOPS-20
!     build procedure skip creating the documents under tag RENG::
!     because .RNO files are not shipped to customers any more.
!     FILES: DLCM10.10-CTL, DLMK10.10-CTL, INTR10.10-CTL, COMPDL.CTL,
!     DILHST.BLI  )%
! 
! new_version (2, 1)
! 
! Edit (%O'141', '1-Jun-86', 'Sandy Clemens')
!   %( Add DIL sources to DL21: directory. )%
! **Edit**
!
! Files needed on connected directory:
! DIXGEN.REL	DIXSTR.REL	DIXFBN.REL	DIXFP.REL	DIXUTL.REL
! DIXGBL.REL	DIXDEB.REL	DIXHST.REL	DIXDN.REL	DIXPD.REL
! POS20.REL	POSGEN.REL	DILINT.REL	DILHST.REL
! TTT.REL	DAPPER.REL	DITHST.REL
!
! Files needed in connected sub-directory [,,DAP]:
! DAP1V1.REL
!
! Files needed in connected sub-directory [,,XPN]:
! XPN1V1.REL
!
! Files needed in connected sub-directory [,,EXT]:
! RMSERR.REL
!
! Files needed on SYS:
! MAKLIB.EXE	QUEUE.EXE
!
! Files produced in connected directory:
! DIL.REL	DIL1V2.REL
! DIX1V2.REL	DIT1V2.REL
! XPN1V1.REL	DAP1V1.REL
!

! [%O'116']
! For builds which are NOT release engineering or are NOT from a
! single directory:
MASTER::
!
! Make the DAP library
.DELETE DAP1V1.REL
.COPY DAP1V1.REL=DAP1V1.REL[,,DAP],RMSERR.REL[,,EXT]
!
! Copy the BLISSnet-10 library
.DELETE XPN1V1.REL
.COPY XPN1V1.REL=XPN1V1.REL[,,XPN]
!
.GOTO COMBIN
!
! For release engineering or any other build from a single directory
! containing everything using vanilla tools:
RENG::
!
! Make the DAP library
.COPY DAP1V1.REL=DAP1V1.REL,RMSERR.REL
!
! Don't need to copy the BLISSnet-10 library -- it has been built in
! this directory...
!
.GOTO COMBIN
!
! Now assemble the autopatch libraries.
COMBIN::
!
! Make DIL library (use autopatch names for the autopatch libraries)
.DELETE DIL1V2.REL
.copy DIL1V2.REL=POS20.REL, POSGEN.REL, DILINT.REL, DILHST.REL
!
! Make DIX Library (use autopatch names for the autopatch libraries)
.DELETE DIX1V2.REL
.copy DIX1V2.REL=DIXGEN.REL, DIXSTR.REL, DIXFBN.REL, DIXFP.REL, DIXDN.REL, DIXPD.REL, DIXUTL.REL, DIXGBL.REL, DIXDEB.REL, DIXHST.REL
!
! Make DIT library (use autopatch names for the autopatch libraries)
.DELETE DIT1V2.REL
.COPY DIT1V2.REL=TTT.REL,DAPPER.REL,DITHST.REL
!
! Now, put together the proper DIL.REL.  This code can and should be stolen
! into the autopatch patch-and-build procedure, since it builds from the
! libraries.
!
.DELETE DIL.REL
.r MAKLIB
*DIL.REL=DIL1V2.REL/EXTRACT:DILHST
*DIL.REL=DIL.REL,DIL1V2.REL/APPEND:(POSSTR,POSFB,POSFP,POSDN,POSPD,POSFXD,POSDXF,POSPXD,POSDXP,POSPXF,POSFXP,POSGEN)
*DIL.REL=DIL.REL,DIX1V2.REL/APPEND:(DIXGEN,DIXSTR,DIXFBN,DIXFP,DIXDN,DIXPD)
*DIL.REL=DIL.REL,DIT1V2.REL/APPEND
*DIL.REL=DIL.REL,DIL1V2.REL/APPEND:(DILINT,DILHST)
*DIL.REL=DIL.REL,DIX1V2.REL/APPEND:(DIXUTL,DIXGBL,DIXDEB,DIXHST)
*DIL.REL=DIL.REL,DAP1V1.REL/APPEND,XPN1V1.REL/APPEND
*DIL.REL=DIL.REL/INDEX
*/EXIT
!
! Record exactly what we produced
.DIRECTORY /checksum DIL.REL, DIL1V2.REL, DIX1V2.REL, DIT1V2.REL, XPN1V1.REL, DAP1V1.REL
!
! Done, and it worked, so modify next stream's dependency
DONDON::
.PATH /CLEAR
.QUEUE INP:INTR10= /MODIFY/DEPEND:-1
.GOTO ENDEND

%err::
.GOTO ERRRTN
%CERR::
.GOTO ERRTN
%terr::
ERRRTN::
! [%O'133'] Remove canceling of next job.
!
endend::
%fin::
.
