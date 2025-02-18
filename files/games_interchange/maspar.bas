
10 REM MASPAR - MASS POLITICAL PARTICIPATION INDEX
20 REM COPYRIGHT 1973, 1974 - STATE UNIVERSITY OF NEW YORK
30 REM DEVELOPED BY D. KLASSEN AND J. MCGRATH
40 REM PROGRAMMED BY S. HOLLANDER, J. MCGRATH
50 REM LATEST REVISION:  1/22/74
60 DEFFNR(A)=FNS(A)*A
70 DEFFNS(X)=SGN(SGN(X)+1)
74 PRINT
75 PRINT" ","MASPAR - MASS POLITICAL PARTICIPATION INDEX"
76 PRINT
80 PRINT"DO YOU WANT INSTRUCTIONS(1=YES,0=NO)"; 
90 INPUTA 
100 PRINT
110 IFA=0THEN390
120 IFA<>1THEN80
130 PRINT"THIS PROGRAM SIMULATES LEVELS OF POLITICAL PARTICIPATION"
140 PRINT" IN A SOCIETY AS A FUNCTION OF THE FOLLOWING FACTORS:"
150 PRINT
160 PRINT"     1 - CLASS STRUCTURE OF THE SOCIETY" 
170 PRINT"          UPPER, MIDDLE, LOWER"
180 PRINT"     2 - ORGANIZATIONAL DENSITY" 
190 PRINT"          PERCENT OF POPULATION BELONGING TO ORGANIZATIONS"
200 PRINT"     3 - RELATIONSHIP BETWEEN CLASS STRUCTURE AND "
210 PRINT"          ORGANIZATIONAL INVOLVEMENT"
220 PRINT
230 PRINT
240 PRINT"THE PROPORTION OF POPULATION IN EACH CLASS"  
250 PRINT" SHOULD BE A NUMBER BETWEEN FIVE AND NINETY."
260 PRINT" THE THREE NUMBERS MUST TOTAL ONE HUNDRED."
270 PRINT
290 PRINT"THE ORGANIZATIONAL DENSITY MUST BE A DECIMAL LESS THAN .99."
300 PRINT
310 PRINT
320 PRINT"EXAMPLE --"  
330 PRINT"     LOWER? 60"
340 PRINT"     MIDDLE? 30"
350 PRINT"     UPPER? 10"
360 PRINT
370 PRINT"     ORGANIZATIONAL DENSITY? .35"
375 PRINT
380 PRINT"****************************************************"
385 PRINT
390 PRINT"INPUT PROPORTION OF POPULATION IN EACH OF THE THREE CLASSES" 
400 PRINT"     LOWER";
410 INPUTA 
420 IFSGN(A-4)+SGN(91-A)<2THEN400
430 PRINT"     MIDDLE";
440 INPUTB 
450 IFSGN(B-4)+SGN(91-B)<2THEN430
460 PRINT"     UPPER";
470 INPUTC 
480 IFSGN(C-4)+SGN(91-C)<2THEN460
490 IFABS(A+B+C-100)<.01THEN530
500 PRINT"THE TOTAL MUST EQUAL 100"
510 GOTO 390
520 PRINT
530 PRINT
540 PRINT"WHAT IS THE ORGANIZATIONAL DENSITY";
550 INPUT M
560 IFM>1THEN540
570 PRINT
580 PRINT"IS THERE A POSITIVE RELATIONSHIP BETWEEN SOCIAL CLASS"
590 PRINT" AND ORGANIZATIONAL INVOLVEMENT? (1=YES,0=NO)";
600 INPUTN 
610 PRINT  
630 IF N=1 THEN 760
640 IFN<>0THEN580
645 PRINT"PROPORTION OF TOTAL POPULATION IN EACH OF THE SIX GROUPS"
650 PRINT  
660 LETT1=INT(A*M+.5)
670 LETT2=INT(A-A*M)
680 LETT3=INT(B*M+.5)
690 LETT4=INT(B-B*M)
700 LETT5=INT(C*M+.5)
710 LETT6=INT(C-C*M)
720 GOSUB1110
730 PRINT  
740 PRINT  
750 GOTO890
760 LETX=M-.0017*B-.0035*C
770 LETY=.99*FNS(X-.821)+(X+.17)*FNS(.821-X)
780 LETZ=.99*FNS(X-.641)+(X+.35)*FNS(.641-X)
790 PRINT  
800 LETT1=INT(FNR(X*A)+.5)
810 LETT2=INT(FNR(A-T1)+.5)
820 LETT3=INT(FNR(Y*B)+.5)
830 LETT4=INT(FNR(B-T3)+.5)
840 LETT5=INT(FNR(Z*C)+.5)
850 LETT6=INT(FNR(C-T5)+.5)
860 GOSUB1110
870 PRINT  
880 PRINT  
890 PRINT"PROPORTION OF POLITICAL PARTICIPANTS IN EACH GROUP"
900 PRINT  
910 LETT1=T1*.5
920 LETT2=T2*.15
930 LETT3=T3*.6
940 LETT4=T4*.25
950 LETT5=T5*.7
960 LETT6=T6*.35
970 LETQ=T1+T2+T3+T4+T5+T6
980 LET T1=T1/Q*100
990 LET T2=T2/Q*100
1000 LET T3=T3/Q*100
1010 LET T4=T4/Q*100
1020 LET T5=T5/Q*100
1030 LET T6=T6/Q*100
1040 GOSUB1110
1050 PRINT  
1060 PRINT"PARTICIPATION INDEX FOR SOCIETY IS ";INT(Q+.5)
1070 PRINT
1080 PRINT"UNDERREPRESENTATION INDEX IS ";INT((A-T1-T2)/A*100+.5)
1090 PRINT  
1100 GOTO1290
1110 PRINT" ","    ORGANIZATIONALLY    "
1120 PRINT" ","INVOLVED","UNINVOLVED"
1130 PRINT  
1140 PRINT"LOWER ";A, 
1150 LETG=T1  
1160 LETG1=T2 
1170 GOSUB1250
1180 PRINT"MIDDLE";B, 
1190 LETG=T3  
1200 LETG1=T4 
1210 GOSUB1250
1220 PRINT"UPPER ";C, 
1230 LETG=T5  
1240 LETG1=T6 
1250 LETG=INT(G+.5)
1260 LETG1=INT(G1+.5)
1270 PRINTG,G1  
1280 RETURN
1290 PRINT"DO YOU WANT ANOTHER RUN (1=YES,0=NO)";
1300 INPUTM
1310 IFM=1THEN375
1320 END
B$$BB$$BB$$BL