	IMPLICIT INTEGER (A-Z)
	PARAMETER TOPCPU=4
	DIMENSION UPTIME(TOPCPU),IDLTIM(TOPCPU)
	DIMENSION DOORBL(TOPCPU),OVRHED(TOPCPU),L1(2)
	DIMENSION UUOS(TOPCPU),CTXS(TOPCPU),SAWIT(TOPCPU)
	DIMENSION SWEEPS(TOPCPU),CSHLST(TOPCPU),LSTTIM(TOPCPU)
	DOUBLE PRECISION DUMMY
	REAL F1
	COMMON /DPY/SCREEN(16),GRFSUP,CPUOFS,ARROW,TRKING,SAVED(1000)
	DATA WAIT/5/
	CALL ERRSET(0)
	TTTYPE = DPYINI(7,'VT52 ')
	CPUOFS=48
	ARROW=39
	IF (TTTYPE .NE. 'VT52 '.AND.TTTYPE .NE. 'VT61 ') GOTO 8001
	CPUOFS=116
	ARROW=107
	CALL ENGRAP
8001	CALL NECHO
	CALL PGRAPH
	CALL DPYZAP
	ENCODE(80,200,SCREEN(1))
200	FORMAT('        UPTIME    IDLE   CACHE   OVER',
	1  ' UUOS DBLS CTXS CSWP PAGS FRECOR')
	CALL DPYRSC(SCREEN,1,1,80,1)
	ENCODE(80,201,SCREEN(1))
201	FORMAT(26X,'HIT    HEAD  SEC  SEC  SEC  SEC  SEC   USED')
	CALL DPYRSC(SCREEN,1,2,80,2)
	DO 202 I=1,TOPCPU
	CALL MTRINI(I-1)
	SAWIT(I)=-1
202	UPTIME(I)=0
	SWPBLK=0
	INDEX=0
	TRKING=0


1	CALL NEWPNT
	SWPTHS=0
	DO 100 I=1,100
	CALL SWPDAT(INDEX,DUMMY,DUMMY,I1,I2,DUMMY,DUMMY)
	IF (INDEX.EQ.0) GOTO 101
	SWPTHS=SWPTHS+I1+I2
100	CONTINUE
101	LINE=4
	CALL FREUSD(PERUSD)
	DO 10 I=1,TOPCPU
	FLAG=CPUDAT(I-1,UP,LOST,NUL,OHT,DBLS,UUO,
	1 CTX,SWEEP,CSHHIT,CLT)
	IF(FLAG.NE.0) GOTO 11
	IF(GRFSUP.NE.0.AND.
	1  (LINE.GT.9.OR.(UP-UPTIME(I).EQ.0.AND.SAWIT(I).EQ.0))) FLAG=-1
	SAWIT(I)=0
	IDLE=NUL-LOST
	LOST=LOST-CLT
	CSHHIT=100000-CSHHIT
	IF(FLAG.EQ.0)
	1   CALL DOOUT(I-1,LINE,UP,IDLE,CSHHIT,DBLS,OHT,UUO,CTX,SWEEP)
	IF(UPTIME(I).EQ.0) GOTO 12
	UPTIME(I)=UP-UPTIME(I)
	IF(UPTIME(I).EQ.0) GOTO 12
	SAWIT(I)=-1
	IDLTIM(I)=IDLE-IDLTIM(I)
	IF(IDLTIM(I).LT.0)IDLTIM(I)=0
	DOORBL(I)=DBLS-DOORBL(I)
	CSHLST(I)=CLT-CSHLST(I)
	LSTTIM(I)=LOST-LSTTIM(I)
	OVRHED(I)=OHT-OVRHED(I)
	UUOS(I)=UUO-UUOS(I)
	CTXS(I)=CTX-CTXS(I)
	SWEEPS(I)=SWEEP-SWEEPS(I)
	CALL COLECT(0,I-1,(UPTIME(I)/60))
	CALL COLECT(1,I-1,UUOS(I)/(UPTIME(I)/60))
	CALL COLECT(2,I-1,(OVRHED(I)*100)/UPTIME(I))
	CALL COLECT(3,I-1,CTXS(I)/(UPTIME(I)/60))
	CALL COLECT(4,I-1,CSHHIT/1000)
	CALL COLECT(5,I-1,(IDLTIM(I)*100)/UPTIME(I))
	CALL COLECT(7,I-1,SWEEPS(I)/(UPTIME(I)/60))
	CALL COLECT(9,I-1,DOORBL(I)/(UPTIME(I)/60))
	CALL COLECT(10,I-1,(CSHLST(I)*100)/UPTIME(I))
	CALL COLECT(11,I-1,(LSTTIM(I)*100)/UPTIME(I))
12	IF(FLAG.NE.0) GOTO 13
	CALL DOOUT(-1,LINE+1,UPTIME(I),IDLTIM(I),CSHHIT,
	1  DOORBL(I),OVRHED(I),UUOS(I),CTXS(I),SWEEPS(I))
	IF(I.NE.1) GOTO 14
	F1=PERUSD/100.
	ENCODE(10,103,L1) F1
103	FORMAT(F5.2,'%')
	CALL DPYRSC(L1,64,LINE,69,LINE)
	I1=F1
	IF (UPTIME(1).NE.0) CALL COLECT(8,0,I1)
	I1=SWPTHS/(UP/15)
	ENCODE(10,102,L1) I1
102	FORMAT(I5)
	SWPBLK=SWPTHS-SWPBLK
	IF(UPTIME(1).EQ.0) GOTO 15
	I1=SWPBLK/(UPTIME(1)/15)
	ENCODE(5,102,L1(2)) I1
	CALL COLECT(6,0,I1)
15	SWPBLK=SWPTHS
	CALL DPYRSC(L1,58,LINE,62,LINE+1)
14	LINE=LINE+3
13	UPTIME(I)=UP
	IDLTIM(I)=IDLE
	DOORBL(I)=DBLS
	CSHLST(I)=CLT
	LSTTIM(I)=LOST
	OVRHED(I)=OHT
	UUOS(I)=UUO
	CTXS(I)=CTX
	SWEEPS(I)=SWEEP
10	CONTINUE


11	CALL GRFOUT
1100	CHAR=CHAR1(0)
	IF(CHAR.EQ.0) GOTO 1101
	IF(CHAR.EQ.'R') CALL DPYREF
	IF(CHAR.EQ.'W') CALL SAVEIT
	IF(CHAR.EQ.'T') CALL TRACK
	IF(WAIT.GT.1 .AND. CHAR.EQ.'F') WAIT=WAIT-1
	IF(WAIT.LT.60 .AND. CHAR.EQ.'S') WAIT=WAIT+1
	IF(CHAR.NE.'+') GOTO 1102
	CALL ADGRAP
	GOTO 11
1102	IF(CHAR.NE.'-') GOTO 1103
	CALL RMGRAP
	GOTO 11
1103	IF(CHAR.NE.'H') GOTO 1104
	CALL DPYSAV(SAVED)
	CALL DPYROL(3)
	CALL CPUHLP
	CALL DPYWAT(10)
	CALL DPYCLR
	CALL DPYRST(SAVED)
1104	IF(CHAR.NE.'E' .AND. CHAR.NE."151004020100) GOTO 1105
	CALL DPYROL(1)
	CALL ECHO
1105	GOTO 1100
1101	CALL DPYCRM(-1,1,1)
	CALL DPYWAT(WAIT)
	GOTO 1
	END
	SUBROUTINE DOOUT
	1   (ICPU,LINE,IUP,IDLE,ICSH,IDBLS,IOVH,IUUO,ICTX,ISWP)
	DIMENSION ITIM(5)
	COMMON /DPY/SCREEN(16),GRFSUP,CPUOFS,ARROW,TRKING,SAVED(400)
	ITIM(1)=IUP/(3600*60)
	ITIM(3)=(IUP-(ITIM(1)*3600*60))/(60*60)
	ITIM(5)=(IUP-(ITIM(1)*3600*60)-(ITIM(3)*60*60))/60
	ITIM(2)=ITIM(3)/10
	ITIM(4)=ITIM(5)/10
	ITIM(3)=ITIM(3)-(ITIM(2)*10)
	ITIM(5)=ITIM(5)-(ITIM(4)*10)
	IF(IUP.LT.60) GOTO 600
	F1=(IDLE*100.0)/IUP
	F4=(IOVH*100.0)/IUP
	I5=IUUO/(IUP/60)
	I6=ICTX/(IUP/60)
	I7=ISWP/(IUP/60)
	I8=IDBLS/(IUP/60)
	IF(ICPU.LT.0) GOTO 500
	ENCODE(80,100,SCREEN(1))ICPU,ITIM,F1,F4,I5,I8,I6,I7
100	FORMAT(' CPU',I1,I4,':',2I1,':',2I1,
	1  F6.1,'%',8X,F6.1,'%',4I5)
	GOTO 501
500	F2=ICSH/1000.0
	ENCODE(80,101,SCREEN(1))ITIM,F1,F2,F4,I5,I8,I6,I7
101	FORMAT(I9,':',2I1,':',2I1,F6.1,'%',F7.2,
	1  '%',F6.1,'%',4I5)
501	CALL DPYRSC(SCREEN,1,LINE,57,LINE)
	RETURN
600	IF(ICPU.LT.0) GOTO 601
	ENCODE(80,102,SCREEN(1))ICPU,ITIM
102	FORMAT(' CPU',I1,I4,':',2I1,':',2I1)
	GOTO 501
601	ENCODE(80,103,SCREEN(1))ITIM
103	FORMAT(I9,':',2I1,':',2I1)
	GOTO 501
	END
	SUBROUTINE SAVEIT
	IMPLICIT INTEGER (A-Z)
	DOUBLE PRECISION FILENA
	COMMON /DPY/SCREEN(16),GRFSUP,CPUOFS,ARROW,TRKING,SAVED(400)
	DATA FILNUM/1/
	CALL DPYSAV(SAVED)
	ENCODE(10,201,FILENA)FILNUM
201	FORMAT('SCREEN.',O3)
	OPEN(UNIT=20,DEVICE='DSK',
	1  ACCESS='SEQOUT',MODE='ASCII',FILE=FILENA)
	DO 20 I=1,400,16
	WRITE(20,200)(SAVED(J),J=I,I+15)
200	FORMAT(16A5)
20	CONTINUE
	CLOSE(UNIT=20)
	FILNUM=FILNUM+1
	RETURN
	END
	SUBROUTINE COLECT(GN,CPUN,ITEM)
	IMPLICIT INTEGER (A-Z)
	PARAMETER NUMGRA=11
	DOUBLE PRECISION TRKLIT
	DIMENSION CPUSIG(6),CPUCOL(6)
	DIMENSION GRPHS(8,16,NUMGRA),SIGNAL(NUMGRA),BOTTOM(NUMGRA)
	DIMENSION SCALE(NUMGRA),TAKEN(NUMGRA)
	COMMON /DPY/SCREEN(16),GRFSUP,CPUOFS,ARROW,TRKING,SAVED(400)
	DATA TRKLIT/'*TRACKING*'/
	DATA UPLIT/'UP'/
	DATA CPUSIG/'0','1','2','3','4','5'/
	DATA CPUCOL/-1,-1,-1,-1,-1,-1/
	DATA SIGNAL/'U','O','C','H','I','S','J','F','D','Z','L'/
	DATA SCALE/25,4,10,3,8,15,15,8,15,2,2/
	DATA TAKEN/0,1,0,0,-1,0,0,0,0,0,0/
	DATA BOTTOM/0,0,0,60,0,0,0,0,0,0,0/

	IF(TRKING.EQ.0) GOTO 4000
	IF(GN.EQ.0) WRITE(21,8999)UPLIT,CPUN,ITEM
	IF(GN.NE.0) WRITE(21,8999)SIGNAL(GN),CPUN,ITEM
8999	FORMAT(A2,I1,I7)
4000	IF(GN.EQ.0 .OR. CPUCOL(CPUN+1).EQ.0) RETURN
	ITEMP=15-(ITEM-BOTTOM(GN)+(SCALE(GN)/2))/SCALE(GN)
	IF (ITEMP.LT.2) ITEMP=2
	IF (ITEMP.GT.15) ITEMP=15
	CALL PUTC(CPUOFS+CPUN,CURPNT,ITEMP,GRPHS(1,1,GN),40)
	RETURN


	ENTRY PGRAPH

	CURPNT=5
	CLRPNT=CURPNT+3
	GRFSUP=0
	DO 5001 II=1,NUMGRA
	IF(TAKEN(II).NE.0) GRFSUP=GRFSUP+1
	DO 5000 I=2,15
	N=((15-I)*SCALE(II))+BOTTOM(II)
	GOTO (100,200,100,200,200,100,100,200,100,200,200),II
100	ENCODE(40,9999,GRPHS(1,I,II))N
9999	FORMAT(I3)
	GOTO 5000
200	ENCODE(40,9998,GRPHS(1,I,II))N
9998	FORMAT(I2,'%')
5000	CONTINUE
	GOTO (101,201,301,401,501,601,701,801,901,1001,1101),II
101	ENCODE(40,9997,GRPHS(1,16,1))
9997	FORMAT(14X,'UUOS/SECOND')
	GOTO 5001
201	ENCODE(40,9996,GRPHS(1,16,2))
9996	FORMAT(16X,'OVERHEAD')
	GOTO 5001
301	ENCODE(40,9995,GRPHS(1,16,3))
9995	FORMAT(8X,'CONTEXT SWITCHES/SECOND')
	GOTO 5001
401	ENCODE(40,9994,GRPHS(1,16,4))
9994	FORMAT(12X,'CACHE HIT RATIO')
	GOTO 5001
501	ENCODE(40,9993,GRPHS(1,16,5))
9993	FORMAT(16X,'IDLE TIME')
	GOTO 5001
601	ENCODE(40,9992,GRPHS(1,16,6))
9992	FORMAT(9X,'SWAPPING PAGES/SECOND')
	GOTO 5001
701	ENCODE(40,9991,GRPHS(1,16,7))
9991	FORMAT(10X,'CACHE SWEEPS/SECOND')
	GOTO 5001
801	ENCODE(40,9990,GRPHS(1,16,8))
9990	FORMAT(9X,'MONITOR FREE CORE USED')
	GOTO 5001
901	ENCODE(40,9989,GRPHS(1,16,9))
9989	FORMAT(9X,'DOOR BELL RINGS/SECOND')
	GOTO 5001
1001	ENCODE(40,9988,GRPHS(1,16,10))
9988	FORMAT(12X,'CACHE LOST TIME')
	GOTO 5001
1101	ENCODE(40,9987,GRPHS(1,16,11))
9987	FORMAT(13X,'SWAP LOST TIME')
5001	CONTINUE
	RETURN


	ENTRY NEWPNT

	OLDPNT=CURPNT
	CURPNT=CURPNT+1
	IF(CURPNT.GT.38) CURPNT=6
	CLRPNT=CLRPNT+1
	IF(CLRPNT.GT.38) CLRPNT=6
	DO 5002 II=1,NUMGRA
	CALL PUTC(0,OLDPNT,1,GRPHS(1,1,II),40)
	CALL PUTC(ARROW,CURPNT,1,GRPHS(1,1,II),40)
	DO 5002 I=2,15
	III=I
5002	CALL PUTC(0,CLRPNT,III,GRPHS(1,1,II),40)
	RETURN


	ENTRY GRFOUT

	LEFT=0
	RIGHT=0
	DO 5003 II=1,NUMGRA
	IF (TAKEN(II)) 5004,5003,5005
5004	IF(RIGHT.NE.0) GOTO 5003
	RIGHT=1
	CALL DPYRSC(GRPHS(1,1,II),41,9,80,24)
	GOTO 5003
5005	IF(LEFT.NE.0) GOTO 5003
	LEFT=1
	CALL DPYRSC(GRPHS(1,1,II),1,9,40,24)
5003	CONTINUE
	RETURN


	ENTRY RMGRAP

	CHAR=CHAR2(ITEMP)
	DO 5006 II=1,NUMGRA
	IF(CHAR.NE.SIGNAL(II)) GOTO 5006
	IF(TAKEN(II).EQ.0) RETURN
	IF (TAKEN(II).LT.0) CALL DPYCSC(41,9,80,24)
	IF (TAKEN(II).GT.0) CALL DPYCSC(1,9,40,24)
	GRFSUP=GRFSUP-1
	TAKEN(II)=0
	RETURN
5006	CONTINUE
	DO 5021 II=1,6
	IF (CHAR.NE.CPUSIG(II)) GOTO 5021
	CPUCOL(II)=0
	RETURN
5021	CONTINUE
	RETURN


	ENTRY ADGRAP

	CHAR=CHAR2(ITEMP)
	LEFT=0
	RIGHT=0
	I=0
	DO 5009 II=1,NUMGRA
	IF(TAKEN(II)) 5010,5011,5012
5010	RIGHT=1
	GOTO 5011
5012	LEFT=1
5011	IF(CHAR.EQ.SIGNAL(II)) I=II
5009	CONTINUE
	IF(I.EQ.0) GOTO 5022
	IF(TAKEN(I).NE.0) RETURN
	IF(LEFT.NE.0) GOTO 5013
	TAKEN(I)=1
	GOTO 5014
5013	IF(RIGHT.EQ.0) TAKEN(I)=-1
5014	IF(TAKEN(I).NE.0) GRFSUP=GRFSUP+1
	IF (GRFSUP.EQ.1) CALL DPYCSC(41,9,80,24)
	RETURN
5022	DO 5023 II=1,6
	IF (CHAR.NE.CPUSIG(II)) GOTO 5023
	CPUCOL(II)=-1
	RETURN
5023	CONTINUE
	RETURN


	ENTRY TRACK

	IF(TRKING.EQ.0) GOTO 5024
	CLOSE(UNIT=21)
	TRKING=0
	CALL DPYCSC(7,2,16,2)
	RETURN
5024	OPEN(UNIT=21,DEVICE='DSK',
	1  ACCESS='SEQOUT',MODE='ASCII',FILE='TRKOUT.CPU')
	TRKING=1
	CALL DPYRSC(TRKLIT,7,2,16,2)
	RETURN


	END
