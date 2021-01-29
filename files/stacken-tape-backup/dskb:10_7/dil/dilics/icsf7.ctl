! ICSF7
! Compile and run DIL Installation Tests for DECsystem-10 Fortran V7
!
!  COPYRIGHT (C) DIGITAL EQUIPMENT CORPORATION 1985.
!  ALL RIGHTS RESERVED.
!  
!  THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED  AND
!  COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE AND WITH
!  THE INCLUSION OF THE ABOVE COPYRIGHT NOTICE.   THIS  SOFTWARE  OR
!  ANY  OTHER  COPIES  THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE
!  AVAILABLE TO ANY OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF  THE
!  SOFTWARE IS HEREBY TRANSFERRED.
!  
!  THE INFORMATION IN THIS SOFTWARE IS  SUBJECT  TO  CHANGE  WITHOUT
!  NOTICE  AND  SHOULD  NOT  BE CONSTRUED AS A COMMITMENT BY DIGITAL
!  EQUIPMENT CORPORATION.
!  
!  DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR  RELIABILITY  OF
!  ITS SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.
!
! Facility: DIL-TEST
! 
! Edit History:
! 
! new_version (2, 0)
!
! Edit (%O'4', '17-Apr-84', 'Sandy Clemens')
! %( Convert to run on TOPS-10 -- Doug Rayner.
!    Add DIL V2 test programs to DIL DLT2:.   )%
!
! Edit (%O'7', '2-May-84', 'Sandy Clemens')
! %(  Remove "/EXCLUDE:XFUNCT" from the TOPS-10 LINK instructions in
!     the ICS*.10-CTL files.   FILES:  ICSF7.10-CTL, ICSCBL.10-CTL
! )%
!
! Edit (%O'10', '14-Jun-84', 'Sandy Clemens')
! %(  After carefully removing "/EXCLUDE:XFUNCT" from the TOPS-10 LINK
!     instructions in the ICS*.10-CTL files, BLISS Version 4 was
!     distributed with a new XPORT which requires the "/EXCLUDE:XFUNCT".
!     Add back "/EXCLUDE:XFUNCT" to ICSF7.10.CTL, ICSCBL.10-CTL.
! )%
!
! Edit (%O'15', '8-Oct-84', 'Sandy Clemens')
! %( Change comments in ICSCBL.10-CTL, ICSCBL.CTL, ICSF7.10-CTL and
!    ICSF7.CTL about making the valid login directory.  FILES:
!    ICSCBL.10-CTL, ICSF7.10-CTL, ICSCBL.CTL, ICSF7.CTL )% 
!==
!
! This control file compiles and runs the DIL Installation  Verificaion
! Tests for DECsystem-10 FORTRAN V7.   It is necessary for the  program
! FD7T1.FOR to have the following directory:
!
!
!                  directory name: [5,33]
!                        password: DILTST
!
! If this  directory does  not exist  you must  EITHER 1)  create  the
! directory as VALID login directory, or 2) edit the program FD7T1.FOR
! to use a valid login directory of your choice and edit this  control
! file to use the password for the login directory you have  selected.
! (NOTE: The  password for  the login  directory is  requested by  the
! program FD7T1,  so  you  must  change "DILTST"  (below)  to  be  the
! password for the login directory you select.)
!
! The programs  included  in this  test  stream use  only  the  local
! network node, but  WILL require  the use of  the FAL  on the  local
! node.  Programs will fail with  the error DIT-NETOPERFAIL if  there
! is not a FAL available.
!
! Compile all the Fortran V7 DECsystem-10 installation verification tests
.compile F7T2.FOR
.compile FT7T1.FOR
.compile FD7T1.FOR
.
! link all the Fortran V7 DECsystem-10 installation verification tests
.r link
*F7T2
*/SEG:LOW SYS:DIL/SEA,SYS:XPORT/SEA/EXCLUDE:XFUNCT,SYS:B361LB/SEA/GO
.save
.
.r link
*FT7T1
*/SEG:LOW SYS:DIL/SEA,SYS:XPORT/SEA/EXCLUDE:XFUNCT,SYS:B361LB/SEA/GO
.save
.
.r link
*FD7T1
*/SEG:LOW SYS:DIL/SEA,SYS:XPORT/SEA/EXCLUDE:XFUNCT,SYS:B361LB/SEA/GO
.save
.
! run all the Fortran V7 DECsystem-10 installation verification tests
.run F7T2
.
.run FT7T1
*This is data for FT7T1 for the first send
*This is data for FT7T1 for the second send
.run FD7T1
*DILTST
*This is data for FD7T1 for writing to the remote file DSK:[5,33]DAP.TST.
.
