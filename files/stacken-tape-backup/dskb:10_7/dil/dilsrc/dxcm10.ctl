! Compile TOPS-10 form of DIX library on a TOPS-10 system.
!
! This control file does a build from the connected directory
! only, using DEC: for SYS:.
!
! Facility: DIX
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'33', '23-Feb-83', 'David Dyer-Bennet')
! %(  Related to dil edit 72
!     DXCM10.10-CTL: New procedure to compile on tops-10
! )%
!
! Edit (%O'34', '10-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules. )%
! 
! new_version (2, 0)
! 
! Edit (%O'36', '11-Apr-84', 'Sandy Clemens')
! %(  Put all Version 2 DIX development files under edit control.
!     Some of the files listed below have major code edits, or are
!     new modules.  Others have relatively minor changes, such as
!     cleaning up a comment.
!     FILES: COMDIX.VAX-COM, COMPDX.CTL, DIXCST.BLI, DIXDEB.BLI,
!     DIXDN.BLI (NEW), DIXFBN.BLI, DIXFP.BLI, DIXGBL.BLI, DIXGEN.BLI,
!     DIXHST.BLI, DIXINT.PR1, DIXINT.PR2, DIXLIB.BLI, DIXPD.BLI (NEW),
!     DIXREQ.REQ, DIXSTR.BLI, DIXUTL.BLI, DXCM10.10-CTL, MAKDIXMSG.BLI,
!     STAR36.BLI, VERSION.REQ.
!  )%
! 
! Edit (%O'37', '12-Apr-84', 'Sandy Clemens')
! %(  Add correct version of DXCM10.10-CTL to development library.  Also,
!     fix edit 36 which listed 1983 instead of 1984, in DIXHST.BLI.
!     Files:  DXCM10.10-CTL, DIXHST.BLI.
! )%
!
! Edit (%O'47', '28-Sep-84', 'Sandy Clemens')
!  %( Update DXCM10.10-CTL to make the build easier for Release
!     Engineering and customers.  FILES: DXCM10.10-CTL, DIXHST.BLI )%
!
! new_version (2, 1)
!
! Edit (%O'53', '3-Jul-86', 'Sandy Clemens')
!   %( Add remaining sources to V2.1 area.  Update copyright notices. )%
!
! **Edit**
!
! Source files needed on connected directory:
! DIXDEB.REQ	DIXREQ.REQ
! FIELDS.BLI	STAR36.BLI	VERSIO.REQ	DIXLIB.BLI
! DIXHST.BLI	DIXUTL.BLI	DIXGEN.BLI	DIXCST.BLI
! DIXSTR.BLI	DIXFBN.BLI	DIXFP.BLI	DIXDEB.BLI
! DIXGBL.BLI	INTERF.BLI	DIXDN.BLI	DIXPD.BLI
!
! Files needed on DEC:
! BLISS.EXE	LINK.EXE
!
! Files produced on connected directory:
! FIELDS.L36	STAR36.L36	VERSIO.L36	DIXLIB.L36	DIXHST.REL
! DIXUTL.REL	DIXGEN.REL	DIXCST.L36	DIXSTR.REL	DIXFBN.REL
! DIXFP.REL	DIXDEB.REL	DIXGBL.REL	INTERF.REL	INTERF.EXE
! DIXV6.FOR	DIXV7.FOR	DIXC36.INT	DIXDN.REL	DIXPD.REL
!
! For release engineering or any other build from a single directory
! containing everything using vanilla tools.
!
.ERROR ?
.R BLISS
*FIELDS,FIELDS=FIELDS/LIB                    ! LIB files are system-independent.
*STAR36,STAR36=STAR36/LIB                    ! Compile them here to make this
*VERSIO,VERSIO=VERSIO/LIB                    ! independent of 20 builD.
!
! The library file must be compiled before any of the other modules
! are compiled, since they call it.
*dixlib,dixlib=dixlib/lib
!
*DIXHST,DIXHST=DIXHST
*DIXUTL,DIXUTL=DIXUTL
*DIXGEN,DIXGEN=DIXGEN
!
! The character set tables must be compiled before compiling the
! string conversion module.
*dixcst,dixcst=dixcst/lib
*dixstr,dixstr=dixstr
!
*dixfbn,dixfbn=dixfbn
*dixfp,dixfp=dixfp
*dixdn,dixdn=dixdn
*dixpd,dixpd=dixpd
!
*DIXDEB,DIXDEB=DIXDEB
*DIXGBL,DIXGBL=DIXGBL
!
! Produce interface support elements -- also for independence from T20
*INTERF,INTERF=INTERF
*/EXIT
!
! Link the INTERFILS program
LNKINT::
!
.R LINK
*TTY:/LOG/LOGLEVEL:0
*INTERF/MAP/CONTENTS:ALL
*INTERF
! Need DIXDEB because DIXREQ.REQ (used in INTERFILS) defines debugging routines
! as external.  Need DIXUTL because DIXDEB uses ARGADR.  None of this is ever
! referenced, so I could kludge by using /DEFINE, or simply ignore the errors,
! but this way is slightly more robust since a change in INTERFILS that causes
! debugging stuff to actually be referenced will work now.
! All of the above need DIXHST.
*DIXDEB,DIXUTL,DIXHST
! INTERFILS uses XPORT string handling and IO.
*BLI:XPORT/SEARCH
! Force loading of $OTSCH from B362LB to resolve SS$UNW (never referenced)
*/require:unwnd.
*/GO
!
.SAVE INTERF
.START
!
! Record exactly what we produced
.DIRECTORY /CHECKSUM DIXV6.FOR, DIXV7.FOR, DIXC36.INT
!
DONOK::
.PATH /CLEAR
.QUEUE INP:DLCM10= /MODIFY /DEPEND:-1
.GOTO ENDEND
!
!
%ERR::
.GOTO ERRRTN
%CERR::
.GOTO ERRRTN
%TERR::
ERRRTN::
! [%O'47'] Remove canceling of next jobs.
!
ENDEND::
%FIN::
.
