! Submit the jobs to compile and build DIL on TOPS-10.  This control
! file is for Release Engineering and customers ONLY.

! Facility: DIL
! 
! new_version (2, 0)
!
! Edit (%O133, 28-Sep-84, Sandy Clemens)
!  %( Update TOPS-10 build procedure to make the build easier for 
!     Release Engineering and customers.  Make the TOPS-10 and TOPS-20
!     build procedure skip creating the documents under tag RENG::
!     because .RNO files are not shipped to customers any more.
!     FILES: DLCM10.10-CTL, DLMK10.10-CTL, INTR10.10-CTL, COMPDL.CTL,
!     DILHST.BLI  )%
! 
! new_version (2, 1)
! 
! Edit (%O141, 1-Jun-86, Sandy Clemens)
!   %( Add DIL sources to DL21: directory. )%
! 
! **Edit **

.SUBMIT EXT1A/TIME/RESTART:YES/TAG:RENG
.SUBMIT XPN1A/DEPEND:1/TIME/RESTART:YES/TAG:RENG
.SUBMIT DAP1A/DEPEND:1/TIME/RESTART:YES/TAG:RENG
.SUBMIT DXCM10/DEPEND:1/TIME/RESTART:YES
.SUBMIT DLCM10/DEPEND:1/TIME/RESTART:YES/TAG:RENG
.SUBMIT DTCM10/DEPEND:1/TIME/RESTART:YES
.SUBMIT DLMK10/DEPEND:1/TIME/RESTART:YES/TAG:RENG
.SUBMIT INTR10/DEPEND:1/TIME/RESTART:YES

! End of DIL.CTL
