0010� REM ***REVERSE-A GAME OF SKILL
  0011� REM ***PEOPLE'S COMPUTER COMPANY
0012� REM ***ENTERED BY CHRIS PABST
   0013� DIM A(20)
   0014� REM ***N=NUMBER OF NUMBERS (1 THRU N)
0015� N=9
    0016� PRINT "DO YOU WANT THE RULES (YES, NO)";
  0017� INPUT A$
    0018� IF A$="NO" THEN 210
   0019� GOSUB 710
   0020� REM ***MAKE A RANDOM LIST A(1) TO A(N)
    0021� FOR I=1 TO N
0021� A(I)=I
 0022� NEXT I
 0023� FOR I=N TO 2 STEP -1
  0023� RANDOMIZE
   0023� K=INT(I*RND(X))+1
0024� T=A(I)
 0024� A(I)=A(K)
   0025� A(K)=T
 0025� NEXT I
 0028� REM ***PRINT ORIGINAL LIST AND START GAME
 0029� PRINT
  0030� PRINT "HERE WE GO...THE LIST IS:"
 0031� T=0
    0032� GOSUB 610
   0033� PRINT "HOW MANY SHALL I REVERSE";
    0034� INPUT R
0035� IF R=0 THEN 520
  0036� IF R<=N THEN 390
 0037� PRINT "OOPS! TOO MANY - I CAN REVERSE AT MOST";N
   0038� GOTO 330
    0039� T=T+1
  0040� REM ***REVERSE R NUMBERS AND PRINT NEW LIST
    0041� FOR K=1 TO INT(R/2)
   0042� Z=A(K)
 0043� A(K)=A(R-K+1)
    0044� A(R-K+1)=Z
  0045� NEXT K
 0046� GOSUB 610
   0047� REM ***CHECK FOR A WIN
0048� FOR K=1 TO N
0049� IF A(K)<>K THEN 330
   0050� NEXT K
 0051� PRINT "YOU WON IN";T;"MOVES!!"
0052� PRINT
  0053� PRINT "DO YOU WANT TO DO THIS AGAIN (YES,NO)";
 0054� INPUT A$
    0055� IF A$<>"NO" THEN 210
  0056� STOP
   0060� REM ***SUBROUTINE ***PRINT  LIST A(1) TO A(N)
  0061� PRINT
  0062� FOR K=1 TO N
0063� PRINT A(K);
 0064� NEXT K
 0065� PRINT
  0066� PRINT
  0067� RETURN
 0070� REM ***SUBROUTINE ***PRINT THE RULES
 0071� PRINT
  0072� PRINT "THIS IS THE GAME OF 'REVERSE'. TO WIN"
  0073� PRINT "YOU MUST THE LIST OF NUMBERS  (1 THROUGH";N;")"
   0074� PRINT "IN NUMERICAL ORDER FROM LEFT TO RIGHT. TO MOVE,"
  0075� PRINT "TELL ME HOW MANY NUMBERS (COUNTING FROM THE LEFT) TO"
  0076� PRINT "REVERSE. FOR EXAMPLE"
    0077� PRINT
  0078� PRINT " 2 3 4 5 1 6 7 8 9"
 0079� PRINT
  0080� PRINT "AND YOU REVERSE 4"
  0081� PRINT
  0082� PRINT " 5 4 3 2 1 6 7 8 9"
 0083� PRINT
  0084� PRINT "NOW YOU REVERSE 5"
  0085� PRINT
  0086� PRINT " 1 2 3 4 5 6 7 8 9"
 0087� PRINT
  0088� PRINT "NO DOUBT YOU WILL LIKE THIS GAME OF SKILL"
   0089� PRINT "IF YOU WANT TO QUIT(GOD FORBID)"
   0090� PRINT "PRESS THE CONTROL BUTTON AND THE C BUTTON SIMULTANEOUSLY"
   0091� RETURN
 0099� END
