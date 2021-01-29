!++
!   MX10.CTL
!
!       This control file will build MX under TOPS-10.
!--
.GET SYS:BLISS
.VER
.set watch fil
.r BLISS
!
!Compile the libraries
!
*mxnlib=mxnlib/lib
*mxlib=mxlib/lib
*tbl=tbl/lib
!
!Compile the nml-maintained modules
!
*M10INT=M10INT
*mxnmem=mxnmem
*mxnpag=mxnpag
*mxnque=mxnque
*mxntbl=mxntbl
*mxntxt=mxntxt
!
!Compile the mx-maintained modules
!
*mxdata=mxdata
*mxhost=mxhost
*mxlcl=mxlcl
*mxqman=mxqman
*mxufil=mxufil
*tbl=tbl
*mxerr=mxerr
*mxdcnt=mxdcnt
*M10IPC=M10IPC
*mxnskd=mxnskd
*mxnnet=mxnnet
*/exit
.r MACRO
*cpyryt=cpyryt
*mxnt10=mxnt10
*nettab=nettab
*mxver=mxver
*smtlis=smtlis
*smtsen=smtsen
*lisvax=lisvax
*senvax=senvax
*mxut10=mxut10
*^z
!
!Make a combined rel file MX10.REL
!
APPEND::
.COPY MX10.REL=CPYRYT.REL,M10INT.REL,M10IPC.REL,mxnmem.REL,mxnpag.REL,mxnque.REL,mxnskd.REL,mxnt10.REL,mxntbl.REL,mxntxt.REL,mxnnet.REL,mxdata.REL,mxhost.REL,mxlcl.REL,mxqman.REL,mxufil.REL,mxerr.REL,mxdcnt.REL,tbl.REL,nettab.REL,mxver.REL,smtlis.REL,smtsen.REL,lisvax.REL,senvax.REL,mxut10.REL
!
!Link all modules
!
.r LINK
*/symseg:high
*MX10
*/search rel:b361lb
*/save MX
*/go
*^Z
.set wat no file
