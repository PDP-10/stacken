! ICSCBL
! Compile and run DIL Installation Tests for DECsystem-10 COBOL
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
! %(  Convert to run on TOPS-10 -- Doug Rayner.
!     Add DIL V2 test programs to DIL DLT2: )%
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
! Edit (%O'11', '29-Jun-84', 'Sandy Clemens')
! %(  Clean up some of the ICS control files.   FILES:  ICSCBL.10-CTL,
!     ICSCBL.CTL, DILTHST.TXT
! )%
!
! Edit (%O'15', '8-Oct-84', 'Sandy Clemens')
! %( Change comments in ICSCBL.10-CTL, ICSCBL.CTL, ICSF7.10-CTL and
!    ICSF7.CTL about making the valid login directory.  FILES:
!    ICSCBL.10-CTL, ICSF7.10-CTL, ICSCBL.CTL, ICSF7.CTL )% 
!==
!
! This  control  file   compiles  and  runs   the  DIL   Installation
! Verificaion Tests for DECsystem-10 Cobol.  It is necessary for  the
! program CD36T1.CBL to have the following directory:
!
!                  directory name: [5,33]
!                        password: DILTST
! 
! If this  directory does  not exist  you must  EITHER 1)  create  the
! directory  as  VALID  login  directory,  or  2)  edit  the   program
! CD36T1.CBL to use a  valid login directory of  your choice and  edit
! this control file to  use the password for  the login directory  you
! have selected.   (NOTE:  The password  for  the login  directory  is
! requested by the program CD36T1, so you must change "DILTST" (below)
! to be the password for the login directory you select.)
!
! The programs  included  in this  test  stream use  only  the  local
! network node, but  WILL require  the use of  the FAL  on the  local
! node.  Programs will fail with  the error DIT-NETOPERFAIL if  there
! is not a FAL available.
!
! Compile all the COBOL DECsystem-10 installation verification tests.
.
.r cbl74
*c36t2,-=c36t2
*cd36t1,-=cd36t1/d:2000
*ct36t1,-=ct36t1
.
! Link all the COBOL DECsystem-10 installation verification tests.
.
.r link
*C36T2
*/SEG:LOW SYS:DIL/SEA,SYS:XPORT/SEA/EXCLUDE:XFUNCT,SYS:B361LB/SEA/G
.save
.
.r link
*CT36T1
*/SEG:LOW SYS:DIL/SEA,SYS:XPORT/SEA/EXCLUDE:XFUNCT,SYS:B361LB/SEA/G
.save
.
.r link
*CD36T1
*/SEG:LOW SYS:DIL/SEA,SYS:XPORT/SEA/EXCLUDE:XFUNCT,SYS:B361LB/SEA/G
.save
.
! Run all the COBOL DECsystem-10 installation verification tests.
.run C36T2
.
.run CT36T1
*This is data for CT36T1 for the first send
*This is data for CT36T1 for the second send
.run CD36T1
*4
*0
*DILTST
*This is data for CD36T1 for writing to the remote file DSK:[5,33]DAP.TST.
