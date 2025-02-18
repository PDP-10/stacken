10 REM     THIS PROGRAM COMPUTES PR(A<=X<=B),WHERE X IS THE NO.
20 REM  OF SUCCESSES IN N TRIALS WITH PROBABILITY P OF
30 REM  SUCCESS IN EACH TRIAL, USING THE NORMAL APPROX. USER 
40 REM  SUPPLIES AS DATA IN LINE 900 AND FOLLOWING N, P, A, B.
100 READ N,P,H,K
102 LET M=N*P
104 LET S=SQR(M*(1-P))
115 PRINT "N="N,"P="P,
120 LET A=(H-.5-M)/S
130 LET B=(K+.5-M)/S
135 LET C=1/SQR(2)
140 LET A1=.14112821
150 LET A2=.08864027
160 LET A3=.02743349
170 LET A4=-.00039446
180 LET A5=.00328975
190  DEF FNO(X)=1-1/(1+A1*X+A2*X^2+A3*X^3+A4*X^4+A5*X^5)^8
200 IF A<0 THEN 220
210 LET F=.5+.5*FNO(A*C)
215 GO TO 230
220 LET F=.5-.5*FNO(-A*C)
230 IF B<0 THEN 250
240 LET G=.5+.5*FNO(B*C)
245 GO TO 260
250 LET G=.5-.5*FNO(-B*C)
260 LET L=1E-4*INT(1E4*(G-F)+.5)
265 PRINT "PR( "H"<= X <= "K")="L
270 GO TO 100
900 DATA 1000,.5,0,520
999 END
                                                                                                                                                                                                                                                                                                                                                                                                                                 