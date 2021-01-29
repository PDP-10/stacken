.R TECO
*EWCN2061.P11
*IOURNNM=61			;We are node# 61
*.MACRO NODE MNAME
*	MNAME	<TITAN>		;This is our node name
*.ENDM
*FT.D20=1			;We are a DN20 with a DTE20
*MSGMAX=596.
*NGHMAX=8.
*SCBMAX=32.
*DMCN=2.			;We have 2. DMC11's, one is usually broken
*DUPN=4.			;And 4. DUP11s that interrupt us to death
*FT.PFH=1			;Force preferred host logic
*FT.DDP=1			;Enable DDP service
*    DDPPFH=67			;Direct the DDPs to KL2476
*    DDPRNN=67			;And *ONLY* KL2476!
*DEBUG=-1			;Always so we can tell what happened
*FTECHO=1			;Want SINK/ECHO task devices
*    ECHON=2			;This should be enough of 'em
*FTDZ11=0			;Suppress DZ11 code
*12II
*.NLIST
EX
.R MACDLX
DN2061,DN2061.CRF/CRF=CN2061.P11,S,MACROS,DNCNFG,DNCOMM,DNNCL,DNDEV,DNDCMP,DNCDMC,DNDTE,DNCDUP,DNCTAB,DNLBLK,DNDBG,CHK11
.R DDT11
*DN2061.CRF/SYMBOL
.SSAVE DN2061
.DELETE DN2061.CRF,CN2061.P11

