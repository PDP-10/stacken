! Control file to build free core analysis program

! Adjust the origin of the CODE PSECT to match FYSORG for the
! type of monitor (KL, KS) which you are building FRECOR for.

! Remove the comment lines to load a debugging version.

.COMPILE FRECOR.MAC

.R LINK
*FRECOR /SAVE = /SET:CODE:314000 -
!*/LOCALS /SYMSEG:PSECT:CODE -
*FRECOR, -
!*SYS:DDT, -
*/GO
