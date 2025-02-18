.ASSIGN DEC SYS
.ASSIGN DEC REL
.ASSIGN DEC UNV
.ASSIGN DSK: MCB

.DELETE MDA*.REL,MDA*.LST
RSXLIB::
.R BLISS
*rsxlib=RSXLIB.R16/LIBRARY
MCBLIB::
.R BLISS
*mcblib=MCBLIB.R16/LIBRARY
CEXLIB::
.R BLISS
*cexlib=CEXLIB.R16/LIBRARY
MDACOM::
.R BLISS
*MDACOM=mdacom/LIBRARY
MDA::
.R BLISS
*MDA=mda/OPTLEVEL:3
MDASUB::
.R BLISS
*MDASUB=mdasub/OPTLEVEL:3
MDACLQ::
.R BLISS
*MDACLQ=mdaclq/NOLIST/OPTLEVEL:3
MDAHLP::
.R BLISS
*MDAHLP=mdahlp/NOLIST/OPTLEVEL:3
MDADMP::
.R BLISS
*MDADMP=mdadmp/NOLIST/OPTLEVEL:3
MDALST::
.R BLISS
*MDALST=mdalst/NOLIST/OPTLEVEL:3
MDAMEM::
.R BLISS
*MDAMEM=mdamem/NOLIST/OPTLEVEL:3
MDANLZ::
.R BLISS
*MDANLZ=mdanlz/NOLIST/OPTLEVEL:3
MDARSX::
.R BLISS
*MDARSX=mdarsx/NOLIST/OPTLEVEL:3
MDADCB::
.R BLISS
*MDADCB=mdadcb/NOLIST/OPTLEVEL:3
MDATCB::
.R BLISS
*MDATCB=mdatcb/NOLIST/OPTLEVEL:3
MDAHDR::
.R BLISS
*MDAHDR=mdahdr/NOLIST/OPTLEVEL:3
MDATAS::
.R BLISS
*MDATAS=mdatas/NOLIST/OPTLEVEL:3
MDAWND::
.R BLISS
*MDAWND=mdawnd/NOLIST/OPTLEVEL:3
MDAPKT::
.R BLISS
*MDAPKT=mdapkt/NOLIST/OPTLEVEL:3
MDAPAR::
.R BLISS
*MDAPAR=mdapar/NOLIST/OPTLEVEL:3
MDAPCB::
.R BLISS
*MDAPCB=mdapcb/NOLIST/OPTLEVEL:3
MDACEX::
.R BLISS
*MDACEX=mdacex/NOLIST/OPTLEVEL:3
MDABUF::
.R BLISS
*MDABUF=mdabuf/NOLIST/OPTLEVEL:3
MDAMSG::
.R BLISS
*MDAMSG=mdamsg/NOLIST/OPTLEVEL:3
MDANML::
.R BLISS
*MDANML=mdanml/NOLIST/OPTLEVEL:3
*



.DELETE C5TA.REL,CAT5.REL,CBTA.REL,CATB.REL,EDDAT.REL,EDTMG.REL,RQLCB.REL
.DELETE C5TA.LST,CAT5.LST,CBTA.LST,CATB.LST,EDDAT.LST,EDTMG.LST,RQLCB.LST
.R BLISS
*SYSLIB=C5TA,CAT5,CBTA,CATB,EDDAT,EDTMG,RQLCB/NOLIST/OPTLEVEL:3

.R MACRO
*MCBDA,MCBDA/C=MCBDA
*

.R BLISS
*MDASTB=MDASTB
*

.R LINK
MCBDA/SAVE=/LOCALS/SYMSEG:LOW/SEGMENT:LOW MCBDA,REL:OPRPAR,MDA,MDASUB,MDAHLP,MDADMP,MDASTB,MDALST,MDAMEM,MDANLZ,MDARSX,MDADCB,MDACLQ,MDATCB,MDAWND,MDAPKT,MDAHDR,MDATAS,MDAPAR,MDAPCB,MDACEX,MDABUF,MDAMSG,MDANML,SYSLIB/GO
