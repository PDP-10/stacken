;Sample SYS:SYSTEM.CMD file.   You may add, change, or remove lines in this
;file as needed to support your system configuration.
SET PRINTER 0 PAGE-LIMIT 2000
SET BATCH-STREAM 0 TIME-LIMIT 0:10	;TIME: 0 TO 10 MINUTES
SET BATCH-STREAM 1 TIME-LIMIT 0:60	;TIME: 0 TO 1 HOUR
SET BATCH-STREAM 2 TIME-LIMIT 10:100000	; FOR LONG STREAMS
START BATCH-STREAM 0:2
START PRINTER 0
;**********************************************************************
;Uncomment the four lines below if you have either a card punch or a card reader
;SET CARD-PUNCH 0 OUTPUT-LIMIT 1000
;SET CARD-PUNCH 0 LIMIT-EXCEEDED-ACTION IGNORE
;START CARD-PUNCH 0
;START READER 0
;**********************************************************************
DISABLE OUTPUT-DISPLAY ALL-MESSAGES /JOB
ENABLE VOLUME-RECOGNITION TAPE-DRIVES
