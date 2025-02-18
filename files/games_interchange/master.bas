0001�   REM***THE GAME OF MASTERMIND AS WRITTEN FOR COMPUTER IN THE BASIC
0002�   REM***LANGUAGE BY GREG JOHNSON OF CORONADO HIGH SCHOOL, MARCH 12,
0003�   REM***1976--EDITED AND REPROGRAMED ON OCTOBER 15,1976***
    0004�  REM***REVISED AND REEDITED ON JAN.10,1976***
  0005�   PRINT"DO YOU WANT INSTRUCTIONS";
   0006�   INPUT L$
  0007�   IF L$="YES",THEN 110
0008�   IF L$="NO",THEN 320
 0009�   PRINT"YES OR NO, PLEASE!!"
    0010�   GOTO 50
   0011�   PRINT
0012�  PRINT"THIS IS THE GAME OF MASTERMIND WHERE YOU TRY TO BREAK THE HIDDEN CODE."
    0013�  PRINT"THE COMPUTER WILL HIDE FOUR COLORED 'PEGS.' YOU MUST MATCH BOTH THE"
  0014�  PRINT"COLOR AND POSITION OF EACH OF THE FOUR 'PEGS.' YOU WILL HAVE SIX TRYS."
    0015�  PRINT"THE ONLY CLUES YOU WILL BE GIVEN TO TELL IF YOU ARE RIGHT OR WRONG ARE"
    0016�  PRINT"WHITE AND BLACK KEY 'PEGS.' THE WHITE 'PEG' MEANS THAT ONE OF YOUR"
   0017�  PRINT"'PEGS'IS THE RIGHT COLOR BUT NOT IN THE RIGHT POSITION(YOU DON'T KNOW"
0018�  PRINT"WHICH ONE IT IS SO YOU REALLY HAVE TO THINK!!). THE BLACK 'PEGS' MEAN"
0019�  PRINT"THAT BOTH COLOR AND POSITION ARE CORRECT(AGAIN, YOU DON'T KNOW WHICH"
 0020�  PRINT"ONE!!). THE FOLLOWING COLORS MAY BE USED FOR DECODING IN ANY COMBINA-"
0021�  PRINT"TION:"
    0022�  PRINT
 0023�  PRINT TAB(15)"YELLOW"
0024�  PRINT TAB(15)"ORANGE"
0025�  PRINT TAB(15)"GREEN"
 0026�  PRINT TAB(15)"BLUE"
  0027�  PRINT TAB(15)"RED"
   0028�  PRINT TAB(15)"TAN"
   0029�  PRINT"TYPE ONLY THE FIRST LETTER OF THE COLOR AND NOT THE WHOLE COLOR NAME"
 0030�  PRINT"YOU MAY ALSO USE BLANK SPACES BY TYPING IN AN 'A' INSTEAD OF A COLOR."
0031�  PRINT"GOOD LUCK AND HAVE FUN!!!"
   0032�  PRINT
 0033�  W=0
   0034�  L=0
   0035�  G=0
   0036�  G=G+1
 0037�  FOR G1=1 TO 70
  0038�  PRINT"-";
  0039�  NEXT G1
    0040�  PRINT
 0041�  PRINT TAB(26)"***GAME # "G"***"
0042�  PRINT TAB(26)"----------------"
0043�  DIM Y(4)
   0044�  DIM Z$(7)
  0045�  FOR X=1 TO 4
    0046�  RANDOMIZE
  0047�  Y=(INT(RND*100))/100
 0048�  IF Y>0.69,THEN 560
   0049�  IF Y<=0.09,THEN 580
  0050�  IF Y<=0.19,THEN 600
  0051�  IF Y<=0.29,THEN 620
  0052�  IF Y<=0.39,THEN 640
  0053�  IF Y<=0.49,THEN 660
  0054�  IF Y<=0.59,THEN 680
  0055�  IF Y<=0.69,THEN 700
  0056�  Y=(RND-.3)
 0057�  GOTO 490
   0058�  A$(X)="A"
  0059�  GOTO 710
   0060�  A$(X)="B"
  0061�  GOTO 710
   0062�  A$(X)="Y"
  0063�  GOTO 710
   0064�  A$(X)="G"
  0065�  GOTO 710
   0066�  A$(X)="R"
  0067�  GOTO 710
   0068�  A$(X)="T"
  0069�  GOTO 710
   0070�  A$(X)="O"
  0071�  NEXT X
0072�  Z$(1)="A"
  0073�  Z$(2)="B"
  0074�  Z$(3)="Y"
  0075�  Z$(4)="G"
  0076�  Z$(5)="R"
  0077�  Z$(6)="T"
  0078�  Z$(7)="O"
  0079�  K=1
   0080�  B=0
   0081�  IF K>6,THEN 1380
0082�  PRINT
 0083�  PRINT"WHAT ARE YOUR FOUR COLORS FOR ROW "K;
   0084�  INPUT B$(1),B$(2),B$(3),B$(4)
  0085�  FOR C=1 TO 4
    0086�  FOR D=1 TO 7
    0087�  IF B$(C)=Z$(D),THEN 900
   0088�  NEXT D
0089�  GOTO 920
   0090�  NEXT C
0091�  GOTO 950
   0092�  PRINT"YOU HAVE EITHER MISSPELLED A COLOR OR HAVE AN ILLEGAL COLOR ON INPUT."
0093�  PRINT"PLEASE CHECK FOR MISSPELLING AND TRY AGAIN."
 0094�  GOTO 820
   0095�  FOR H=1 TO 4
    0096�  X(H)=0
0097�  NEXT H
0098�  FOR I=1 TO 4
    0099�  FOR J=1 TO 4
    0100�  IF B$(I)<>A$(J),THEN 1080
 0101�  IF I<>J,THEN 1040
    0102�  X(I)=1
0103�  GOTO 1090
  0104� IF X(J)<>0,THEN 1080
  0105�  IF B$(I)=A$(I),THEN 1020
  0106� X(J)=2
 0107� GOTO 1090
   0108� NEXT J
 0109� NEXT I
 0110� FOR F=1 TO 4
0111� IF X(F)=1,THEN 1140
   0112� IF X(F)=2,THEN 1180
   0113� GOTO 1190
   0114� PRINT"BLACK,";
   0115� B=B+1
  0116� IF B=4,THEN 1250
 0117� GOTO 1190
   0118� PRINT"WHITE,";
   0119� NEXT F
 0120� PRINT" "
    0121� PRINT"YOU DIDN'T GET IT ON TRY NUMBER   "K" YOU NOW HAVE "6-K" TRYS LEFT."
   0122� PRINT
  0123� K=K+1
  0124� GOTO 800
    0125� PRINT
  0126� PRINT
  0127� PRINT"VERY GOOD!! YOU BROKE THE CODE ON TRY NUMBER "K
    0128� W=W+1
  0129� PRINT
  0130� GOTO 1400
   0131� PRINT"DO YOU WANT TO PLAY AGAIN";
    0132� INPUT Q$
    0133� PRINT
  0134� IF Q$="YES",THEN 360
  0135� IF Q$="NO",THEN 1430
  0136� PRINT"YES OR NO, PLEASE."
  0137� GOTO 1310
   0138� PRINT"SORRY, BUT YOU BLEW IT SIX TIMES:"
  0139� L=L+1
  0140� PRINT"THE HIDDEN CODE WAS--"A$(1)","A$(2)","A$(3)","A$(4)
0141� PRINT
  0142� GOTO 1310
   0143� PRINT
  0144� PRINT"HERE IS YOUR WIN/LOSE RECORD FOR "G" GAMES:"
  0145� PRINT
  0146� PRINT TAB(10)"WIN     LOSE"
0147� PRINT TAB(8)"----------------"
  0148� PRINT
  0149� PRINT TAB(10)W;TAB(18)L
    0150� PRINT
  0151� IF W>L,THEN 1560
 0152� IF W=L,THEN 1590
 0153� PRINT"THE MASTER CODEMAKER TRICKED YOU "L" OUT OF "G" TIMES. BETTER LUCK"
    0154� PRINT"NEXT TIME."
0155� GOTO 1600
   0156� PRINT"CONGRATULATIONS!!!!! YOU BEAT THE MASTER CODEMAKER "W" OUT OF"
   0157� PRINT G"TIMES. KEEP UP THE GOOD WORK!!!"
    0158� GOTO 1600
   0159� PRINT"NOT TOO BAD. YOU TIED THE MASTER CODEMAKER "W" TIMES!!"
    0160� END
