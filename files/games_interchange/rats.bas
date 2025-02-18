0010� REM RATS - A RAT POPULATION SIMULATION
    0010� REM DEVELOPED BY A. FRISHMAN, PROGRAMMED BY M. WEISNER
   0011� REM COPYRIGHT 1973, STATE UNIVERSITY OF NEW YORK
    0011� REM LATEST REVISION: 12-12-73
   0012� RANDOMIZE
   0012� DIMD(6),M(6),P(6)
0013� READC9,X,D1,I2,M8,D8,B2,T1,D9,T,D,J,S
0013� FORI=1TO6
   0014� READD(I)
    0014� NEXTI
  0015� PRINTTAB(12);"RATTUS NORVEGICUS POPULATION SIMULATION"
   0015� PRINT
  0016� PRINT
  0016� PRINT"WHICH ENVIRONMENT IS THE SIMULATION TO"
  0017� PRINT"BE CONDUCTED IN (1=APT HOUSE, 2=CITY)";
  0017� INPUTE
 0018� LETF=60
0018� IFE=1THEN205
0019� IFE<>2THEN165
    0019� LETF=F*5E3
  0020� PRINT
  0020� PRINT
  0021� PRINT"DO YOU WISH (1=YES, 0=NO) :"
   0021� PRINT
  0022� PRINTTAB(8);"AUTOMATIC INITIALIZATION OF POPULATION";
    0022� INPUTI
 0023� IFI=1THEN280
0023� IFI<>0THEN220
    0024� PRINTTAB(8);"HOW MANY RATS ARE PRESENT";
  0024� INPUTP9
0025� IFINT(P9)<>P9THEN240
  0025� IFP9<0THEN240
    0026� PRINT
  0026� IFP9<=11.2*F/3THEN280
 0027� PRINT"CHOOSE A SMALLER NUMBER OR AUTOMATIC INITIALIZATION."
   0027� GOTO220
0028� GOSUB355
    0028� IFI=0THEN305
0029� LETP9=S*F/3
 0029� PRINT"BASED ON A GARBAGE LEVEL OF";S;"IN ENVIRONMENT";E
  0030� PRINT"THE RAT POPULATION INITIALLY IS";P9
 0030� PRINT
  0031� GOSUB470
    0031� GOSUB560
    0032� FORI=1TO5
   0032� LETP(I)=INT(P9/6)
0033� LETP8=P8+P(I)
    0033� NEXTI
  0034� LETP(6)=P9-P8
    0034� LETP8=0
0035� GOTO1505
    0035� PRINT
  0036� PRINTTAB(8);"DAILY POPULATION STATUS";
    0036� INPUTC2
0037� IFC2*(C2-1)<>0THEN355
 0037� PRINT
  0038� PRINT"MONTH, DAY FOR REPORT";
   0038� INPUTC,C1
   0039� IFC<JTHEN380
0039� IFC>JTHEN410
0040� IFC*C1=1THEN410
  0040� IFC1<=DTHEN380
   0041� IFINT(C)<>CTHEN380
    0041� IFABS(C1-15)>15THEN380
0042� IFINT(C1)<>C1THEN380
  0042� PRINT
  0043� LETS1=S
0043� PRINT"GARBAGE LEVEL UNTIL";C;"/";C1;
 0044� INPUTS
 0044� IFABS(S-5)>5THEN435
   0045� IFINT(S)<>STHEN435
    0045� IFS1=STHEN465
    0046� LETS2=7
0046� RETURN
 0047� PRINT"TYPE OF POISON (0=NONE,1=QUICK KILL,2=SLOW KILL)";
 0047� INPUTP
 0048� LETI=0
 0048� LETQ9=0
0049� IFP=0THEN540
0049� IFP=1THEN505
0050� IFP<>2THEN470
    0050� PRINT"QUANTITY OF #";P;"POISON (LBS)";
    0051� INPUTQ9
0051� IFQ9+I<=112*F/3THEN530
0052� PRINT"YOU ARE BURIED IN POISON.......NOT VERY PRACTICAL."
0052� GOTO505
0053� IFQ9<0THEN505
    0053� LETC9=C9+.44*Q9
  0054� RESTORE
0054� PRINT
  0055� READM7,I1,B1,P8
  0055� RETURN
 0056� IFC2=0THEN580
    0056� PRINT
  0057� PRINT"DAY","RATS"
0057� PRINT"---","----"
0058� RETURN
 0058� REM DAILY UPDATE
 0059� LETM9=0
0059� LETD1=D1+.028*P9
 0060� IFP9>0THEN615
    0060� LETT=180
    0061� LETT1=0
0061� LETM1=1
0062� IFD=1THEN630
0062� IF.3*P(6)>=M6THEN635
  0063� LETM6=INT(P(6)/(31-D)+.75)
 0063� LETM(6)=M6
  0064� LETE=INT(P9-Q9-S*F/3)
 0064� IFE>0THEN665
0065� LETE9=0
0065� GOTO705
0066� REM EXCESS POP
   0066� LETD9=1-D9
  0067� IFD9<>1THEN690
   0067� LETE9=INT(E/4)
   0068� IFE9>2THEN690
    0068� LETE9=2
0069� LETM9=2*(E9-INT((M(1)+M(2)+M(3)+M(4)+M(5)+M(6))/2))
 0069� IFM9>=0THEN705
   0070� LETM9=0
0070� IFP=0THEN890
0071� REM POISON
  0071� IFQ9=0THEN895
    0072� LETK=Q9*10/((F*S)/16+Q9*10)
0072� IFP=2THEN820
0073� REM Q-K POISON
   0073� LETW=0
 0074� IFT<=30THEN760
   0074� LETW=.1*T/30
0075� IFW<=.6THEN760
   0075� LETW=.6
0076� LETW=W*K
    0076� LETT=0
 0077� LETU=6
 0077� FORI=1TOU
   0078� LETM(I)=M(I)+INT(W*P(I)+.5)
0078� IFM(I)<=P(I)THEN795
   0079� LETM(I)=P(I)
0079� NEXTI
  0080� LETQ9=Q9-W*P9*3/16
    0080� IFQ9>0THEN895
    0081� LETQ9=0
0081� GOTO895
0082� REM S-K POISON
   0082� IFT1<>0THEN850
   0083� LETR1=INT(10*RND(R1)-3)
    0083� IFABS(R1-2)>2THEN830
  0084� LETR1=R1+3
  0084� LETU=0
 0085� LETW=K
 0085� LETT1=T1+1
  0086� IFT1<R1THEN800
   0086� LETR1=R1+1
  0087� LETU=U+2
    0087� IFU<>8THEN775
    0088� LETU=6
 0088� GOTO775
0089� LETE9=0
0089� REM BIRTH
   0090� IFP9-P(1)<>0THEN910
   0090� LETM(1)=P(1)
0091� FORI=1TO6
   0091� LETP8=P8+M(I)
    0092� NEXTI
  0092� LETP7=INT((P(4)+P(5)+P(6))/2+.5)
0093� LETI=S-P9/(F/3)
  0093� IFABS(I)<=3THEN945
    0094� LETI=SGN(I)*3
    0094� LETB=INT(P7*(I+3)*11/90+.5)
0095� LETB1=B1+B
  0095� LETP(1)=P(1)+B
   0096� REM DEATH
   0096� LETB=M9
0097� FORI=1TO6
   0097� LETZ=INT(D(I)*P(I)+.5)
0098� IFZ>=1THEN990
    0098� LETZ=1
 0099� IFM9>ZTHEN1000
   0099� LETZ=M9
0100� LETM9=M9-Z
  0100� IFP(I)-Z-M(I)>=0THEN1035
   0101� IFI<>6THEN1020
   0101� LETM9=M9-M6
 0102� LETM9=M9+Z+M(I)-P(I)
  0102� LETP(I)=0
   0103� GOTO1040
    0103� LETP(I)=P(I)-M(I)-Z
   0104� NEXTI
  0104� IFM1<>1THEN1065
  0105� FORI=1TO6
   0105� LETM(I)=0
   0106� NEXTI
  0106� LETP9=P(1)+P(2)+P(3)+P(4)+P(5)+P(6)
  0107� LETM1=0
0107� IFP9=0THEN1085
   0108� IFM9<>0THEN970
   0108� LETM7=M7+INT((B-M9)/2+.5)
  0109� LETP8=P8+INT((B-M9)/2)
0109� REM IMMIGRATION
  0110� IFS=0THEN1220
    0110� IFS2/7<>INT(S2/7)THEN1145
  0111� LETM=INT((S*22.4-P9)/20+.5)
0111� IFF=60THEN1150
   0112� LETM=INT(S*6E4+.5-P9)
 0112� LETS3=S-2
   0113� IFS3>0THEN1140
   0113� LETS3=1
0114� IFM<=S3*6E4THEN1150
   0114� LETM=S3*6E4
 0115� IFM>=0THEN1160
   0115� LETM=0
 0116� IFE>=0THEN1220
   0116� IFM=0THEN1220
    0117� LETM1=INT(RND(M1)*M+.5)
    0117� IFF=60THEN1185
   0118� IFM1>INT(M*.005+.5)THEN1170
0118� IFM-M1<0THEN1170
 0119� LETR=INT(10*RND(R)+.5)
0119� IFABS(R-1.5)>1.5THEN1190
   0120� LETM=M-M1
   0120� LETI1=I1+M1
 0121� LETP(3+R)=P(3+R)+M1
   0121� LETP9=P9+M1
 0122� LETS2=S2+1
  0122� IFC2=0THEN1235
   0123� PRINTD,P9
   0123� IFC1<>DTHEN1460
  0124� IFC<>JTHEN1460
   0124� PRINT
  0125� PRINT"REPORT ON";J;"/";D":"
0125� PRINT"TOTAL POPULATION=";P9
0126� IFP9=0THEN1305
   0126� FORI=1TO6
   0127� LETQ=Q+1
    0127� IF(I-1)/3<>INT((I-1)/3)THEN1290
 0128� PRINT
  0128� LETQ=0
 0129� PRINTTAB(Q*20);"P(";I;")=";P(I);
0129� NEXTI
  0130� PRINT
  0130� GOSUB1535
   0131� PRINT
  0131� PRINT"DO YOU WISH TO CONTINUE THIS RUN";
  0132� INPUTI
 0132� IFI=0THEN1590
    0133� IFI<>1THEN1315
   0133� GOSUB355
    0134� PRINT
  0134� IFP=0THEN1360
    0135� LETQ9=INT(Q9*100+.5)/100
   0135� PRINT"CURRENT POISON TYPE:";P;"    QUANTITY LEFT=";Q9
    0136� PRINT"TYPE OF POISON (0=NONE,1=QK,2=SK";
  0136� IFP*Q9=0THEN1375
 0137� PRINT",3=LEAVE CURRENT POISON";
 0137� PRINT")";
   0138� INPUTI
 0138� IFI*(I-1)*(I-2)*(I-3)<>0THEN1360
0139� IFI=3THEN1445
    0139� IFP=ITHEN1420
    0140� IFI*P*Q9=0THEN1415
    0140� PRINT"POISON TYPE";P;"WILL BE REMOVED WHEN NEW POISON IS PUT OUT"
  0141� LETT1=0
0141� LETQ9=0
0142� LETP=I
 0142� LETI=Q9
0143� GOSUB490
    0143� LETQ9=Q9+I
  0144� GOTO1455
    0144� IFP*Q9=0THEN1360
 0145� GOSUB540
    0145� GOSUB560
    0146� LETD=D+1
    0146� LETT=T+1
    0147� IFD<=30THEN585
   0147� LETP8=P8+P(6)
    0148� FORI=6TO2STEP-1
  0148� LETP(I)=P(I-1)
   0149� NEXTI
  0149� LETP(1)=0
   0150� LETJ=J+1
    0150� LETD=1
 0151� PRINT
  0151� PRINTTAB(12);"***** MONTH";J;"*****"
 0152� PRINTTAB(12);"TOTAL POP.=";P9
   0152� PRINT
  0153� GOTO585
0153� PRINT
  0154� PRINT"BIRTHS=";B1;TAB(30);"DEATHS=";P8
    0154� PRINT"EMIGRATION=";M7;TAB(30);"IMMIGRATION=";I1
0155� LETX=X+1
    0155� LETM8=M8+M7
 0156� LETI2=I2+I1
 0156� LETB2=B2+B1
 0157� LETD8=D8+P8
 0157� RETURN
 0158� DATA0,0,0,0,0,0,0,0,0,180,1,1,0
 0158� DATA.8,.5,.4,.1,.05,.025
   0159� PRINT
  0159� PRINT
  0160� PRINT"FOR THIS RUN:"
  0160� IFX=1THEN1635
    0161� LETM7=M8
    0161� LETP8=D8
    0162� LETI1=I2
    0162� LETB1=B2
    0163� GOSUB1535
   0163� IFP=0THEN1650
    0164� LETQ9=INT(100*Q9+.5)/100
   0164� PRINTTAB(8);"QUANTITY OF UNUSED POISON TYPE";P;"IS";Q9
   0165� IFC9=0THEN1660
   0165� PRINTTAB(8);"COST OF POISON IS";INT(C9*100+.5)/100;"DOLLARS"
  0166� PRINTTAB(7);INT(D1*100+.5)/100;"DOLLARS OF DAMAGE DUE TO RATS"
0166� PRINTTAB(8);"PRODUCING A CONTAMINATION LEVEL OF";
   0167� LETC=0
 0167� IFD1=0THEN1695
   0168� LETC=INT(1.5+(D1/.028)/(J*30+D)/(F/3))
    0168� IFC<11THEN1695
   0169� LETC=10
0169� PRINTC
 0170� END
