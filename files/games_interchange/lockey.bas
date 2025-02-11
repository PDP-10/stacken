
100 REM -LOCKEY - STUDY OF COMPETITIVE INHIBITION OF THE ENZYME
110 REM ACETYLCHOLINESTERASE FOR APPLICATION TO LOCK AND KEY MODEL 
120 REM COPYRIGHT 1971 - STATE UNIVERSITY OF NEW YORK
130 REM PROGRAM DEVELOPED BY J. FRIEDLAND AND B. ROSEN 
140 REM PROGRAMMED BY D. SOBIN AND J. FRIEDLAND 8/71 
150 REM LATEST REVISION 8-25-72
160 PRINT "LOCKEY- A COMPETITIVE INHIBITION STUDY OF THE ENZYME" 
170 PRINT "ACETYLCHOLINESTERASE FEATURING THE LOCK AND KEY HYPOTHESIS" 
180 PRINT
190 PRINT "DO YOU WISH INSTRUCTIONS? (1=YES, 0=NO)"; 
200 INPUT Q
210 IF Q=0 THEN 610 
220 IF Q<>1 THEN 190
230 PRINT
240 PRINT "  YOU ARE CONDUCTING AN INVESTIGATION OF THE ENZYME"
250 PRINT " ACETYLCHOLINESTERASE.  FROM THE NAME YOU CAN TELL" 
260 PRINT " THAT THIS ENZYME WORKS ON THE CHEMICAL ACETYLCHOLINE." 
270 PRINT " IT BREAKS ACETYLCHOLINE INTO ACETIC ACID AND CHOLINE." 
280 PRINT
290 PRINT "  WE WANT TO INVESTIGATE WHICH INHIBITOR IS THE MOST" 
300 PRINT " EFFECTIVE IN SLOWING THE NORMAL ACTION OF THE ENZYME." 
310 PRINT " THIS WILL GIVE US VALUABLE INFORMATION ON ITS ACTION." 
320 PRINT
330 PRINT "      THE CODE FOR THE INHIBITORS IS:"
340 PRINT
350 PRINT "         1= AMMONIUM" 
360 PRINT "         2= DIMETHYLAMINE       BE SURE TO CONSULT" 
370 PRINT "         3= METHYLAMINE         THE IMPORTANT STRUCTURAL" 
380 PRINT "         4= PROSTIGMINE         FORMULAE LISTED IN THE" 
390 PRINT "         5= TRIMETHYLAMINE      INFORMATION PACKET" 
400 PRINT "         0= NO INHIBITOR" 
410 PRINT
420 PRINT " IN THIS STUDY YOU CAN CONTROL:"  
430 PRINT "       THE AMOUNT OF ACETYLCHOLINE" 
440 PRINT "       THE TYPE OF INHIBITOR" 
450 PRINT "       AND THE AMOUNT OF INHIBITOR" 
460 PRINT
470 PRINT "BY COMPARING THE STRUCTURE OF ACETYLCHOLINE WITH" 
480 PRINT "THE STRUCTURE OF THE FIVE INHIBITORS YOU SHOULD"
490 PRINT "BE ABLE TO MAKE A HYPOTHESIS AS TO WHICH OF THE " 
500 PRINT "FIVE INHIBITORS WILL BE THE MOST EFFECTIVE" 
510 PRINT  
520 PRINT "   REMEMBER: INCLUDE YOUR KNOWLEDGE OF THE" 
530 PRINT "   LOCK AND KEY MODEL OF ENZYME ACTION."
540 REM S1=AMOUNT OF SUBSTRATE 
550 REM P1=AMOUNT OF PRODUCT AT TIME T1
560 REM V=VELOCITY OF REACTION IN MILLIMOLES/.002 MIN
570 REM M=MAX VELOCITY AT GIVEN ENZYME CONCENTRATION 
580 REM K1=MECHAELIS-MENTEN CONSTANT 
590 REM K2=BINDING CONSTANT OF INHIBITIOR
600 REM I=CONCENTRATION OF INHIBITOR 
610 LET N=1
620 PRINT
630 READ T,P1,C,K1,M,X,V 
640 DATA 0,0,0,9E-5,3E-3,1000,0
650 PRINT "*******************************************************"
660 LET T1=0 
670 PRINT
680 PRINT "AMOUNT OF ACETYLCHOLINE - FROM 0 TO 3 MILLIMOLES";
690 INPUT S1 
700 IF S1>3 THEN 680 
710 IF S1<0 THEN 680 
720 IF S1>0 THEN 750 
730 PRINT "NO REACTION IS POSSIBLE WITHOUT SUBSTRATE"
740 GOTO 1470 
750 LET S1=S1/1000 
760 LET S2=S1
770 PRINT "TYPE OF INHIBITOR - USE CODE FROM 0 TO 5";
780 INPUT K2 
790 IF K2<>INT(K2) THEN 770
800 IF K2>5 THEN 770 
810 IF K2<0 THEN 770 
820 IF K2=0 THEN 1060 
830 IF K2<4 THEN910
840 IF K2=4 THEN 880 
850 REM CODE 5= TRIMETHYLAMINE 
860 LET K2=2.6E-3
870 GOTO 1010 
880 REM CODE 4= PROSTIGMINE
890 LET K2=1.6E-5
900 GOTO 1010 
910 IF K2>=2 THEN 950
920 REM CODE 1 = NH3 
930 LET K2=.9
940 GOTO 1010 
950 IF K2=2 THEN 990 
960 REM CODE 3= METHYLAMINE
970 LET K2=.12 
980 GOTO 1010 
990 REM CODE 2= DIMETHYLAMINE
1000 LET K2=2.1E-2
1010 PRINT "AMOUNT OF INHIBITOR IN MILLIMOLES"; 
1020 INPUT I
1030 LET I=I/1000 
1040 IF I<0 THEN 1010
1050 IF I<>0 THEN 1080 
1060 LET K2=1 
1070 LET I=0
1080 LET K=K1+(K1*I/K2) 
1090 PRINT "DATA FORMAT: 1=TABLE, 2=GRAPH"; 
1100 IF N<>1 THEN 1120 
1110 PRINT "   TYPE NUMBER OF CHOICE";
1120 INPUT Q
1130 IF (Q-1)*(Q-2)<>0 THEN 1090 
1140 IF Q=1 THEN 1290
1150 GOTO 1630
1160 IF Q=2 THEN 1670 
1170 GOTO 1340 
1180 IF T1=X THEN 1390 
1190 FOR T=T1+1 TO T1+50
1200 REM FOLLOWING EQN EQUIV. TO V=M*S/S+K1(1+I/K2) = M-M EQN 
1210 LET V1=(M*S1)/(S1+K)   
1220 LET V=(V+V1)/1000
1230 LET S1=S1-V
1240 LET P1=P1+V
1250 LET V=V1 
1260 NEXT T 
1270 LET T1=T1+50 
1280 GOTO 1160 
1290 PRINT
1300 PRINT
1310 PRINT"MINUTES     ACETYLCHOLINE   TOTAL ACETIC"
1320 PRINT"ELAPSED     REMAINING       ACID PRODUCED" 
1330 PRINT"-------     -------------   -------------" 
1340 PRINT (T1)/500, INT(S1*10^5+.5)/100,INT(P1*10^5+.5)/100
1350 IF INT(S1*10^5+.5)/100<=0 THEN 1370   
1360 GOTO 1180 
1370 PRINT " THE REACTION HAS RUN TO COMPLETION"
1380 GOTO 1450 
1390 PRINT "DO YOU WANT TO CONTINUE THE ASSAY? (1=YES, 0=NO)";
1400 INPUT Q2 
1410 IF Q2=0 THEN 1450 
1420 IF Q2<>1 THEN 1390
1430 LET X=X+500
1440 GOTO 1190 
1450 PRINT  
1460 PRINT "CONCENTRATION OF INHIBITIOR REMAINING:"I*1000;"MILLIMOLES"
1470 PRINT
1480 PRINT "ANOTHER EXPERIMENT? (1=YES, 0=NO)"; 
1490 INPUT Q
1500 IF Q=1 THEN 1600  
1510 IF Q<>0 THEN 1480 
1520 PRINT
1530 PRINT
1540 PRINT
1550 PRINT
1560 PRINT
1570 PRINT
1580 PRINT
1590 STOP 
1600 RESTORE
1610 LET N=N+1
1620 GOTO 620
1630 PRINT
1640 PRINT"MIN.        MILLIMOLES ACETIC ACID PRODUCED" 
1650 PRINT TAB(6);"0";TAB(30);INT(S2*10^3+.99)/2;TAB(55);
1655 PRINTINT(S2*10^3+.99)
1660 PRINT "      I....I....I....I....I....I....I....I....I....I....I"
1670 PRINT (T1)/500;TAB(5);"I";TAB(P1*10^3/INT(S2*10^3+.99)*50+6.5);
1675 PRINT"*";
1680 PRINT INT(P1*10^5+.5)/100  
1690 GOTO 1350
1700 END
*U*)3                                                                                                                                                                                                                                                                                                                                                                                                       