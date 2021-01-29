;
;Command file to build RSX-20F floppy 3
;
DX0:[5,5]= DB0:[5,5]RSX20F.SYS;0/CO
DX0:[5,5]= DB0:[5,5]RSX20F.MAP;0
DX0:[5,5]= DB0:[5,5]ZAP.TSK;0/CO
DX0:[5,5]= DB0:[5,5]BLDFE1.CMD;0
DX0:[5,5]= DB0:[5,5]BLDFE2.CMD;0
;
;Now get a directory
;
DX0:[5,5]/LI
