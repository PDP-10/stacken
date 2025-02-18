100 REM - TAG: A SURVEY OF BASS POPULATION IN A SIMULATED FARM 
105 REM POND USING TAGGING AND RECOVERY. 
110 REM COPYRIGHT 1972,1973 -STATE UNIVERSITY OF NEW YORK  
115 REM MODEL AND PROGRAM DESIGN: J. FRIEDLAND 
120 REM LATEST REVISION: 7/20/73
125 REM P=POP. OF BASS;P1=POP. OF TAGGED BASS  
130 REM R=RADIUS OF POND;R1=RADIUS OF SAMPLE SITE  
135 REM A=AREA OF POND;T=DAY NUMBER  
140 REM D=DIFFUSION FACTOR;C=CHANCE OF TAGGED BASS SURVIVAL/DAY
145 REM C1=CHANCE OF CATCHING A TAGGED BASS VS. AN UNTAGGED BASS 
150 PRINT"DO YOU REQUIRE INSTRUCTIONS (1=YES, 0=NO)";
155 INPUTQ 
160 IFQ=0THEN210
165 IFQ<>1THEN155
170 PRINT
175 PRINT
180 PRINT"     THE OBJECT IS TO DETERMINE THE NUMBER OF BASS"  
185 PRINT"IN THE POND SHOWN IN YOUR LAB GUIDE. THE TECHNIQUE"
190 PRINT"CALLS ON YOU TO INTRODUCE TAGGED FISH INTO THE POND" 
195 PRINT"AND, AT SOME LATER DATE, SAMPLE THE POND'S FISH"
200 PRINT"TO DETERMINE THE PERCENTAGE OF FISH THAT ARE TAGGED." 
205 PRINT"     YOU ARE ALLOWED ONLY 20 SAMPLES, SO CHOOSE CAREFULLY."
210 PRINT
215 DIMN(20),M(20) 
220 LETZ=0
225 READP,R,E,D,C
230 DATA424,75,0,500,.998
235 RANDOMIZE
240 LETA=3.14*R^2
245 PRINT"HOW MANY TAGGED BASS DO YOU WANT FROM THE HATCHERY"; 
250 INPUTP1
255 IFP1<=400THEN270
260 PRINT"SORRY, MAXIMUM NUMBER OF FISH AVAILABLE IS 400"
265 GOTO245
270 PRINT
275 PRINT"HOW MANY DAYS, AFTER RELEASE OF THE BASS"
280 PRINT"FROM THE CENTER OF THE POND, DO YOU WANT TO SAMPLE";
285 INPUTT 
290 IFT>ETHEN310
295 PRINT
300 PRINT"DAY ";T;" HAS PASSED"
305 GOTO275
310 PRINT
315 LETP3=C^T*P1 
320 LETZ9=EXP(-(R^2/(D*T)))*P3/A 
325 PRINT"AT WHAT SITE DO YOU WANT TO SAMPLE FIRST"; 
330 IFE<>0THEN350
335 PRINT
340 PRINT"(REFER TO MAP IN STUDENT MANUAL FOR X AND Y COORDINATES." 
345 PRINT"ENTER AS X,Y)";
350 INPUTX,Y 
355 LETR1=SQR(X^2+Y^2) 
360 IFR1>.1THEN370
365 LETR1=.1 
370 IFR1<=RTHEN390
375 PRINT
380 PRINT"SAMPLE SITE BEYOND SHORES OF POND" 
385 GOTO340
390 LETS=EXP(-(R1-2.5)^2/(D*T))-EXP(-(R1+2.5)^2/(D*T)) 
395 LETS=(S*P3)/(3.14*((R1+2.5)^2-(R1-2.5)^2))+Z9
400 LETC1=S/(S+P/A)
405 IFC1>1E-19THEN415
410 LETC1=0
415 LETZ=Z+1 
420 IFZ=21THEN585
425 PRINT"HOW MANY FISH";
430 INPUTN(Z)
435 LETN(Z)=INT(N(Z))
440 IFN(Z)<=400THEN455
445 LETN(Z)=INT(200*RND(0)+200)
450 PRINT"IT WAS POSSIBLE TO CATCH ONLY ";N(Z);" FISH."
455 LETB=COS(6.283*RND(0))*SQR(-2*LOG(RND(0))) 
460 LETM(Z)=INT(C1*N(Z)+B*SQR((C1-C1^2)*N(Z))+.5)
465 IFM(Z)*(N(Z)-M(Z))<0THEN455
470 PRINT" SAMPLE: ";Z 
475 PRINT"STATION: ";X;",";Y;"    DAY: ";T 
480 PRINT" TAGGED: ";M(Z);"   UNTAGGED: ";N(Z)-M(Z)
485 PRINT
490 PRINT
495 PRINT"ANOTHER SAMPLE ON DAY ";T; 
500 IFZ>1THEN510
505 PRINT" (1=YES, 0=NO)"; 
510 INPUTQ 
515 PRINT
520 IFQ<>1THEN535
525 PRINT"SITE COORDINATES"; 
530 GOTO350
535 IFQ<>0THEN505
540 PRINT"DO YOU WANT TO SAMPLE ON ANOTHER DAY"; 
545 IFE<>0THEN555
550 PRINT" (1=YES, 0=NO)"; 
555 INPUTQ 
560 IFQ=0THEN590
565 IFQ<>1THEN550
570 PRINT"WHAT DAY NUMBER";
575 LETE=T 
580 GOTO285
585 PRINT"YOU MAY TAKE A MAXIMUM OF 20 SAMPLES"
590 PRINT
595 PRINT
600 PRINT"IF YOU HAVE SELECTED YOUR SAMPLES CAREFULLY" 
605 PRINT"YOU SHOULD BE ABLE TO DETERMINE THE TOTAL" 
610 PRINT"BASS POPULATION OF THE POND."
615 PRINT
620 PRINT"  YOU CAN USE THE FORMULA:"
625 PRINT"              (TOTAL TAGGED FISH IN POND) X (SAMPLE SIZE)" 
630 PRINT"  TOTAL POP.= ------------------------------------------"
635 PRINT"                (NUMBER OF TAGGED FISH RECOVERED AT SITE)" 
640 PRINT
645 PRINT"DO YOU WISH TO DO THE CALCULATIONS YOURSELF(1=YES, 0=NO)"; 
650 INPUTQ 
655 IFQ<>0THEN760
660 PRINT
665 PRINT"WHICH SAMPLE DO YOU WISH TO EVALUATE FIRST"; 
670 PRINT" (SAMPLE NUMBER)";
675 INPUTQ 
680 IFQ>ZTHEN670
685 LETQ=INT(Q)
690 PRINT
695 PRINT"          ";P1;"  X  ";N(Q)
700 LETW=0 
705 IFM(Q)=0THEN715
710 LETW=INT(P1*N(Q)/M(Q)) 
715 PRINT"          ---------------- = ";W 
720 PRINT"               ";M(Q)
725 PRINT
730 PRINT
735 PRINT"ANOTHER CALCULATION (1=YES,0=NO)"; 
740 INPUTQ 
745 PRINT
750 IFQ=1THEN670
755 IFQ<>0THEN735
760 PRINT
765 PRINT"ENTER YOUR ESTIMATE OF THE UNTAGGED BASS POPULATION";
770 INPUTQ 
775 PRINT
780 IFABS((Q-P)/P)>.1THEN795
785 PRINT"YOUR ESTIMATE IS GOOD.  CONGRATULATIONS." 
790 STOP 
795 IFABS(P-Q)/P<=.25THEN820
800 PRINT"YOUR ESTIMATE IS NOT WITHIN 25 PERCENT"
805 PRINT"OF THE ACTUAL POPULATION."
810 PRINT"EXAMINE YOUR SAMPLING STATEGY AND TRY AGAIN." 
815 STOP
820 PRINT"YOUR ESTIMATE IS CLOSE, BUT NOT WITHIN 10 PERCENT"
825 GOTO805
830 END

*U*2!B$$BB$$BB$$BL