	Program GETNODES


C	GETNODES.FOR -- Generate NCP commands for TOPS-10
C	  7 Sep 84 /RLC
C
C	This program will read the VAX DECnet permanent database,
C	extract node records containing node numbers and names, 
C	and create NCP commands of the form  SET NODE n NAME foo.
C
C	The output file is suitable for processing by DECnet-36's
C	NCP, or by the DECnet-36 tool NODNAM.

C	Revision History
C	 7-Sep-84 1.0	RLC	Creation.
C	11-Sep-84 1.1	TL	Cosmetic edits, comments, and performance.
C	13-Sep-84 1.2	TL	Support Decnet version 4 file format

	Character*10 version
	data version/'1.2'/


	Integer l,nod_area,nod_number,nod_start,nod_finish,ptr,tmp,rec_num,
	1 errs,packets,param_type,byte_count,ptr2,DECnet_version
	Integer two_bytes
	Integer nod_chrs(256)
	Character nod_str*256, old_nod_nam*6
	Real area_node
	Logical val_found
	Common /string/nod_chrs

C
C	Define us a function for getting 16-bit quantities:
C
	TWO_BYTES(i) = nod_chrs(i) + 256 * nod_chrs(i+1)

	Type 50, Version
50	Format(1x,'Getnodes Version ',A10,/)

	Type 55
55	Format(1x,'DECnet version (3 or 4): ',$)
	Accept 60, DECnet_version
60	Format (I)
	If(DECnet_version .eq. 3 .or. DECnet_version .eq. 4) goto 70
	type 65
65	Format (1x,'?Unknown version')
	call exit

70	Open (unit=20,file='SYS$SYSTEM:NETNODE.DAT', organization='INDEXED',
	1 access='SEQUENTIAL',iostat=io,err=9000,status='OLD',
	2 blank='ZERO')

	Open (unit=21,file='NODNAM.INI',carriagecontrol='LIST',
	1 status='NEW')

	Type 80
80	Format(/)

	rec_num = 0
	errs = 0
	old_nod_nam = '      '

100	Read(20,110,end=1000,err=9100)l,nod_str
110	Format(Q,A256)

	rec_num = rec_num + 1
	packets = 0

C	Copy character data as unsigned bytes to integers

	Do 150 i = l,1,-1
150	nod_chrs(i) = ICHAR(nod_str(i: i))

C	Skip the RMS keys.  Different for different DECnet versions.

	ptr = 2 + 1
	If(DECnet_version .eq. 4) ptr = 10 + 1

C	Type 160,l,(nod_chrs(i),i=1,l)
C160	Format(' Len:',I3,130(' ',12O4,/))

C	Now, loop over the input record.  Format is a series of
C	packets, each contains Param_type (decimal network management
C	parameter type code), Byte_count (number of bytes in value), 
C	and the value.  Numbers are all in DECnet format - low byte
C	first.  Numbers that are values are an arbitrary number of
C	bytes long.  Param_types and Byte_counts are 2 bytes long.
C	ASCII is simple counted ASCII, low byte is left end of string.

C	First, make sure that there is at least a type and a byte
C	count left in the record.  If not, quit.

200	If(Ptr + 2 + 2 .gt. l) Goto 650

C	If we now have 2 packets, no need to look at rest.
C	(This assumes that each only appears at most once.)

	If(packets .eq. 2) Goto 700


C	Extract paramater type and byte count of value

	param_type = TWO_BYTES(ptr)
	ptr = ptr + 2
	byte_count = TWO_BYTES(ptr)

C	Check for node name

	If(param_type .eq. 500) Goto 400


C	Check for node address (number)

	If(param_type .eq. 502) Goto 500

C	Not interesting, Skip past this packet, continue with record.

	ptr = ptr + 2 + byte_count
	Goto 200


C
C	Here if packet 500 (node name)
C
400	nod_name_size = byte_count
	If(nod_name_size .eq. 0) Goto 9400
	nod_start = ptr + 2
	nod_finish = ptr + 1 + byte_count

C	Store node name, update ptr, check for eo$;

	Goto 600

C
C	Here if packet 502 (node number)
C
500	Call Get_Value(ptr,val_found,i)
	If(.not. val_found) Goto 9500

C	Node number is 6 bit area number + 10 bit node number

	nod_area = i / 1024
	nod_number = i  .AND. 1023

C	This gives the number of digits in the node number

	nod_num_size = ALOG10(FLOAT(nod_number)) + 1.0

C	Store node number & area, update ptr, check for eo$;

	Goto 600

C	Check eo$ here;

C	First, we skip the value field of the last packet

600	ptr = ptr + 2 + byte_count

C	Keep track of how many we've found
C	If we don't have both yet, go look some more

	packets = packets + 1
	If(packets .lt. 2) Goto 200

C	Here when the end of record is reached, or both found

C	Complain if we don't have the data we want

650	If(packets .lt. 2) Goto 9200

C	We have the data.  Figure how to format it.  The 'index'
C	is a two-dimensional table of node number size by node name size.

700	index = (nod_name_size - 1) * 4 + nod_num_size - 1

C	Save a copy of the last node name seen for errors

	old_nod_nam = nod_str(nod_start: nod_finish)

C	Zero doesn't work with computed GOTO

	If(index .eq. 0) Goto 7110

C	Dispatch on format code

	Goto (7120,7130,7140,7210,7220,7230,7240,7310,7320,7330,7340,
	1 7410,7420,7430,7440,7510,7520,7530,7540,7610,7620,7630,7640) index


C	Node number 1, Node name 1
7110	If(nod_area .eq. 0) Goto 7117
	Write(21,7115)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7115	Format('Set node',I3,'.',I1,' name ',A1)

7117	Write(21,7116) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7116	Format('Set node ',I1,' name ',A1)

C	Node number 2, Node name 1
7120	If(nod_area .eq. 0) Goto 7127
	Write(21,7125)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Go to 100

7125	Format('Set node',I3,'.',I2,' name ',A1)

7127	Write(21,7126) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7126	Format('Set node ',I2,' name ',A1)

C	Node number 3, Node name 1
7130	If(node_area .eq. 0) Goto 7137
	Write(31,7135)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7135	Format('Set node',I3,'.',I3,' name ',A1)

7137	Write(31,7136) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7136	Format('Set node ',I3,' name ',A1)

C	Node number 4, Node name 1
7140	If(nod_area .eq. 0) Goto 7147
	Write(21,7145)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7145	Format('Set node',I3,'.',I4,' name ',A1)

7147	Write(21,7146) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7146	Format('Set node ',I4,' name ',A1)

C	Node number 1, Node name 2
7210	If(nod_area .eq. 0) Goto 7217
	Write(21,7215)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7215	Format('Set node',I3,'.',I1,' name ',A2)

7217	Write(21,7216) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7216	Format('Set node ',I1,' name ',A2)

C	Node number 2, Node name 2
7220	If(nod_area .eq. 0) Goto 7227
	Write(21,7225)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7225	Format('Set node',I3,'.',I2,' name ',A2)

7227	Write(21,7226) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7226	Format('Set node ',I2,' name ',A2)

C	Node number 3, Node name 2
7230	If(nod_area .eq. 0) Goto 7237
	Write(21,7235)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7235	Format('Set node',I3,'.',I3,' name ',A2)

7237	Write(21,7236) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7236	Format('Set node ',I3,' name ',A2)

C	Node number 4 Node name 2
7240	If(nod_area .eq. 0) Goto 7247
	Write(21,7245)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7245	Format('Set node',I3,'.',I4,' name ',A2)

7247	Write(21,7246) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7246	Format('Set node ',I4,' name ',A2)

C	Node number 1 Node name 3
7310	If(nod_area .eq. 0) Goto 7317
	Write(21,7315)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7315	Format('Set node',I3,'.',I1,' name ',A3)

7317	Write(21,7316) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7316	Format('Set node ',I1,' name ',A3)

C	Node number 2 Node name 3
7320	If(nod_area .eq. 0) Goto 7327
	Write(21,7325)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7325	Format('Set node',I3,'.',I2,' name ',A3)

7327	Write(21,7326) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7326	Format('Set node ',I2,' name ',A3)

C	Node number 3 Node name 3
7330	If(nod_area .eq. 0) Goto 7337
	Write(21,7335)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7335	Format('Set node',I3,'.',I3,' name ',A3)

7337	Write(21,7336) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7336	Format('Set node ',I3,' name ',A3)

C	Node number 4 Node name 3
7340	If(nod_area .eq. 0) Goto 7347
	Write(21,7345)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7345	Format('Set node',I3,'.',I4,' name ',A3)

7347	Write(21,7346) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7346	Format('Set node ',I4,' name ',A3)

C	Node number 1 Node name 4
7410	If(nod_area .eq. 0) Goto 7417
	Write(21,7415)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7415	Format('Set node',I3,'.',I1,' name ',A4)

7417	Write(21,7416) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7416	Format('Set node ',I1,' name ',A4)

C	Node number 2 Node name 4
7420	If(nod_area .eq. 0) Goto 7427
	Write(21,7425)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7425	Format('Set node',I3,'.',I2,' name ',A4)

7427	Write(21,7426) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7426	Format('Set node ',I2,' name ',A4)

C	Node number 3 Node name 4
7430	If(nod_area .eq. 0) Goto 7437
	Write(21,7435)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7435	Format('Set node',I3,'.',I3,' name ',A4)

7437	Write(21,7436) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7436	Format('Set node ',I3,' name ',A4)

C	Node number 4 Node name 4
7440	If(nod_area .eq. 0) Goto 7447
	Write(21,7445)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7445	Format('Set node',I3,'.',I4,' name ',A4)

7447	Write(21,7446) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7446	Format('Set node ',I4,' name ',A4)

C	Node number 1 Node name 5
7510	If(nod_area .eq. 0) Goto 7517
	Write(21,7515)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7515	Format('Set node',I3,'.',I1,' name ',A5)

7517	Write(21,7516) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7516	Format('Set node ',I1,' name ',A5)

C	Node number 2 Node name 5
7520	If(nod_area .eq. 0) Goto 7527
	Write(21,7525)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7525	Format('Set node',I3,'.',I2,' name ',A5)

7527	Write(21,7526) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7526	Format('Set node ',I2,' name ',A5)

C	Node number 3 Node name 5
7530	If(nod_area .eq. 0) Goto 7537
	Write(21,7535)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7535	Format('Set node',I3,'.',I3,' name ',A5)

7537	Write(21,7536) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7536	Format('Set node ',I3,' name ',A5)

C	Node number 4 Node name 5
7540	If(nod_area .eq. 0) Goto 7547
	Write(21,7545)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7545	Format('Set node',I3,'.',I4,' name ',A5)

7547	Write(21,7546) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7546	Format('Set node ',I4,' name ',A5)

C	Node number 1 Node name 6
7610	If(nod_area .eq. 0) Goto 7617
	Write(21,7615)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7615	Format('Set node',I3,'.',I1,' name ',A6)

7617	Write(21,7616) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7616	Format('Set node ',I1,' name ',A6)

C	Node number 2 Node name 6
7620	If(nod_area .eq. 0) Goto 7627
	Write(21,7625)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7625	Format('Set node',I3,'.',I2,' name ',A6)

7627	Write(21,7626) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7626	Format('Set node ',I2,' name ',A6)

C	Node number 3 Node name 6
7630	If(nod_area .eq. 0) Goto 7637
	Write(21,7635)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7635	Format('Set node',I3,'.',I3,' name ',A6)

7637	Write(21,7636) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7636	Format('Set node ',I3,' name ',A6)

C	Node number 4 Node name 6
7640	If(nod_area .eq. 0) Goto 7647
	Write(21,7645)nod_area, nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7645	Format('Set node',I3,'.',I4,' name ',A6)

7647	Write(21,7646) nod_number,
	1 (nod_str(nod_start: nod_finish))
	Goto 100

7646	Format('Set node ',I4,' name ',A6)

C	End of file -- close up shop...

1000	Close (unit=20)
	Close (unit=21)
	Write(6,1010)rec_num,errs
1010	Format(' %Total of ',I5,' records read; ',I3,' errors.')
	Goto 9999

C	Error messages here...
9000	Write(6,9010)io
9010	Format(' %Error opening SYS$SYSTEM:NETNODE.DAT for input',/,
	1 '% Error code = ',I10)
	Goto 9999

9100	rec_num = rec_num + 1
	errs = errs + 1
	Write(6,9110)
9110	Format(' %Error getting record number',I5,/,
	1 ' %Previous node name is ',A6)
	errs = errs + 1
	Goto 100

9200	Write(6,9210) rec_num,nod_str,(nod_chrs(i),i=1,24)
9210	Format(' %Missing packet(s) in record #',
	1 I4,': "',A24,'"',/,5X,18I4,/,5X,6I4,/,' % Ignoring this record...')
	errs = errs + 1
	Goto 100

9400	Write(6,9410) rec_num, nod_str, (nod_chrs(i),i=1,l)
9410	Format(' % Null node name in record #',I4,': "',A24,'"',/,
	5X,18I4,/,5X,6I4,/,' % Ignoring this record...')
	errs = errs + 1
	Goto 100

9500	Write(6,9510) rec_num, nod_str, (nod_chrs(i),i=1,l)
9510	Format(' % Null node number in record #',I4,': "',A24,'"',/,
	5X,18I4,/,5X,6I4,/,' % Ignoring this record...')
	errs = errs + 1
	Goto 100

9999	Stop
	End
C	Subroutine to read a DECnet extensible integer

	Subroutine Get_Value(byte_ptr,value_found,value)
	Integer byte_ptr,value
	Integer byte_array(256)
	Common /string/byte_array
	Logical value_found

	Integer size

	value_found = .false.

	value = 0

C	size = TWO_BYTES(byte_ptr)  !Count of bytes in the integer
	size = byte_array(byte_ptr) + 256 * byte_array(byte_ptr+1)
	If(size .eq. 0) Goto 9999

C	Bytes are stored lo to hi order.  Loop from hi to lo.

	Do 100 i = size, 1, -1
100	value = (value * 256) + byte_array(byte_ptr + 1 + i)
	value_found = .true.

9999	Return
	End
