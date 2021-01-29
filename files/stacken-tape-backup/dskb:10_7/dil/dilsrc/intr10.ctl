! Make COBOL-10/20 libraries of interface-support files for DIL
! This library will include the dil, dix elements.
!
! Facility: DIL
! 
! Edit History:
! 
! new_version (1, 0)
! 
! Edit (%O'72', '23-Feb-83', 'David Dyer-Bennet')
! %(  Add TOPS-10 native build procedure.  Related to DIX edit 33.
!     INTR10.10-CTL: New procedure for interfils on tops-10
! )%
! Edit (%O'73', '10-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules.
! )%
! new_version (2, 0)
! Edit (%O'105', '18-May-84', 'Sandy Clemens')
!  %(  Add the following files to the V2 area.  FILES:  DILDOC.INI,
!      DILBWR.RNO, DILC36.INT, INTR10.10-CTL, DILHST.BLI.
!  )%
! Edit (%O'115', '25-Jun-84', 'Sandy Clemens')
!  %(  Fix INTR10.10-CTL which is missing library element DIT in the
!      instructions to build DIL.LIB.
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
! **EDIT**
!
! Files needed on connected directory:
! DILC36.INT
! DIXC36.INT
! DITC36.INT
!
! Files needed on SYS:
! LIBARY.EXE
!
! Files produced on connected directory:
! DIL.LIB
!
BUILD::
!
.DELETE DIL.LIB
!
.R LIBARY
*DIL,DIL=
*INSERT DIL, DILC36.INT
*INSERT DIT, DITC36.INT
*INSERT DIX, DIXC36.INT
*END
.
!
! Record exactly what we've made
.DIRECTORY /checksum DIL.LIB,DILV7.FOR
!
DONDON::
.GOTO ENDEND
!
%ERR::
.GOTO ERRRTN
!
%TERR::
.GOTO ERRRTN
!
%CERR::
ERRRTN::
!
ENDEND::
%FIN::
.
