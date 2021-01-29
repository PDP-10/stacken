.R TECO
*EWCN2060.P11
*IOURNNM=60			;We are node # 60
*.MACRO NODE MNAME
*	MNAME	<EUROPA>	;This is our node name
*.ENDM
*FT.D20=1			;We are a DN20 with a DTE20
*MSGMAX=596.
*NGHMAX=8.
*SCBMAX=32.
*DMCN=0.			;We have 4. DMC11's, (one is a DMR)
*;   	DMCIBF=3		;Short of buffer space with 4 DMCs
*;	DMCOBF=3		;Short of buffer space with 4 DMCs
*DUPN=2.			;And 4. DUP11s that interrupt us to death
*DEBUG=-1			;Always so we can tell what happened
*FTECHO=1			;Usefull debugging device
*    ECHON=2			;Two of the little beasties
*FTDZ11=0			;Suppress DZ11 code
*12II
*.NLIST
EX
.R MACDLX
DN2060,DN2060.CRF/CRF=CN2060.P11,S,MACROS,DNCNFG,DNCOMM,DNNCL,DNDCMP,DNDEV,DNCDMC,DNDTE,DNCDUP,DNCTAB,DNLBLK,DNDBG,CHK11
.R DDT11
*DN2060.CRF/SYMBOL
.SSAVE DN2060
.DELETE DN2060.CRF,CN2060.P11
