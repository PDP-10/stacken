0001� DIM D$(10),V$(10)
0002�  PRINT "DO YOU WANT INSTRUCTIONS";
   0003�  INPUT D$
   0004�  IF D$="YES" THEN 80
  0005�  IF D$="NO" THEN 140
  0006�  PRINT "TYPE YES OR NO"
    0007�  GOTO 20
    0008�  PRINT "FROM COULAW YOU LEARNED HW ELECTRICALLY CHARGED BODIES"
    0009�  PRINT "AFFECT EACH OTHER. NOW WE WILL INVESTIGATE HOW ONE"
   0010�  PRINT "BODY IS AFFECTED BY TWO OTHER BODIES."
 0011�  PRINT "YOU MAY CHOOSE THE POSITION OF THE OTHER 2 BODIES IN A FIRST"
   0012�  PRINT "QUADRANT 10X10 GRID (USE ORDERED PAIRS). AND INDICATE THE"
 0013�  PRINT "CHARGES ON ALL THREE BODIES (MEASURED IN COULOMBS)."
  0014�  PRINT "BY THE WAY, HOW MANY ELEMENTARY CHARGES ARE IN A COULOMB"
  0016�  LET B9=0
   0017�  K=9.E+09
   0018�  INPUT B
    0019�  LET B9=B9+1
0020� IF B>1E20 THEN 210
    0020� IF B>1E18 THEN 240
    0021�  IF B9>1 THEN 1430
    0022�  PRINT "TRY AGAIN PLEASE"
  0023�  GOTO 180
   0024�  PRINT "YES"
0025�  GOTO 260
   0026�  PRINT 
0027�  PRINT "THE COMPUTER WILL CALCULATE THE FORCE AND PRINT IT FOR YOU."
    0028�  PRINT "YOU WILL HAVE 6 SELECTIONS."
 0029�  C=0
   0030�  C=C+1
 0031�  B9=0
  0032�  B9=B9+1
    0033�  IF B9>2 THEN 530
0034�  PRINT "ENTER THE POSITION OF THE 2 BODIES, AND THE NUMBER OF COULOMBS ON EACH"
   0035�  PRINT "EXAMPLE     3,4,2"
 0036�  PRINT "A=";
0037�  INPUT X1,Y1,Q1
  0038�  PRINT "B=";
0039�  INPUT X2,Y2,Q2
  0040�  PRINT "HOW MANY COULOMBS OF CHARGE DOES C CARRY";
  0041�  INPUT Q3
   0042� IF X1<0 THEN 510
 0042� IF Y1<0 THEN 510
 0042� IF X2<0 THEN 510
 0042� IF Y2<0 THEN 510
 0043� IF Q1=0 THEN 470
 0043� IF Q2=0 THEN 470
 0043� IF Q3=0 THEN 470
 0044� IF X1<>X2 THEN 450
    0044� IF Y1=Y2 THEN 490
0045� IF X1<>Y1 THEN 460
    0045� IF X2=Y2 THEN 490
0046�  GOTO 550
   0047�  PRINT " A CHARGE OF 0 ON ANY OF THE BODIES WILL NOT HELP YOU."
    0048�  GOTO 320
   0049�  PRINT "TWO BODIES CANNOT OCCUPY THE SAME POINT!"
   0050�  GOTO 320
   0051�  PRINT "I SAID FIRST QUADRANT"
  0052�  GOTO 320
   0053�  PRINT "YOU ARE WASTING MY TIME AND YOURS--GOODBYE"
 0054�  GOTO 1420
  0055�  REM: D1,D2 ARE ALREADY SQUARED DISTANCES
 0056�  D1=X1^2+Y1^2
    0057�  D2=X2^2+Y2^2
    0058�  F1=K*Q1*Q3/D1
   0059�  F2=K*Q2*Q3/D2
   0060� IF X1<>0 THEN 630
0061�  P1=0
  0062�  GOTO 640
   0063�  P1=90-ATN(Y1/X1)*180/3.14
 0064� IF X2<>0 THEN 670
0065�  P2=0
  0066�  GOTO 680
   0067�  P2=90-ATN(Y2/X2)*180/3.14
 0068�  IF SGN(Q3*Q1)<0 THEN 700
  0069�  P1=P1+180
  0070�  F1=-F1
0071�  IF SGN(Q3*Q2)<0 THEN 730
  0072�  P2=P2+180
  0073�  F2=-F2
0074�  PRINT "THE FORCE EXERTED BY A ON C IS"F1"AT"P1"DEGREES."
0075�  PRINT "THE FORCE EXERTED BY B ON C IS"F2"AT"P2"DEGREES."
0076�  REM: ODD NUMBERS REFER TO FORCE 1(A) EVEN TO FORCE 2(B).
0077�  REM: HIGHER NUMBER IS THE Y FORCE.
  0078� IF P1<>180 THEN 800
   0079�  P1=0
  0080� IF P2<>180 THEN 820
   0081�  P2=0
  0082�  F3=F1*(ABS(COS(P1*3.14159/180)))
    0083�  F5=F1*(ABS(SIN(P1*3.14159/180)))
    0084�  F4=F2*(ABS(COS(P2*3.14159/180)))
    0085�  F6=F2*(ABS(SIN(P2*3.14159/180)))
    0087�  REM: F1 AND F2 ARE NOW X,Y COMPONENTS OF RESULTANT
 0088�  F2=F3+F4
   0089�  F1=F5+F6
   0090�  REM: F9 IS TOTAL FORCE MAGNITUDE
    0091�  F9=SQR(F1^2+F2^2)
    0092�  REM: FOLLOWING IS CALCULATION OF ANGLE OF FORCE
    0094� IF F1<0 THEN 950
 0094� IF F2>=0 THEN 1000
    0095� IF F1>=0 THEN 960
0095� IF F2>0 THEN 1020
0096� IF F1>0 THEN 970
 0096� IF F2>0 THEN 1040
0097�  REM: T=THE ANGLE OF RESULTANT
  0098�  T=90+ATN(ABS(F2)/F1)*180/3.14159
    0099�  GOTO 1050
  0100�  T=90-ATN(F2/F1)*180/3.14159
    0101�  GOTO 1050
  0102�  T=270-ATN(F2/F1)*180/3.14159
   0103�  GOTO 1050
  0104�  T=270+ATN(F2/ABS(F1))*180/3.14159
   0105�  PRINT 
0106�  PRINT "THE TOTAL FORCE IS"F9"AT "T"DEGREES FROM NORTH."
 0107�  IF C>8 THEN 1170
0108�  IF C >= 6 THEN 1110
  0109� PRINT
  0109� PRINT
  0110�  GOTO 300
   0111� PRINT
  0111� PRINT
  0111� PRINT
  0112�  PRINT "NOW THAT YOU KNOW (?) HOW ELECTRIC FORCES ADD, TRY THIS PROBLEM."
    0115�  PRINT "A IS LOCATED AT 0,3; B AT 3,0."
   0116�  PRINT "BOTH CARRY .001 COULOMB."
    0117�  PRINT "C CARRIES A NEGATIVE .001 COULOMB."
    0118�  PRINT "WHAT IS THE TOTAL FORCE ON C:";
   0119�  INPUT F9
   0120� IF C9>=1E10 THEN 1210
 0120� IF F9>1E08 THEN 1260
  0121�  PRINT "SORRY, STUDY THE EXAMPLES AND TRY AGAIN";
   0122�  INPUT F9
   0123� IF F9>=1E10 THEN 1240
 0123� IF F9>1E8 THEN 1260
   0124�  PRINT "YOU SEEM TO BE HAVING PROBLEMS; CONSULT YOUR INSTRUCTOR."
  0125�  GOTO 1420
  0126�  PRINT "BASED ON THIS DATA, WHAT ARE YOUR CONCLUSIONS AS"
0127�  PRINT "TO HOW ELECTRIC FORCES ADD.  BE AS BRIEF AS POSSIBLE."
0128�  PRINT "HAND IN ONLY YOUR CONCLUSIONS."
   0129�  PRINT "WHAT ONE WORD DESCRIBES HOW ELECTRICAL FORCES ADD";
   0130�  INPUT V$
   0131�  K=0
   0132�  IF V$="VECTOR" THEN 1390
  0133�  IF V$="VECTORS" THEN 1390
 0134�  IF V$="VECTORIALLY" THEN 1390
  0135�  K=K+1
 0136�  PRINT "UH???"
   0137�  IF K<2 THEN 1290
0138�  GOTO 1410
  0139�  PRINT "YIPPIE"
  0140�  GOTO 1420
  0141�  PRINT "NO LUCK TODAY??"
   0142�  STOP 
 0143�  PRINT "YOU HAD BETTER FIND OUT WHAT A COULOMB IS."
 0144�  END 
