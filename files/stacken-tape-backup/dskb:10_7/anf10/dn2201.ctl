.R TECO
*EWCN2201.P11
*IOURNNM=01
*.MACRO NODE MNAME
*	MNAME	<TINY>
*.ENDM
*MSGMAX=596.
*NGHMAX=8.
*SCBMAX=32.
*FT.D22=1
*FT.CTY=1
*DUPN=2
*DMCN=1
*CTYRNN=0
*CTYPFH=76
*DEBUG=-1
*FT.PAT=200
*FTROLL=17777
*FTWDDL=1
*FTECHO=1
*ECHON=2
*FTDZ11=0			;SUPPRESS DZ11 SERVICE
*12II
*.NLIST
EX
.R MACDLX
*DN2201,DN2201.CRF/CRF=CN2201,S,MACROS,DNCNFG,DNCOMM,DNNCL,DNDCP4,DNDCMP,DNCDMC,DNCDUP,DNDEV,DNTTY,DNCTAB,DNMOP,DNDBG,DNLBLK,CHK11
.R DDT11
*DN2201.CRF/SYMBOL
.SSAVE DN2201
.DELETE DN2201.CRF,CN2201.P11
