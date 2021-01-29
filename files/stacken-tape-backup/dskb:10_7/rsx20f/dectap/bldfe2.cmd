;
; Build console front end DECtape 3
;
DT0:[5,5]= DB0:[5,5]RSX20F.SYS;0/CO
DT0:[5,5]= DB0:[5,5]RSX20F.MAP;0
DT0:[5,5]= DB0:[5,5]ZAP.TSK;0/CO
DT0:[5,5]= DB0:[5,5]BLDFE1.CMD;0
DT0:[5,5]= DB0:[5,5]BLDFE2.CMD;0
;
;Now get a directory
DT0:[5,5]/LI
