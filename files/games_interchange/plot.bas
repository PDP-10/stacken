0890�  DEF FNF(X)=SIN(X)
    0891�: INPUT Z(I)
 0892�  REM  *****  PLOT  *****  MATHEMATICS PROGRAM  *****
0893�  REM  *****  VERSION 1  *****  7/31/69  *****
  0894�  REM  PLOTS A FUNCTION ON THE TTY.
   0895�  LET R1=0
   0896�  LET L1=0
   0897�  LET Q1=0
   0898� PRINT "PLEASE INPUT THE FOLLOWING PARAMETERS."
 0899� PRINT "LEFT X-ENDPOINT."
   0900�  INPUT A
    0901�  PRINT "RIGHT X-ENDPOINT";
 0902�  INPUT B
    0903�  PRINT "X-SPACING";
   0904�  INPUT D
    0905�  PRINT "THE NUMBER OF UNDEFINED POINTS (IF NONE, ENTER 0)";
   0906�  INPUT N9
   0907�  IF N9=0 THEN 9120
    0908� PRINT "ENTER THE UNDEFINED POINTS SEPARATED BY CARRIAGE RETURNS."
  0909� FOR I=1 TO N9
    0910� INPUT Z(I)
  0911� NEXT I
 0912�  DEF FNG(X)=INT((Y7-L1)/D1+.5)+15
    0913�  LET L2=R2=FNF(A)
0914�  FOR X=A TO B STEP D
  0915�  FOR I=1 TO N9
   0916� IF X=Z(I) THEN 9220
   0917�  NEXT I
0918�  IF FNF(X)>L2 THEN 9200
    0919�  LET L2=FNF(X)
   0920�  IF FNF(X)<R2 THEN 9220
    0921�  LET R2=FNF(X)
   0922�  NEXT X
0923�  IF L2<0 THEN 9260
    0924�  LET R1=R2
  0925�  GOTO 9300
  0926�  IF R2>0 THEN 9280
    0927�  GOTO 9290
  0928�  LET R1=R2
  0929�  LET L1=L2
  0930�  LET D1=(R1-L1)/50
    0931�  IF L1<R1 THEN 9340
   0932�  PRINT "THIS IS THE FUNCTION Y=CONSTANT."
 0933�  STOP 
 0934� PRINT "THE MANIMUM VALUE OF THE FUNCTION IS";L2
0935� PRINT "THE MAXIMUN VALUE OF THE FUNCTION IS";R2
0936� PRINT
  0937� PRINT "THE SPACING ON THE Y-AXIS IS";D1
   0938� PRINT
  0939� PRINT
  0940� PRINT
  0941�  LET F=INT(-L1/D1+.5)+15
   0942�  IF A <= 0 THEN 9530
  0943�  IF A/D>6 THEN 9530
   0944�  LET Q1=1
   0945�  IF L1=0 THEN 9470
    0946�  PRINT TAB(F);"+"
0947�  PRINT 
0948�  GOTO 9720
  0949�  FOR I=1 TO INT(A/D-.5)
    0950�  PRINT TAB(F);"+"
0951�  NEXT I
0952�  LET Q1=0
   0953�  FOR X=A TO B STEP D
  0954�  IF D<.0001 THEN 9570
 0955�  IF ABS(X)>.00001 THEN 9570
0956�  LET X=0
    0957�  PRINT X,
   0958�  FOR P=1 TO N9
   0959� IF X<>Z(P) THEN 9690
  0960� IF X<>0 THEN 9670
0961�  FOR I2=1 TO 50
  0962�  PRINT "+";
 0963�  NEXT I2
    0964�  LET Q=1
    0965�  PRINT "Y"
  0966�  GOTO 10000
 0967�  PRINT TAB(F);"+"
0968�  GOTO 10000
 0969�  NEXT P
0970�  IF X*(X+D)>0 THEN 9900
    0971�  IF X<-D/2 THEN 9900
  0972�  FOR I=0 TO 50
   0973�  IF Q1>0 THEN 9760
    0974�  LET Y7=FNF(X)
   0975�  IF FNG(X)=I+15 THEN 9790
  0976�  IF I+15=F THEN 9810
  0977�  PRINT "+";
 0978�  GOTO 9820
  0979�  PRINT "*";
 0980�  GOTO 9820
  0981�  PRINT "O";
 0982�  NEXT I
0983� IF I+15<>F THEN 9850
  0984�  PRINT "+";
 0985�  PRINT "Y"
  0986�  LET Q=1
    0987�  IF (Q1+1)=1 THEN 10000
    0988�  IF (Q1+1)=2 THEN 9490
0989�  IF (Q1+1)=3 THEN 10090
    0990�  IF X*(X-D)>0 THEN 9920
    0991�  IF X <= D/2 THEN 9720
0992�  LET Y7=FNF(X)
   0993�  IF FNG(X)>F THEN 9990
0994�  IF FNG(X)=F THEN 9970
0995�  PRINT TAB(FNG(X));"*";TAB(F);"+"
    0996�  GOTO 10000
 0997�  PRINT TAB(F);"*"
0998�  GOTO 10000
 0999�  PRINT TAB(F);"+";TAB(FNG(X));"*"
    1000�  NEXT X
1001�  IF X >= 0 THEN 10100
 1002�  IF -X/D>6 THEN 10100
 1003�  FOR I=1 TO INT(-X/D-.5)
   1004�  PRINT TAB(F);"+"
1005�  NEXT I
1006�  LET Q1=2
   1007�  PRINT 
1008�  GOTO 9720
  1009�  PRINT TAB(F);"+"
1010�  PRINT TAB(F);"X"
1011�  IF Q=0 THEN 10130
    1012�  STOP 
 1013�  PRINT 
1014�  PRINT 
1015�  PRINT 
1016�  FOR I=0 TO 50
   1017�  PRINT "+";
 1018�  NEXT I
1019�  PRINT "Y"
  1020�  PRINT 
1021�  PRINT 
1022�  PRINT "               SINCE THE REAL Y-AXIS IS OFF THE GRAPH."
    1023�  STOP 
 1024�  END 
