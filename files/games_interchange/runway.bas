0000� A=B=C=D=E=X=0
    0000� PRINT "DO YOU NEED INSTRUCTIONS";
    0001� INPUT A$
    0001� IF A$<>"YES" THEN 85
  0002� PRINT
  0002� PRINT "YOU ARE FLYING A JUMBO-JET TO A NEARBY AIRPORT."
  0003� PRINT "YOU HAVE FUEL FOR 10 MINUTES' FLIGHT,  ENOUGH"
    0003� PRINT "TIME TO MAKE 10 ADJUSTMENTS IN SPEED AND ALTITUDE."
    0004� PRINT "TO INCREASE ALTITUDE, TYPE A NUMBER FROM ONE TO"
  0004� PRINT "TWO THOUSAND; TO DESCEND, TYPE -1 TO -3000."
 0005� PRINT "TO MAINTAIN ALTITUDE (OR SPEED) TYPE ZERO. SPEED"
 0005� PRINT "CAN BE ADJUSTED FROM 1-200 MPH, ENTERING NEGATIVE"
0006� PRINT "VALUES TO SLOW DOWN.  REMEMBER THAT AFTER DECREASES"
   0006� PRINT "IN ALTITUDE, YOUR PLANE WILL CONTINUE TO DESCEND"
 0007� PRINT "SLIGHTLY DUE TO THE MOMENTUM OF THE DIVING PLANE."
0007� PRINT "ALSO, AFTER A DECREASE OF ALTITUDE, YOUR SPEED WILL"
   0008� PRINT "INCREASE.  WHILE CLIMBING, YOUR SPEED WILL DECREASE."
  0008� PRINT
  0008� A=B=C=D=E=X=0
    0008� RESTORE
0008� RESTORE
0008� READ A,B,C
  0009� DATA 550,10000,50
0009� PRINT "SPEED" TAB(15) "ALTITUDE" TAB (25) "DIST. TO RUNWAY"
   0009� PRINT "(MPH)" TAB (16) "(FEET)" TAB(28) "(MILES)"
   0009� X=X+1
  0010� PRINT "MINUTE" X "..."
0010� PRINT A;TAB(16);B;TAB(27);C
0011� IF X=11 THEN 275
 0011� PRINT "ALTITUDE ADJUSTMENT";
    0012� INPUT D
0012� IF D<0 THEN 155
  0014� IF D>2000 THEN 285
    0014� A=A-INT(D/20)
    0015� GOTO 170
    0015� IF D<-3000 THEN 295
   0016� B=B-INT(-D/30)
   0016� A=A-INT(D/20)
    0017� B=B+D
  0017� PRINT "SPEED ADJUSTMENT";
  0018� INPUT E
0018� A=A+E
  0018�C=C-A/60
0019� IF A<150 THEN 200
0019� GOTO 205
    0020� B=B-INT(2*(150-A))
    0020� IF B<=0 THEN 230
 0021� IF C<=-.5 THEN 305
    0021� IF A<=100 THEN 285
    0022� IF A>670 THEN 315
0022� GOTO 95
0023� IF C>0 THEN 325
  0023� IF C<-.25 THEN 335
    0024� IF D<-500 THEN 350
    0024� IF A>150 THEN 365
0025� PRINT "PERFECT LANDING!!!!!!!! ALL OF YOUR PASSENGERS ARE STILL ALIVE."
 0025� PRINT "WANT TO TRY AGAIN";
 0026� INPUT Z$
    0026� IF Z$="YES" THEN 82
   0027� GOTO 390
    0027� PRINT "YOU RAN OUT OF FUEL "C" MILES FROM THE RUNWAY...."
0028� GOTO 370
    0028� PRINT "YOUR PLANE STALLED AT "B" FEET..."
 0029� GOTO 370
    0029� PRINT "THE PLANE IS DIVING TOO STEEPLY....IT WON'T LEVEL OFF..."
   0030� GOTO 370
    0030� PRINT "YOU OVERSHOT THE RUNWAY.....YOUR LISCENSE IS REVOKED..."
    0031� GOTO 375
    0031� PRINT "HEY!! YOU'RE GOING "A" MPH..THAT VIOLATES NATURE'S LAWS!!!"
 0032� PRINT "IT'S NOT NICE TO FOOL MOTHER NATURE......"
   0032� GOTO 370
    0032� PRINT "YOU HAVE LANDED "C"MILES IN FRONT OF THE RUNWAY"
  0033� GOTO 370
    0033� PRINT "YOU HAVE LANDED PAST THE MIDDLE OF THE RUNWAY..."
 0034� PRINT "THIS IS A JUMBO-JET, NOT A HANG GLIDER.  1/4 MILE ISN'T LONG ENOUGH."
 0034� GOTO 370
    0035� PRINT "YOU LANDED TOO HARD... THE LANDING GEAR HAS BUCKLED...."
    0036� GOTO 370
    0036� PRINT "YOU HAVE LANDED AT "A" MPH, TOO FAST BY "A-150"MPH."
   0037� PRINT "C R A S H !  B O O M !  C R U N C H !  YOU BLEW IT."
   0037� PRINT "WANT TO LAND IT THIS TIME";
   0038� INPUT X$
    0038� IF X$="YES" THEN 82
   0039� END
