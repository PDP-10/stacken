0000�  REM DANIEL MYERS  TEST1 FOR BOOK   2-2-73
0001�  PRINT "AFTER THE ?   TYPE IN ALL TWENTY OF YOUR ANSWERS."
    0002�  PRINT "SEPARATE EACH ANSWER BY A COMMA."
 0003� DIM B(20),P$(10)
 0004�  MAT  INPUT B
    0005�  W=0
   0006�  FOR I=0 TO 3
    0007�  A=I+1
 0008�  FOR K=1 TO 5
    0009�  A=A+1
 0010�  IF A <= 5 THEN 120
   0011�  A=A-5
 0012� IF A=B(5*I+K) THEN 150
0013�  W=W+1
 0014�  GOSUB 260
  0015�  NEXT K
0016�  A=0
   0017�  NEXT I
0018�  IF W <= 2 THEN 220
   0019�  IF W<6 THEN 240
 0020�  PRINT "PERHAPS A LITTLE MORE STUDY IS IN ORDER."
   0021�  STOP 
 0022�  PRINT "W O W "
    0023�  STOP 
 0024�  PRINT "THAT IS PRETTY GOOD WORK."
   0025�  STOP 
 0026�  FOR I1=1 TO 5*I+K
    0027�  READ P$
    0028�  NEXT I1
    0029�  PRINT "YOU MISSED QUESTION #";I1;"REFER TO PAGE ";P$;"."
0030�  RESTORE 
   0031�  RETURN 
    0032� DATA "15","11","17","47","10","47","13","46","14","48"
   0033� DATA "11","47","14","9","19","13","47","19","19","14"
    0034�  END 
