0001�	RANDOMIZE
   0002�	REM *** TRAP ***
 0003�	REM *** COPYRIGHT 1974 BY PEOPLES COMPUTER COMPANY
  0004�	REM *** CONVERTED FOR DEC-10 USE BY:  DAVID NIXON 1977
   0005�	PRINT "DO YOU WANT INSTRUCTIONS ?";
  0006�	INPUT Z$
    0007�	IF MID$(Z$,1,1) <> "Y" THEN 220
 0008�	PRINT
  0009�	PRINT "I WILL THINK OF A NUMBER FROM 1 TO 100."
0010�	PRINT "TRY TO GUESS MY NUMBER. ENTER TWO NUMBER, TRYING"
 0011�	PRINT "TO TRAP MY NUMBER BY YOUR TWO NUMBERS. I'LL"
 0012�	PRINT "TELL YOU IF YOU HAVE TRAPPED MY NUMBER OR IF MY"
  0013�	PRINT "NUMBER IS SMALLER THAN YOUR TWO TRAPNUMBERS OR"
   0014�	PRINT "IF MY NUMBER IS LARGER THAN YOUR TWO TRAP NUMBERS."
    0015�	PRINT "IF I TELL YOU THAT YOU HAVE TRAPPED MY NUMBER, I"
 0016�	PRINT "MEAN THAT MY NUMBER IS *BETWEEN* YOUR TRAP NUMBERS"
    0017�	PRINT "OR - PERHAPS MY NUMBER IS THE SAME AS ONE OF YOUR"
0018�	PRINT "TRAP NUMBERS."
 0019�	PRINT
  0020�	PRINT "!  ! IMPORTANT ! ! IF YOU THINK YOU KNOW MY NUMBER, THEN"
    0021�	PRINT "ENTER YOUR GUESS FOR *BOTH* TRAP NUMBERS."
   0022�	PRINT
  0023�	LET X=INT(100*RND(0))+1
    0024�	PRINT "I'M THINKING...THINKING...AH! I HAVE A NUMBER!"
  0025�	LET K=1
0026�	PRINT
  0027�	PRINT "FIRST TRAP NUMBER: ";
    0028�	INPUT A
0029�	PRINT "SECOND TRAP NUMBER: ";
   0030�	INPUT B
0031�	LET T=SGN(X-A)+SGN(X-B)
    0032�	ON T+3 GOTO 360,340,330,340,380
 0033�	IF A=B THEN 410
  0034�	PRINT "MY NUMBER IS TRAPED BY YOUR NUMBERS."
   0035�	GOTO 390
    0036�	PRINT "MY NUMBER IS SMALLER THAN YOUR TRAP NUMBERS."
0037�	GOTO 390
    0038�	PRINT "MY NUMBER IS LARGER THAN YOUR TRAP NUMBERS."
 0039�	LET K=K+1
   0040�	GOTO 260
    0041�	PRINT "YOU GOT IT IN ";K;"GUESSES...LET'S PLAY AGAIN, LUCKY."
 0042�	GOTO 220
    0043�	END
