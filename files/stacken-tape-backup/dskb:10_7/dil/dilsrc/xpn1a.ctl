! This CTL file builds the library and relocatable object files which
! make up the Transportable BLISS Interface to DECNET-10.
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
!	BLI:UUOSYM.L36		Monitor definitions (must be V7.02 or later)
!	UNV:UUOSYM.UNV		 ditto
!
! Source files needed:
!	BLISSN.REQ		Source for Blissnet library
!	BLSNDE.REQ		Source for Blissnet structure library
!	BLSN10.R36		Internal definitions for Blissnet-10
!	XPNCLO.B36		Close a network link
!	XPNDIS.B36		Disconnect a logical link
!	CPYRIT.MAC		Copyright notice
!	XPNERR.B36		Return error message for a given error code
!	XPNEVE.B36		Return event information for logical links
!	XPNFAI.B36		Default fialure routine for Blissnet-10
!	XPNGET.B36		Get data from a DECnet link
!	XPNPUT.B36		Put data to a network link
!	XPNUTL.B36		Utility routines for Blissnet-10
!	XPNPSI.MAC		Interface to software interrupt system
!	XPNOPN.B36		Open a network link
!	XPNPMR.B36		Do poor man's routing
!
! Output files produced:
!	BLISSN.L36		Transportable macro and field definitions
!				also Defines $XPN_DESCRIPTOR, a temporary hack
!				which can disappear when XPORT string
!				descriptors get a CHARACTER_SIZE option.
!	XPNCLO.REL		Close a network link
!	XPNDIS.REL		Disconnect a logical link
!	XPNERR.REL		Return error message for a given error code
!	XPNEVE.REL		Return event information for logical links
!	XPNFAI.REL		Default failure rotuine for Blissnet-10
!	XPNGET.REL		Get data from a DECnet link
!	XPNOPN.REL		Open a network link
!	XPNPUT.REL		Put data to a network link
!	XPNUTL.REL		Utility routines for Blissnet-10
!	XPNPMR.REL		Do poor man's routing
!	CPYRIT.REL		Copyright notice
!	XPNPSI.REL		Interface to software interrupt system
!	BLSN10.L36		TOPS-10-specific macros and fields
!	XPN1V1.REL		Blissnet .REL library.
!
! Edit History:
!
! Facility Blissnet
!
! new_version (1, 0)
!
! Edit (%O'2', '12-Apr-84', 'Sandy Clemens')
!  %( Add the TOPS-10 BLISSnet sources for DIL V2.  )%
!
! Edit (%O'5', '28-Sep-84', 'Sandy Clemens')
!  %( Update XPN1A-CTL to make the build easier for Release Engineering
!     and customers.  FILES:  XPN1A.10-CTL and XPNHST.BLI  )%
! **EDIT**
WORK::
.PATH LIB:/SEARCH=[,,EXT]
.GOTO COMBIN

MASTER::
.PATH LIB:/SEARCH=[,,EXT]
.GOTO COMBIN

RENG::
.GOTO COMBIN

! Now build Blissnet.
COMBIN::
! Show logical names actually chosen.
.PATH/LIST:ALL
@NOERROR
! Do Bliss compilations
.R BLISS
*blissn,blissn=blissn,blsnde/library/TOPS10/KL
*blsn10,blsn10=blsn10/library/TOPS10/KL
*xpnclo,xpnclo=xpnclo/OPTLEVEL:3/TOPS10/KL
*xpndis,xpndis=xpndis/OPTLEVEL:3/TOPS10/KL
*xpnerr,xpnerr=xpnerr/OPTLEVEL:3/TOPS10/KL
*xpneve,xpneve=xpneve/OPTLEVEL:3/TOPS10/KL
*xpnfai,xpnfai=xpnfai/OPTLEVEL:3/TOPS10/KL
*xpnget,xpnget=xpnget/OPTLEVEL:3/TOPS10/KL
*xpnopn,xpnopn=xpnopn/OPTLEVEL:3/TOPS10/KL
*xpnput,xpnput=xpnput/OPTLEVEL:3/TOPS10/KL
*xpnutl,xpnutl=xpnutl/OPTLEVEL:3/TOPS10/KL
*xpnpmr,xpnpmr=xpnpmr/OPTLEVEL:3/TOPS10/KL
! Do Macro compilations
.R MACRO
*CPYRIT,=CPYRIT
*XPNPSI,=XPNPSI
APPEND::
! Record checksums of REL files
.DIRECTORY/CHECK BLISSN.L36,BLSN10.L36,XPNCLO.REL,XPNDIS.REL,XPNERR.REL
.DIRECTORY/CHECK XPNEVE.REL,XPNFAI.REL,XPNGET.REL,XPNOPN.REL,XPNPUT.REL
.DIRECTORY/CHECK XPNUTL.REL,XPNPMR.REL,CPYRIT.REL,XPNPSI.REL
! Delete old library
.DELETE XPN1V1.REL
! Construct new library
.COPY XPN1V1.REL=CPYRIT.REL,XPNOPN.REL,XPNPMR.REL,XPNCLO.REL,XPNDIS.REL,XPNERR.REL,XPNEVE.REL,XPNFAI.REL,XPNGET.REL,XPNPUT.REL,XPNUTL.REL,XPNPSI.REL
! Record exactly what was produced
.DIRECTORY/CHECK XPN1V1.REL
! [%O'5'] Modify next job.
.QUEUE INP:DAP1A= /MODIFY /DEPEND:-1
.GOTO ENDEND
%ERR::
ENDEND::
%FIN::
