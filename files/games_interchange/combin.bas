0001� PRINT "INPUT 1 FOR THE PROGRAM 'SERIES'"
  0002� PRINT "INPUT 2 FOR THE PROGRAM 'PROGRS'"
  0003� PRINT "INPUT 3 FOR THE PROGRAM 'OHMS'"
    0004� PRINT "INPUT 4 FOR THE PROGRAM 'DYNO'"
    0005� INPUT A
0006� ON A GOTO 1000,2000,3000,4000
   0100� PRINT "THIS A PROGRAM ON GEOMETRIC SERIES."
    0101� PRINT "INPUT VALUES FOR THE FIRST TERM, RATION AND # OF TERMS."
    0102� INPUT A,R,N
 0103� PRINT "THE";N;"TH TERM IS ";A*R^(N-1)
0104� PRINT "THE SUM OF THE TERMS IS";A*(R^N-1)/(R-1)
0199� STOP
   0200� PRINT "THIS PROGRAM FIND THE SUM OF AN ARITHMETIC PROGRESSION."
    0200� PRINT "PROGRESSION"
   0201� INPUT A,D,N
 0220� PRINT "SUM-";N*(2*A*(N-1)*D)/2
  0299� STOP
   0300� PRINT "OHMS =E/I.  INPUT E AND I."
   0310� INPUT E,I
   0320� PRINT "OHMS =";E/I
    0399� STOP
   0400� PRINT "DYNO"
0410� PRINT TAB(4);"MITE"
   0420� PRINT "B  O  O  M  !!!"
0490� END
