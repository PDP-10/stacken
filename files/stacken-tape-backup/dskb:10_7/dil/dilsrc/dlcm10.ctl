! Compile TOPS-10 form of DL1: library.
! The control file does a build from a single source directory using
! field-image tools.
!
! Facility: DIL
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'72', '23-Feb-83', 'David Dyer-Bennet')
! %(  Add TOPS-10 native build procedure.  Related to DIX edit 33.
!     DLCM10.10-CTL: New procedure to compile on tops-10
! )%
! Edit (%O'73', '10-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules.
! )%
! 
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
! Edit (%O'107', '23-May-84', 'Sandy Clemens')
!  %(  Move DIL.VAX-OPT from DL1A: to DL2:.  Fix DLCM10.10-CTL which
!      is missing a command to create the DIL.DOC file.
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
! POSGEN.BLI	DILHST.BLI	POS20.BLI	DILINT.BLI
! DIL.RND	DIL.RNH		DILBWR.RNO	DILDOC.INI
! DIXREQ.REQ	DIXLIB.L36	VERSION.L36	FIELDS.L36	DIXDEB.REQ
! STAR36.L36
!
! Files needed on SYS:
! BLISS.EXE     DSR.EXE      TOC.EXE	QUEUE.EXE
!
! Files produced on connected directory:
! POSGEN.REL	DILHST.REL	POS20.REL	DILINT.REL
! DIL.DOC	DIL.BWR		DIL.HLP
!
!
! [%O'133'] Move making DOC, HLP and BWR files to before tag RENG::.
! Make DOC, HLP, and BWR files (same as 20)
!  (wrong DSR in DEC:)
.R DSKA:DSR[1,4]
*dildoc.bod=DIL.RND/CONTENTS
*dil.bwr=DILBWR.RNO
*dil.hlp=DIL.RNH
*/EXIT
! (wrong TOC in DEC:)
.R DSKA:TOC[1,4]
*DIL
*
*
*
*
*
*
.R DSKA:DSR[1,4]
*dildoc.mem=DILDOC.INI
*/EXIT
.DELETE DIL.DOC
.COPY DIL.DOC=DILDOC.MEM,DILDOC.BOD
.DELETE DILDOC.MEM,DILDOC.BOD
!
! For release engineering or any other build from a single directory
! containing everything using vanilla tools.
RENG::

.ERROR ?
.R BLISS
*posgen,posgen=posgen
*dilhst,dilhst=dilhst
*pos20,pos20=pos20
*dilint,dilint=dilint
!
! [%O'133'] Move building DOC, HLP and BWR files to before tag RENG::.
!
DONOK::
.PATH /CLEAR
.QUEUE INP:DTCM10= /MODIFY /DEPEND:-1
.GOTO ENDEND
!
!
%ERR::
.GOTO ERRRTN
%CERR::
.GOTO ERRRTN
%TERR::
ERRRTN::
!
! [%O'133'] Remove canceling of next jobs.
!
ENDEND::
%FIN::
.
