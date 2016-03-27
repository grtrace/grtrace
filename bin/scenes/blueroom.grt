GRTRACE SCENE DESCRIPTION VERSION 1
REQUIRE _common ;

DEFINE mass FLOAT 1.5 ;
DEFINE radius FLOAT 3 ;

DEFINE cameraOrigin VEC3 -0.9 0.8 -14.6 ;
DEFINE cameraAngles VEC3 6 10 180 ;

MATERIAL .EH EMIT black ;
MATERIAL .cr1 EMIT WAVE 410 ;
MATERIAL .cr2 EMIT WAVE 420 ;
MATERIAL .cr3 EMIT WAVE 430 ;
MATERIAL .cr4 EMIT WAVE 440 ;
MATERIAL .cr5 EMIT WAVE 450 ;
MATERIAL .tablel EMIT WAVE 460 ;
MATERIAL .tableb EMIT WAVE 470 ;

=SPHERE eh MATERIAL .EH CENTER vec3.0 RADIUS radius ; 

#cornelBox
#podloga
=TRIANGLE .pod1 MATERIAL .cr1 POINT1 VEC3 1.5 -0.5 -9 POINT2 VEC3 1.5 -0.5 -13 POINT3 VEC3 -1.5 -0.5 -13 ;
=TRIANGLE .pod2 MATERIAL .cr1 POINT1 VEC3 1.5 -0.5 -9 POINT2 VEC3 -1.5 -0.5 -9 POINT3 VEC3 -1.5 -0.5 -13 ;
#sufit
=TRIANGLE .suf1 MATERIAL .cr2 POINT1 VEC3 1.5 2.5 -9 POINT2 VEC3 1.5 2.5 -13 POINT3 VEC3 -1.5 2.5 -13 ;
=TRIANGLE .suf2 MATERIAL .cr2 POINT1 VEC3 1.5 2.5 -9 POINT2 VEC3 -1.5 2.5 -9 POINT3 VEC3 -1.5 2.5 -13 ;
#tyl
=TRIANGLE .tyl1 MATERIAL .cr3 POINT1 VEC3 -1.5 2.5 -9 POINT2 VEC3 1.5 2.5 -9 POINT3 VEC3 1.5 -0.5 -9 ;
=TRIANGLE .tyl2 MATERIAL .cr3 POINT1 VEC3 -1.5 2.5 -9 POINT2 VEC3 -1.5 -0.5 -9 POINT3 VEC3 1.5 -0.5 -9 ;
#lewo
=TRIANGLE .lef1 MATERIAL .cr4 POINT1 VEC3 -1.5 2.5 -13 POINT2 VEC3 -1.5 2.5 -9 POINT3 VEC3 -1.5 -0.5 -9 ;
=TRIANGLE .lef2 MATERIAL .cr4 POINT1 VEC3 -1.5 2.5 -13 POINT2 VEC3 -1.5 -0.5 -13 POINT3 VEC3 -1.5 -0.5 -9 ;
#prawo
=TRIANGLE .rig1 MATERIAL .cr5 POINT1 VEC3 1.5 2.5 -13 POINT2 VEC3 1.5 2.5 -9 POINT3 VEC3 1.5 -0.5 -9 ;
=TRIANGLE .rig2 MATERIAL .cr5 POINT1 VEC3 1.5 2.5 -13 POINT2 VEC3 1.5 -0.5 -13 POINT3 VEC3 1.5 -0.5 -9 ;
#====================================================================================
#====================================================================================
#stol
#nogaA
#tyl
=TRIANGLE .nas1 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -9.9 POINT2 VEC3 0.9 0.2 -9.9  POINT3 VEC3 0.9 -0.5 -9.9 ;
=TRIANGLE .nas2 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -9.9 POINT2 VEC3 0.8 -0.5 -9.9  POINT3 VEC3 0.9 -0.5 -9.9 ;
#lewo
=TRIANGLE .nal1 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -10 POINT2 VEC3 0.8 0.2 -9.9 POINT3 VEC3 0.8 -0.5 -9.9  ;
=TRIANGLE .nal2 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -10 POINT2 VEC3 0.8 -0.5 -10  POINT3 VEC3 0.8 -0.5 -9.9  ;
#prawo
=TRIANGLE .nar1 MATERIAL .tablel POINT1 VEC3 0.9 0.2 -10 POINT2 VEC3 0.9 0.2 -9.9  POINT3 VEC3 0.9 -0.5 -9.9 ;
=TRIANGLE .nar2 MATERIAL .tablel POINT1 VEC3 0.9 0.2 -10 POINT2 VEC3 0.9 -0.5 -10  POINT3 VEC3 0.9 -0.5 -9.9 ;
#przod
=TRIANGLE .naf1 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -10 POINT2 VEC3 0.9 0.2 -10  POINT3 VEC3 0.9 -0.5 -10 ;
=TRIANGLE .naf2 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -10 POINT2 VEC3 0.8 -0.5 -10  POINT3 VEC3 0.9 -0.5 -10 ;
#-------------------------------------------------------------------------------------
#nogaB
#tyl
=TRIANGLE .nbs1 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -9.9 POINT2 VEC3 -0.1 0.2 -9.9  POINT3 VEC3 -0.1 -0.5 -9.9 ;
=TRIANGLE .nbs2 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -9.9 POINT2 VEC3 -0.2 -0.5 -9.9  POINT3 VEC3 -0.1 -0.5 -9.9 ;
#lewo
=TRIANGLE .nbl1 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -10 POINT2 VEC3 -0.2 0.2 -9.9 POINT3 VEC3 -0.2 -0.5 -9.9  ;
=TRIANGLE .nbl2 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -10 POINT2 VEC3 -0.2 -0.5 -10  POINT3 VEC3 -0.2 -0.5 -9.9  ;
#prawo
=TRIANGLE .nbr1 MATERIAL .tablel POINT1 VEC3 -0.1 0.2 -10 POINT2 VEC3 -0.1 0.2 -9.9  POINT3 VEC3 -0.1 -0.5 -9.9 ;
=TRIANGLE .nbr2 MATERIAL .tablel POINT1 VEC3 -0.1 0.2 -10 POINT2 VEC3 -0.1 -0.5 -10  POINT3 VEC3 -0.1 -0.5 -9.9 ;
#przod
=TRIANGLE .nbf1 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -10 POINT2 VEC3 -0.1 0.2 -10  POINT3 VEC3 -0.1 -0.5 -10 ;
=TRIANGLE .nbf2 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -10 POINT2 VEC3 -0.2 -0.5 -10  POINT3 VEC3 -0.1 -0.5 -10 ;
#-------------------------------------------------------------------------------------
#nogaC
#tyl
=TRIANGLE .ncs1 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -11.9 POINT2 VEC3 0.9 0.2 -11.9  POINT3 VEC3 0.9 -0.5 -11.9  ;
=TRIANGLE .ncs2 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -11.9 POINT2 VEC3 0.8 -0.5 -11.9  POINT3 VEC3 0.9 -0.5 -11.9  ;
#lewo
=TRIANGLE .ncl1 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -12 POINT2 VEC3 0.8 0.2 -11.9 POINT3 VEC3 0.8 -0.5 -11.9  ;
=TRIANGLE .ncl2 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -12 POINT2 VEC3 0.8 -0.5 -12  POINT3 VEC3 0.8 -0.5 -11.9  ;
#prawo
=TRIANGLE .ncr1 MATERIAL .tablel POINT1 VEC3 0.9 0.2 -12 POINT2 VEC3 0.9 0.2 -11.9  POINT3 VEC3 0.9 -0.5 -11.9  ;
=TRIANGLE .ncr2 MATERIAL .tablel POINT1 VEC3 0.9 0.2 -12 POINT2 VEC3 0.9 -0.5 -12  POINT3 VEC3 0.9 -0.5 -11.9  ;
#przod
=TRIANGLE .ncf1 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -12 POINT2 VEC3 0.9 0.2 -12  POINT3 VEC3 0.9 -0.5 -12  ;
=TRIANGLE .ncf2 MATERIAL .tablel POINT1 VEC3 0.8 0.2 -12 POINT2 VEC3 0.8 -0.5 -12  POINT3 VEC3 0.9 -0.5 -12  ;
#-------------------------------------------------------------------------------------
#nogaD
#tyl
=TRIANGLE .nds1 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -11.9 POINT2 VEC3 -0.1 0.2 -11.9  POINT3 VEC3 -0.1 -0.5 -11.9  ;
=TRIANGLE .nds2 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -11.9 POINT2 VEC3 -0.2 -0.5 -11.9  POINT3 VEC3 -0.1 -0.5 -11.9  ;
#lewo
=TRIANGLE .ndl1 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -12 POINT2 VEC3 -0.2 0.2 -11.9 POINT3 VEC3 -0.2 -0.5 -11.9  ;
=TRIANGLE .ndl2 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -12 POINT2 VEC3 -0.2 -0.5 -12  POINT3 VEC3 -0.2 -0.5 -11.9  ;
#prawo
=TRIANGLE .ndr1 MATERIAL .tablel POINT1 VEC3 -0.1 0.2 -12 POINT2 VEC3 -0.1 0.2 -11.9  POINT3 VEC3 -0.1 -0.5 -11.9  ;
=TRIANGLE .ndr2 MATERIAL .tablel POINT1 VEC3 -0.1 0.2 -12 POINT2 VEC3 -0.1 -0.5 -12  POINT3 VEC3 -0.1 -0.5 -11.9  ;
#przod
=TRIANGLE .ndf1 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -12 POINT2 VEC3 -0.1 0.2 -12  POINT3 VEC3 -0.1 -0.5 -12  ;
=TRIANGLE .ndf2 MATERIAL .tablel POINT1 VEC3 -0.2 0.2 -12 POINT2 VEC3 -0.2 -0.5 -12  POINT3 VEC3 -0.1 -0.5 -12  ;
#-------------------------------------------------------------------------------------
#blat
=TRIANGLE .blt1 MATERIAL .tableb POINT1 VEC3 0.9 0.2 -9.9  POINT2 VEC3 -0.2 0.2 -9.9 POINT3 VEC3 -0.2 0.2 -12  ;
=TRIANGLE .blt2 MATERIAL .tableb POINT1 VEC3 0.9 0.2 -9.9  POINT2 VEC3 0.9 0.2 -12 POINT3 VEC3 -0.2 0.2 -12  ;
#====================================================================================
