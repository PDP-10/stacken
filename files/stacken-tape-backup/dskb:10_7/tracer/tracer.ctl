0010�	; Job %1(1) to build TRACER.*, SNUP.*, TRDUMP.*
0020�	; JCH 3-Mar-80
   0030�	
  0040�	; Required files:
0050�	;
 0060�	; SYS:	MACRO.EXE
 0070�	;	FORTRA.EXE and relatives and sons and daughters
   0080�	;	LINK.EXE and relatives
   0090�	;
 0100�	; UNV:	UUOSYM.UNV,MACTEN.UNV
    0110�	;
 0120�	; [-]:	TRACER.MAC,SNUP.MAC,TRDUMP.FOR
0130�	
  0140�	.COMPILE SNUP
    0150�	.IF (ERROR) .GOTO TRYTD::	; Can't to TRACER without SNUP
 0160�	.LOAD TRACER
0165�	.SAVE TRACER
0170�	.IF (ERROR)
 0180�	TRYTD::
0190�	.LOAD TRDUMP
0200�	.SAVE TRDUMP
