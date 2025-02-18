
!		     MAP %2(57)     
!              Definitions for the FORTRAN interface
!
!     COPYRIGHT (C) DIGITAL EQUIPMENT CORPORATION 1980,1986.  ALL RIGHTS RESERVED.
  !
!	This file should be INCLUDEd any  FORTRAN  program
!	wanting  to  use  the  MAP subroutine.  Only flag,
!	constants, and  offset  definitions  are  in  this
!	file.   Read MAP.MAC for a complete discription of
!	the calling sequences for the  FORTRAN  and  MACRO
!	interfaces to MAP.
     


!	Initialization block offsets
  
   	PARAMETER MPIFNC = "    0    
   	PARAMETER MPINPC = "    1    
   	PARAMETER MPISPN = "    2    
   	PARAMETER MPIDSN = "    3    
   	PARAMETER MPIARG = "    4    
   	PARAMETER MPDMAX = "    5    

!	Initialization flags
  
   	PARAMETER MPFPPM = "200000000000  
   	PARAMETER MPFPAT = "100000000000  
   	PARAMETER MPFEXE = "040000000000  
   	PARAMETER MPFPIO = "020000000000  
   	PARAMETER MPFRTM = "010000000000  
   	PARAMETER MPFSIO = "004000000000  
   	PARAMETER MPFJRM = "002000000000  
   	PARAMETER MPFSPY = "001000000000  

!	Mapping functions
     
   	PARAMETER MPFMON = "0   
   	PARAMETER MPFJOB = "1   
   	PARAMETER MPFFIL = "2   
   	PARAMETER MPFFMX = "2   

!	CPU type codes
   
   	PARAMETER PDP6 = "1     
   	PARAMETER KA10 = "2     
   	PARAMETER KI10 = "3     
   	PARAMETER KL10 = "4     
   	PARAMETER KS10 = "5     
   	PARAMETER KC10 = "6     

!	Paging codes
     
   	PARAMETER KARPR = "1    
   	PARAMETER KIPAG = "2    
   	PARAMETER KLPAG = "3    
   	PARAMETER KCPAG = "4    

!	Random constants
 
   	PARAMETER MPFEWD = "30  
   	PARAMETER MPFFWD = "21  

!	Data block offsets
    
   	PARAMETER MPDDAT = "    0    
   	PARAMETER MPDVER = "    1    
   	PARAMETER MPDSPY = "    2    
   	PARAMETER MPDCPU = "    3    
   	PARAMETER MPDPAG = "    4    
   	PARAMETER MPDPGS = "    5    
   	PARAMETER MPDCPC = "    6    
   	PARAMETER MPDCPN = "    7    
   	PARAMETER MPDSEC = "    10   
   	PARAMETER MPDPGC = "    11   
   	PARAMETER MPDPGD = "    12   
   	PARAMETER MPDADR = "    13   
   	PARAMETER MPDEXM = "    14   
   	PARAMETER MPDDEP = "    15   
   	PARAMETER MPDGTB = "    16   
   	PARAMETER MPDGTU = "    17   
   	PARAMETER MPDJPK = "    20   
   	PARAMETER MPDJPU = "    21   
   	PARAMETER MPDRTM = "    22   
   	PARAMETER MPDHSF = "    23   
   	PARAMETER MPDHSC = "    24   
   	PARAMETER MPDAFS = "    25   
   	PARAMETER MPDECD = "    46   
   	PARAMETER MPDPFX = "    47   
   	PARAMETER MPDMET = "    50   
   	PARAMETER MPDXET = "    100  
   	PARAMETER MPDLEN = "    130