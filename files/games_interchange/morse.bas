0001� REM MORSE.BAS-----WRITTEN BY DAVID MAYNE.
 0002� DIM A$(41),B$(41),C$(200)
  0003� MAT READ A$,B$
   0004� PRINT "THIS PROGRAM HAS THREE OPTIONS:"
   0005� PRINT
  0006� PRINT "(1) TRANSLATE A MESSAGE INTO MORSE CODE."
    0007� PRINT "(2) TRANSLATE A MESSAGE FROM MORSE CODE TO REGULAR LETTERS."
0008� PRINT "(3) TYPE OUT THE MORSE CODE TABLE."
0009� PRINT
  0010� PRINT "WHICH OPTION DO YOU WANT";
    0011� INPUT A
0012� PRINT
  0013� ON A GOTO 140,350,580
 0014� PRINT "DO YOU KNOW WHAT CHARACTERS YOU CAN USE";
    0015� INPUT A$
    0016� PRINT
  0017� IF A$="YES" GOTO 210
  0018� PRINT "LEGAL CHARACTERS ARE:  ABCDEFGHIJKLMNOPQRSTUVWXYZ"
0019� PRINT TAB(28);"1234567890 .:;'"
 0020� PRINT
  0021� PRINT "INPUT YOUR MESSAGE";
0022� INPUT B$
    0023� PRINT
  0024� IF LEN(B$)=0 THEN 410
 0025� FOR A=1 TO LEN(B$)
    0026� FOR B=1 TO 41
    0027� IF MID$(B$,A,1)=B$(B) THEN 310
  0028� NEXT B
 0029� PRINT "%LDJNK?  ILLEGAL CHARACTER '";MID$(B$,A,1);"' ENCOUNTERED"
  0030� STOP
   0031� PRINT A$(B);" ";
 0032� NEXT A
 0033� PRINT
  0034� GOTO 640
    0035� PRINT "USE A '*' AS A DOT, '-' AS A DASH, '@' AS A SPACE."
    0036� PRINT
  0037� PRINT "INPUT YOUR MESSAGE";
0038� MAT INPUT C$
0039� PRINT
  0040� IF NUM<>0 THEN 450
    0041� PRINT "%INPJNK?  NO INPUT DATA AT PC";
    0042� RANDOMIZE
   0043� PRINT INT(RND*100000)
 0044� STOP
   0045� FOR B=1 TO NUM
   0046� IF C$(B)="@" GOTO 540
 0047� FOR C=1 TO 41
    0048� IF C$(B)=A$(C) THEN 520
    0049� NEXT C
 0050� PRINT "%LDJNK?  UNRECOGNIZABLE CODE '";C$(B);"' IN DATA ENTRY"
0051� STOP
   0052� PRINT B$(C);
0053� GOTO 550
    0054� PRINT " ";
  0055� NEXT B
 0056� PRINT
  0057� GOTO 640
    0058� PRINT
  0059� PRINT "ASCII","MORSE CODE"
 0060� PRINT
  0061� FOR A=1 TO 40
    0062� PRINT B$(A),A$(A)
0063� NEXT A
 0064� PRINT
  0065� PRINT "ANOTHER RUN";
  0066� INPUT A$
    0067� IF A$="YES" GOTO 90
   0068� DATA "*-","-***","-*-*","-**","*","**-*","--*","****","**","*---"
  0069� DATA "-*-","*-**","--","-*","---","*--*","--*-","*-*","***","-"
    0070� DATA "**-","***-","*--","-**-","-*--","--**","*----","**---","***--"
    0071� DATA "****-","*****","-****","--***","---**","----*","-----"
  0072� DATA "*-*-*-","---***","-*-*-*","*-**-*"," ","A","B","C","D","E"
   0073� DATA "F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T"
   0074� DATA "U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9"
   0075� DATA "0",".",":",";","'"," "
    0076� END
