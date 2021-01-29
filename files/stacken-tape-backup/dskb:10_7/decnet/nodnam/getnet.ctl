;This is a skeleton control file to move a new NODNAM.INI to a -10
;from a VAX.  This control file should be run under [1,2], and resubmits
;itself.
;
;To use, get NETALL started on the VAX system.
;Then, replace each of the following placeholders as indicated below.
;	<VAX>		The node name of the LEVEL II VAX router
;	<DISK$VAX>	The disk name where NODNAM.INI is put by NETALL
;	<VAX$USER>	The VAX user name where NODNAM.INI is put by NETALL
;	<LOCAL-AREA>	The area number of the -10 node
;
;Finally, submit GETNET for the first time.  It should resubmit itself
;each week.
;
;Batch job to retrieve NODNAM.INI file from <VAX> on a regular basis.
;Uses NFT to get the job done; if NFT transfer fails, it will requeue and
;try in one-half hour.
;
;After getting the file, it runs NODNAM.  It then submits itself for the
;following week and logs out.
;
.ERROR ?
.R NFT
*COPY =<VAX>::<DISK$VAX>:[<VAX$USER>]NODNAM.INI
.IF(ERROR).GOTO REDO
.COPY INI:=FFA:NODNAM.INI
.PROT INI:NODNAM.INI<155>
.R NODNAM
*<LOCAL-AREA>
!Submit for next week...
.SUBMIT GETNET/OUT:NOLOG/BATL:SUPER/UNI:NO/ACCOUNT:""/AFTER:FRI:12:00:00/REST:YES
!Kill file on <VAX> so that it is fresh next time around...
!Don't if multiple systems are updated from one VAX
!.R NFT
!*DELETE <VAX>::<DISK$VAX>:[<VAX$USER>]NODNAM.INI;*
!.IF(ERROR) 		!So what? probably protected too high...
.K/F
REDO::
.SUBMIT GETNET/OUT:NOLOG/BATL:SUPER/UNI:NO/ACCOUNT:""/AFTER:+0:30:00/REST:YES
.K/F
