0001� REM		*****************************
   0002� REM		*  Written by: Brian Lilja  *
   0003� REM 		*        May 13 1977        *
  0004� REM		* Revised: February 13 1978 *
   0005� REM		*    Doherty High School    *
   0006� REM		*****************************
   0007� REM
    0008� REM        Simulates landing of a 747 by use 
  0009� REM          of flaps,  speed,  and rudder
0010� REM
    0011� REM
    0012� RANDOMIZE
   0013� A$(1)="left"
0014� A$(2)="right"
    0015� DEF FNC(W,X,Y,Z)=ABS(SGN((W-X)*(W-Y)*(W-Z)))
   0016� FILES BOEING.747%
0017� IF END:1 THEN 190
0018� READ:1,L,V,O,S
                            0019� PRINT"This game simulates the landing of a Boeing 747"
   0020� PRINT
  0021� PRINT"Do you need instructions";
0022� INPUT Z$
    0023� IF LEFT$(Z$,1)<>"Y" THEN 380
    0024� PRINT"This  game  is  easy  to play.  All you have to do is land a"
0025� PRINT"747.  You  are  to land the plane by adjusting flaps,  speed"
0026� PRINT"and  rudder.  Speed may be adjusted from 100 to 600 mph,  in"
0027� PRINT"increments  of  only  200 mph.  On your first turn you input"
0028� PRINT"your  starting  speed.  Flaps  and  rudder may  go up  to 60"
0029� PRINT"degrees  in either  direction,  but no more!  When  inputing"
       0030� PRINT"flaps and rudder input position, up and down for flaps, left"
0031� PRINT"and  right for rudder,  then the degree,  example:U47.  Note"
0032� PRINT"The  flaps  and  rudder  remain  at  their angle until reset"
0033� PRINT"Therefore to keep  flaps or rudder as before simply type '0'"
0034� PRINT"If you forget where your flaps or rudder is set type '0' for"
0035� PRINT"the  speed.  You must also  bring  down your landing gear by"
0036� PRINT"typing 'WD' for  the speed.  This  will  cause a slight drag"
0037� PRINT"so you may wish to retract them by typing 'WU'"
    0038� PRINT
                                     0039� PRINT"United flight";INT(RND*100)+100;"turn to";INT(RND*1000)/10+200;"degrees"
    0040� PRINT"Altitude: 10,000 feet	20 miles out"
 0041� PRINT
  0042� A=INT(RND*2)+1
   0043� B=INT(RND*10)+5
  0044� PRINT"You are";B;"degrees to the ";A$(A);" of the runway"
0045� IF INT(RND*3)+1<>2 THEN 510
0046� C=INT(RND*15)+5
  0047� D=INT(RND*2)+1
   0048� PRINT
  0049� PRINT"There is also a wind from";C/2;"to";C
    0050� PRINT"miles per hour coming from the ";A$(D)
   0051� N=1E4
  0052� Q=20
   0053� PRINT
  0054� PRINT"Speed";
    0055� INPUT B$
    0056� IF B$="WD" THEN 1950
  0057� IF B$="WU" THEN 2010
            0058� CHANGE B$ TO P
   0059� GOSUB 1810
  0060� IF E>600 THEN 540
0061� IF E>99 THEN 790
 0062� PRINT"Flaps:";TAB(8);
 0063� IF G<>0 THEN 660
 0064� PRINT G
0065� GOTO 700
    0066� IF C$="D" THEN 690
    0067� PRINT"Up";G;"degrees"
 0068� GOTO 700
    0069� PRINT"Down";G;"degrees"
    0070� PRINT"Rudder:";TAB(8);
0071� IF H<>0 THEN 740
 0072� PRINT H
0073� GOTO 530
    0074� IF D$="R" THEN 770
    0075� PRINT"Left";H;"degrees"
    0076� GOTO 530
    0077� PRINT"Right";H;"degrees"
   0078� GOTO 530
    0079� IF F=0 THEN 830
  0080� IF ABS(E-F)<=200 THEN 830
                                                    0081� PRINT"Speed difference too big  try again"
0082� GOTO 540
    0083� F=E-INT(W*(E/10))
0084� PRINT"Flaps";
    0085� IF G=0 THEN 870
  0086� PRINT" adjustment";
   0087� INPUT B$
    0088� E$=LEFT$(B$,1)
   0089� CHANGE B$ TO P
   0090� IF FNC(P(1),68,85,48)=1 THEN 840
0091� GOSUB 1810
  0092� IF G=0 THEN 970
  0093� IF E$<>C$ THEN 970
    0094� IF G+E>60 THEN 840
    0095� G=G+E
  0096� GOTO 1020
   0097� IF ABS(G-E)>60 THEN 840
    0098� G=G-E
  0099� IF G>0 THEN 1020
 0100� C$=E$
  0101� G=ABS(G)
    0102� PRINT"Rudder";
   0103� IF H=0 THEN 1050
 0104� PRINT" adjustment";
   0105� INPUT B$
         0106� E$=LEFT$(B$,1)
   0107� CHANGE B$ TO P
   0108� IF FNC(P(1),76,82,48)=1 THEN 1020
    0109� GOSUB 1810
  0110� IF H=0 THEN 1150
 0111� IF E$<>D$ THEN 1150
   0112� IF H+E>60 THEN 1020
   0113� H=H+E
  0114� GOTO 1200
   0115� IF ABS(H-E)>60 THEN 1020
   0116� H=H-E
  0117� IF H>0 THEN 1200
 0118� H=ABS(H)
    0119� D$=E$
  0120� IF A=1 THEN 1240
 0121� IF D$="R" THEN 1250
   0122� B=B-F*TAN(H*.0174533)/98.725
    0123� GOTO 1260
   0124� IF D$="R" THEN 1220
   0125� B=B+F*TAN(H*.0174533)/98.725
    0126� IF A=D THEN 1290
 0127� R=INT(C/2*(RND+1)/(1083/F)*100)/100
  0128� GOTO 1300
                       0129� R=-INT(C/2*(RND+1)/(1083/F)*100)/100
 0130� B=B+R
  0131� B=INT(B*10)/10
   0132� IF B>0 THEN 1350
 0133� A=3-A
  0134� B=ABS(B)
    0135� J=0
    0136� IF F>349 THEN 1380
    0137� J=-INT(EXP((350-F)/36.1912063))-1
    0138� IF G=0 THEN 1460
 0139� IF C$="D" THEN 1420
   0140� J=J-INT(F*TAN(G*.0213223255))
   0141� GOTO 1460
   0142� IF J=0 THEN 1450
 0143� J=J+INT((600-F)*TAN(G*.0174533)*1.154700538)
   0144� GOTO 1460
   0145� J=INT((F-325)*TAN(G*.0174533))+460
   0146� M=N
    0147� N=N+J
  0148� K=K-INT(F*5280/300)
   0149� IF K>=0 THEN 1530
0150� Q=Q-1
  0151� K=K+5280
    0152� GOTO 1490
        0153� IF Q<0 THEN 2070
 0154� IF Q>0 THEN 1560
 0155� IF K=0 THEN 2070
 0156� PRINT
  0157� IF N>0 THEN 1610
 0158� PRINT"You have landed";Q;"miles";K;"feet in front"
  0159� PRINT"of the runway, injuring";INT(RND*300)+50;"people"
  0160� GOTO 2190
   0161� ON SGN(J)+2 GOTO 1620,1650,1640
 0162� PRINT"You have fallen";-J;"feet"
0163� GOTO 1650
   0164� PRINT"You have risin";J;"feet"
  0165� IF R=0 THEN 1670
 0166� PRINT"You were blown";ABS(R);"degrees"
    0167� PRINT
  0168� PRINT"Altitude:";N;"feet"
  0169� PRINT"Distance out:";
 0170� IF Q=0 THEN 1730
 0171� PRINT Q;"miles";
 0172� IF K=0 THEN 1740
           0173� PRINT K;"feet";
  0174� PRINT
  0175� PRINT"Degrees off of runway:";
  0176� IF B<>0 THEN 1790
0177� PRINT" Zero"
0178� GOTO 530
    0179� PRINT B;"to the ";A$(A)
    0180� GOTO 530
    0181� U=0
    0182� FOR T=1 TO P(0)
  0183� IF P(T)=ASC(.) THEN 1850
   0184� IF(ASC(9)-P(T))*(P(T)-ASC(0))<0 THEN 1870
 0185� U=U+1
  0186� P(U)=P(T)
   0187� NEXT T
 0188� P(0)=U
 0189� CHANGE P TO B$
   0190� IF LEN(B$)>0 THEN 1930
0191� E=0
    0192� RETURN
 0193� E=VAL(B$)
   0194� RETURN
 0195� IF W=0 THEN 1980
 0196� PRINT"Your wheels are all ready down!!"
0197� GOTO 530
                                       0198� PRINT"Your wheels are now down"
 0199� W=1
    0200� GOTO 530
    0201� IF W=1 THEN 2040
 0202� PRINT"Your wheels are still up!!!"
   0203� GOTO 530
    0204� PRINT"Your wheels are up"
  0205� W=0
    0206� GOTO 530
    0207� PRINT
  0208� IF N<=0 THEN 2120
0209� PRINT"You have overshot the runway, you are still";N;"feet up"
0210� O=O+1
  0211� GOTO 2460
   0212� IF B=0 THEN 2150
 0213� PRINT"You have tried to land to the ";A$(A);" of the runway"
  0214� GOTO 2190
   0215� Y=1.5707963-ATN((F*.30717808)/(-J*.0174533))
   0216� Z=INT(((F*17.6)-(ABS(J)-M)/TAN(Y))*10)/10
 0217� IF Z>=0 THEN 2210
               0218� PRINT"You landed";-Z;"feet before the runway, you crashed!!"
    0219� V=V+1
  0220� GOTO 2460
   0221� IF W=1 THEN 2250
 0222� PRINT"You would have landed";Z;"feet down the runway"
    0223� PRINT"but you forgot to put down your landing gear"
 0224� GOTO 2190
   0225� IF Y<.174532925 THEN 2290
  0226� PRINT"You landed at an angle of";INT((Y/.0174533)*100)/100;"degrees"
    0227� PRINT"which caused your landing gear to buckle, you crashed!!"
0228� GOTO 2190
   0229� IF Z<3521 THEN 2340
   0230� PRINT"You have landed";Z-3520;"feet beyond the runway"
   0231� IF Z-3520<200 THEN 2190
                        0232� PRINT"landing in a housing district, whoops!!!"
   0233� GOTO 2190
   0234� PRINT"You have landed";Z;"feet down the runway"
0235� IF Z<1320 THEN 2380
   0236� PRINT"which was too many feet";
 0237� GOTO 2400
   0238� IF F<=170-Z/660*10 THEN 2430
    0239� PRINT"But you landed too fast";
 0240� PRINT" you can't stop in time"
  0241� S=S+1
  0242� GOTO 2460
   0243� PRINT
  0244� PRINT"Congradulations  you did it"
0245� L=L+1
  0246� SCRATCH:1
   0247� WRITE:1,L,V,O,S
  0248� PRINT"Do you wish to try again";
0249� INPUT Z$
    0250� IF LEFT$(Z$,1)<>"Y" THEN 2530
   0251� C=F=G=H=K=W=0
              0252� GOTO 380
    0253� PRINT TAB(22);"RECORD THUS FAR"
 0254� PRINT TAB(22);"====== ==== ==="
 0255� PRINT"Perfect landings:"TAB(28-LEN(STR$(L)));L
 0256� PRINT"Overshoting runway:";TAB(28-LEN(STR$(O)));O
   0257� PRINT"Crashes:";TAB(28-LEN(STR$(V)));V
    0258� PRINT"Not being able to stop:";TAB(28-LEN(STR$(S)));S
    0259� PRINT"------------------------------"
0260� PRINT"Total:";TAB(28-LEN(STR$(L+V+O+S)));L+V+S+O
    0261� END
