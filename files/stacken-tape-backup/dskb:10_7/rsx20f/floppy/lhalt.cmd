SET CON MAI
!	PLEASE NOTE .... CONSOLE IS COLLECTING KL STATUS THIS
!	PROCESS WILL TAKE ABOUT 2 MINUTES .....>  PLEASE WAIT
SET OUT LOG
W VER!			 HALT.CMD V 16.00 	17 March 88
CLEAR OUT TTY
WHAT HARDWARE
E DTE
DE ELE 174432=100
QSAV 0=0
XCT 757640 0;E 0
XCT 756640 0;E 0
XCT 757600 400000
XCT 756600 400000
XCT 757640 0;E 0
XCT 756640 0;E 0
REP 10;E CRL
SET OUTPUT TTY
FREAD 100:112
!			Part A Done
CLEAR OUTPUT TTY
FREAD 100:177
SAVE PC
E REG
SET OUTPUT TTY
E KL;E VMA;E VMAH
!			Part B Done
CLEAR OUTPUT TTY
SAVE AC-BLOCK
WHAT AC
FX 1
E 0:17
SET OUTPUT TTY
!			Part C Done
CLEAR OUTPUT TTY
QSAV 1=1;QSAV 2=2;QSAV 3=3
XCT 700400 0;E 0!	ERA
XCT 701040 1;E 1!	DATAI PAG
XCT 701240 2;E 2!	CONI PAG
XCT 700240 3;E 3!	CONI APR
XCT 700000 3;E 3!	BLKI APR (APRID)
!			UUO AND PAGE FAIL DATA
E UBR 424! 		FLAGS,,MUUO,A 
E UBR 425!		PC of MUUO
E UBR 426!		E FIELD OF MUUO
E UBR 427!		PROCESS CONTEXT WORD
E UBR 430!		NEW MUUO PC
E UBR 500!		PAGE FAIL WORD
E UBR 501!		Flags
E UBR 502!		PC of Page Fail
E UBR 503!		New PC
!
!CONI OF ALL RH20 SLOTS
XCT 754240 0;XCT 754640 1;XCT 755240 2;XCT 755640 3
E 0:3!			RH CONI FOR 0 ->3
XCT 756240 0;XCT 756640 1;XCT 757240 2;XCT 757640 3
E 0:3!			RH CONI FOR 4 ->7
SET OUTPUT TTY
!			Part D Done
CLEAR OUTPUT TTY
XCT 701240 3
XCT 701240 2;E 2!	CONI PAG
XCT 405100 717777!	ANDI to strip out Paging bits
!			to make E EBR xxx correct
XCT 701240 2!		CONI PAG
!			CHANNEL LOGOUT DATA
E EBR 00;E EBR 01;E EBR 02;E EBR 03
E EBR 04;E EBR 05;E EBR 06;E EBR 07
E EBR 10;E EBR 11;E EBR 12;E EBR 13
E EBR 14;E EBR 15;E EBR 16;E EBR 17
E EBR 20;E EBR 21;E EBR 22;E EBR 23
E EBR 24;E EBR 25;E EBR 26;E EBR 27
E EBR 30;E EBR 31;E EBR 32;E EBR 33
E EBR 34;E EBR 35;E EBR 36;E EBR 37
E EBR 142;E EBR 152;E EBR 162;E EBR 172
!
!	SBUS DIAGS (CAN BE MADE SITE SPECIFIC)
!
SET OUTPUT TTY
!			Part E Done
CLEAR OUTPUT TTY
!			FOR DMA-20
DE 0=100000 0
XCT 700500 0;E 1
!
!			FOR MOS
DE 00=200000 0;DE 02=200000 1
XCT 700500 0;XCT 700500 2
E 1;E 3!			DIAG'S 0 AND 1	CONT 10
DE 00=200000 2;DE 02=200000 10
XCT 700500 0;XCT 700500 2
E 1;E 3!			DIAG'S 2 AND 10	CONT 10
DE 00=220000 0;DE 02=220000 1
XCT 700500 0;XCT 700500 2
E 1;E 3!			DIAG'S 0 AND 1	CONT 11
DE 00=220000 2;DE 02=220000 10
XCT 700500 0;XCT 700500 2
E 1;E 3!			DIAG'S 2 AND 10	CONT 11
XCT 701200 3!		Replace Original EBR
QRES 0=0;QRES 1=1;QRES 2=2;QRES 3=3
!			GET OTHER AC'S
RESET
ST MIC
SET OUTPUT TTY
!			Part F Done
CLEAR OUTPUT TTY
SET AC-BLOCK 6
E 0:17
SET AC-BLOCK 7
E 0:3
SET AC-BLOCK 0
E 0:17
SET OUT TTY
CLE OUT LOG
!
!			Halt SnapShot Done
