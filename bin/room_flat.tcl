configSet "ResolutionX" 300
configSet "ResolutionY" 300

configSet "Samples" 1
#configSet "WorldSpace" "kex"
#configSet "WorldSpace" ""
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" -0.9
configSet "CameraY" 0.8
configSet "CameraZ" -14.6
configSet "CameraPitch" 6
configSet "CameraYaw" 10
configSet "CameraRoll" 180
configSet "CameraOptions" "-x 10 -f 30"

#addMaterial .mat1 -e white -d 1.0,1.0,1.0 -f b
addMaterial .EH -e black -f b

#~650 nm
addMaterial .cr1 -l 410 -f b

addMaterial .cr2 -l 420 -f b

addMaterial .cr3 -l 430 -f b

addMaterial .cr4 -l 440 -f b

addMaterial .cr5 -l 450 -f b

#~626 nm
addMaterial .tablel -l 460 -f b 
addMaterial .tableb -l 470 -f b

#addObject .light1 -t pointlight -p 0,0,-5 -c white

#addObject .sph1 -m .mat1 -t sphere -c 0,0,-9 -r 0.125
#addObject .sph2 -m .mat1 -t sphere -c 0,0,-13 -r 0.125

#Event Horizon
addObject .eh -m .EH -t sphere -c 0,0,0 -r 3

#====================================================================================
#cornelBox
#podloga
addObject .pod1 -m .cr1 -t triangle -a 1.5,-0.5,-9 -b 1.5,-0.5,-13 -c -1.5,-0.5,-13
addObject .pod2 -m .cr1 -t triangle -a 1.5,-0.5,-9 -b -1.5,-0.5,-9 -c -1.5,-0.5,-13
#sufit
addObject .suf1 -m .cr2 -t triangle -a 1.5,2.5,-9 -b 1.5,2.5,-13 -c -1.5,2.5,-13
addObject .suf2 -m .cr2 -t triangle -a 1.5,2.5,-9 -b -1.5,2.5,-9 -c -1.5,2.5,-13
#tyl
addObject .tyl1 -m .cr3 -t triangle -a -1.5,2.5,-9 -b 1.5,2.5,-9 -c 1.5,-0.5,-9
addObject .tyl2 -m .cr3 -t triangle -a -1.5,2.5,-9 -b -1.5,-0.5,-9 -c 1.5,-0.5,-9
#lewo
addObject .lef1 -m .cr4 -t triangle -a -1.5,2.5,-13 -b -1.5,2.5,-9 -c -1.5,-0.5,-9
addObject .lef2 -m .cr4 -t triangle -a -1.5,2.5,-13 -b -1.5,-0.5,-13 -c -1.5,-0.5,-9
#prawo
#addObject .rig1 -m .cr5 -t triangle -a 1.5,2.5,-13 -b 1.5,2.5,-9 -c 1.5,-0.5,-9
#addObject .rig2 -m .cr5 -t triangle -a 1.5,2.5,-13 -b 1.5,-0.5,-13 -c 1.5,-0.5,-9
#====================================================================================
#====================================================================================
#stol
#nogaA
#podloga
#addObject .nab1 -m .tablel -t triangle -a 0.9,-0.5,-9.9 -b 0.9,-0.5,-10  -c 0.8,-0.5,-10 
#addObject .nab2 -m .tablel -t triangle -a 0.9,-0.5,-9.9 -b 0.8,-0.5,-9.9  -c 0.8,-0.5,-10 
#sufit
#addObject .nat1 -m .tablel -t triangle -a 0.9,0.2,-9.9  -b 0.9,0.2,-10 -c 0.8,0.2,-10
#addObject .nat2 -m .tablel -t triangle -a 0.9,0.2,-9.9  -b 0.8,0.2,-9.9 -c 0.8,0.2,-10
#tyl
addObject .nas1 -m .tablel -t triangle -a 0.8,0.2,-9.9 -b 0.9,0.2,-9.9  -c 0.9,-0.5,-9.9
addObject .nas2 -m .tablel -t triangle -a 0.8,0.2,-9.9 -b 0.8,-0.5,-9.9  -c 0.9,-0.5,-9.9
#lewo
addObject .nal1 -m .tablel -t triangle -a 0.8,0.2,-10 -b 0.8,0.2,-9.9 -c 0.8,-0.5,-9.9 
addObject .nal2 -m .tablel -t triangle -a 0.8,0.2,-10 -b 0.8,-0.5,-10  -c 0.8,-0.5,-9.9 
#prawo
addObject .nar1 -m .tablel -t triangle -a 0.9,0.2,-10 -b 0.9,0.2,-9.9  -c 0.9,-0.5,-9.9
addObject .nar2 -m .tablel -t triangle -a 0.9,0.2,-10 -b 0.9,-0.5,-10  -c 0.9,-0.5,-9.9
#przod
addObject .naf1 -m .tablel -t triangle -a 0.8,0.2,-10 -b 0.9,0.2,-10  -c 0.9,-0.5,-10
addObject .naf2 -m .tablel -t triangle -a 0.8,0.2,-10 -b 0.8,-0.5,-10  -c 0.9,-0.5,-10
#-------------------------------------------------------------------------------------
#nogaB
#podloga
#addObject .nbb1 -m .tablel -t triangle -a -0.1,-0.5,-9.9 -b -0.1,-0.5,-10  -c -0.2,-0.5,-10 
#addObject .nbb2 -m .tablel -t triangle -a -0.1,-0.5,-9.9 -b -0.2,-0.5,-9.9  -c -0.2,-0.5,-10 
#sufit
#addObject .nbt1 -m .tablel -t triangle -a -0.1,0.2,-9.9  -b -0.1,0.2,-10 -c -0.2,0.2,-10
#addObject .nbt2 -m .tablel -t triangle -a -0.1,0.2,-9.9  -b -0.2,0.2,-9.9 -c -0.2,0.2,-10
#tyl
addObject .nbs1 -m .tablel -t triangle -a -0.2,0.2,-9.9 -b -0.1,0.2,-9.9  -c -0.1,-0.5,-9.9
addObject .nbs2 -m .tablel -t triangle -a -0.2,0.2,-9.9 -b -0.2,-0.5,-9.9  -c -0.1,-0.5,-9.9
#lewo
addObject .nbl1 -m .tablel -t triangle -a -0.2,0.2,-10 -b -0.2,0.2,-9.9 -c -0.2,-0.5,-9.9 
addObject .nbl2 -m .tablel -t triangle -a -0.2,0.2,-10 -b -0.2,-0.5,-10  -c -0.2,-0.5,-9.9 
#prawo
addObject .nbr1 -m .tablel -t triangle -a -0.1,0.2,-10 -b -0.1,0.2,-9.9  -c -0.1,-0.5,-9.9
addObject .nbr2 -m .tablel -t triangle -a -0.1,0.2,-10 -b -0.1,-0.5,-10  -c -0.1,-0.5,-9.9
#przod
addObject .nbf1 -m .tablel -t triangle -a -0.2,0.2,-10 -b -0.1,0.2,-10  -c -0.1,-0.5,-10
addObject .nbf2 -m .tablel -t triangle -a -0.2,0.2,-10 -b -0.2,-0.5,-10  -c -0.1,-0.5,-10
#-------------------------------------------------------------------------------------
#nogaC
#podloga
#addObject .ncb1 -m .tablel -t triangle -a 0.9,-0.5,-11.9 -b 0.9,-0.5,-12  -c 0.8,-0.5,-12 
#addObject .ncb2 -m .tablel -t triangle -a 0.9,-0.5,-11.9 -b 0.8,-0.5,-11.9  -c 0.8,-0.5,-12 
#sufit
#addObject .nct1 -m .tablel -t triangle -a 0.9,0.2,-11.9  -b 0.9,0.2,-12 -c 0.8,0.2,-12 
#addObject .nct2 -m .tablel -t triangle -a 0.9,0.2,-11.9  -b 0.8,0.2,-11.9 -c 0.8,0.2,-12 
#tyl
addObject .ncs1 -m .tablel -t triangle -a 0.8,0.2,-11.9 -b 0.9,0.2,-11.9  -c 0.9,-0.5,-11.9 
addObject .ncs2 -m .tablel -t triangle -a 0.8,0.2,-11.9 -b 0.8,-0.5,-11.9  -c 0.9,-0.5,-11.9 
#lewo
addObject .ncl1 -m .tablel -t triangle -a 0.8,0.2,-12 -b 0.8,0.2,-11.9 -c 0.8,-0.5,-11.9 
addObject .ncl2 -m .tablel -t triangle -a 0.8,0.2,-12 -b 0.8,-0.5,-12  -c 0.8,-0.5,-11.9 
#prawo
addObject .ncr1 -m .tablel -t triangle -a 0.9,0.2,-12 -b 0.9,0.2,-11.9  -c 0.9,-0.5,-11.9 
addObject .ncr2 -m .tablel -t triangle -a 0.9,0.2,-12 -b 0.9,-0.5,-12  -c 0.9,-0.5,-11.9 
#przod
addObject .ncf1 -m .tablel -t triangle -a 0.8,0.2,-12 -b 0.9,0.2,-12  -c 0.9,-0.5,-12 
addObject .ncf2 -m .tablel -t triangle -a 0.8,0.2,-12 -b 0.8,-0.5,-12  -c 0.9,-0.5,-12 
#-------------------------------------------------------------------------------------
#nogaD
#podloga
#addObject .ndb1 -m .tablel -t triangle -a -0.1,-0.5,-11.9 -b -0.1,-0.5,-12  -c -0.2,-0.5,-12 
#addObject .ndb2 -m .tablel -t triangle -a -0.1,-0.5,-11.9 -b -0.2,-0.5,-11.9  -c -0.2,-0.5,-12 
#sufit
#addObject .ndt1 -m .tablel -t triangle -a -0.1,0.2,-11.9  -b -0.1,0.2,-12 -c -0.2,0.2,-12 
#addObject .ndt2 -m .tablel -t triangle -a -0.1,0.2,-11.9  -b -0.2,0.2,-11.9 -c -0.2,0.2,-12 
#tyl
addObject .nds1 -m .tablel -t triangle -a -0.2,0.2,-11.9 -b -0.1,0.2,-11.9  -c -0.1,-0.5,-11.9 
addObject .nds2 -m .tablel -t triangle -a -0.2,0.2,-11.9 -b -0.2,-0.5,-11.9  -c -0.1,-0.5,-11.9 
#lewo
addObject .ndl1 -m .tablel -t triangle -a -0.2,0.2,-12 -b -0.2,0.2,-11.9 -c -0.2,-0.5,-11.9 
addObject .ndl2 -m .tablel -t triangle -a -0.2,0.2,-12 -b -0.2,-0.5,-12  -c -0.2,-0.5,-11.9 
#prawo
addObject .ndr1 -m .tablel -t triangle -a -0.1,0.2,-12 -b -0.1,0.2,-11.9  -c -0.1,-0.5,-11.9 
addObject .ndr2 -m .tablel -t triangle -a -0.1,0.2,-12 -b -0.1,-0.5,-12  -c -0.1,-0.5,-11.9 
#przod
addObject .ndf1 -m .tablel -t triangle -a -0.2,0.2,-12 -b -0.1,0.2,-12  -c -0.1,-0.5,-12 
addObject .ndf2 -m .tablel -t triangle -a -0.2,0.2,-12 -b -0.2,-0.5,-12  -c -0.1,-0.5,-12 
#-------------------------------------------------------------------------------------
#blat
addObject .blt1 -m .tableb -t triangle -a 0.9,0.2,-9.9  -b -0.2,0.2,-9.9 -c -0.2,0.2,-12 
addObject .blt2 -m .tableb -t triangle -a 0.9,0.2,-9.9  -b 0.9,0.2,-12 -c -0.2,0.2,-12 
#====================================================================================



#nogaA_spod
#addObject .sph11 -m .mat1 -t sphere -c 0.9,-0.5,-11.9 -r 0.125
#addObject .sph12 -m .mat1 -t sphere -c 0.9,-0.5,-10 -r 0.125
#addObject .sph13 -m .mat1 -t sphere -c 0.8,-0.5,-11.9 -r 0.125
#addObject .sph14 -m .mat1 -t sphere -c 0.8,-0.5,-10 -r 0.125

#nogaA_gora
#addObject .sph15 -m .mat1 -t sphere -c 0.9,0.2,-11.9 -r 0.125
#addObject .sph16 -m .mat1 -t sphere -c 0.9,0.2,-10 -r 0.125
#addObject .sph17 -m .mat1 -t sphere -c 0.8,0.2,-11.9 -r 0.125
#addObject .sph18 -m .mat1 -t sphere -c 0.8,0.2,-10 -r 0.125

#nogaB_spod
#addObject .sph19 -m .mat1 -t sphere -c -0.1,-0.5,-11.9 -r 0.125
#addObject .sph20 -m .mat1 -t sphere -c -0.1,-0.5,-10 -r 0.125
#addObject .sph21 -m .mat1 -t sphere -c -0.2,-0.5,-11.9 -r 0.125
#addObject .sph22 -m .mat1 -t sphere -c -0.2,-0.5,-10 -r 0.125

#nogaB_gora
#addObject .sph23 -m .mat1 -t sphere -c -0.1,0.2,-11.9 -r 0.125
#addObject .sph24 -m .mat1 -t sphere -c -0.1,0.2,-10 -r 0.125
#addObject .sph25 -m .mat1 -t sphere -c -0.2,0.2,-11.9 -r 0.125
#addObject .sph26 -m .mat1 -t sphere -c -0.2,0.2,-10 -r 0.125

#nogaC_spod
#addObject .sph27 -m .mat1 -t sphere -c 0.9,-0.5,-11.9 -r 0.125
#addObject .sph28 -m .mat1 -t sphere -c 0.9,-0.5,-12 -r 0.125
#addObject .sph29 -m .mat1 -t sphere -c 0.8,-0.5,-11.9 -r 0.125
#addObject .sph30 -m .mat1 -t sphere -c 0.8,-0.5,-12 -r 0.125

#nogaC_gora
#addObject .sph31 -m .mat1 -t sphere -c 0.9,0.2,-11.9 -r 0.125
#addObject .sph32 -m .mat1 -t sphere -c 0.9,0.2,-12 -r 0.125
#addObject .sph33 -m .mat1 -t sphere -c 0.8,0.2,-11.9 -r 0.125
#addObject .sph34 -m .mat1 -t sphere -c 0.8,0.2,-12 -r 0.125

#nogaD_spod
#addObject .sph35 -m .mat1 -t sphere -c -0.1,-0.5,-11.9 -r 0.125
#addObject .sph36 -m .mat1 -t sphere -c -0.1,-0.5,-12 -r 0.125
#addObject .sph37 -m .mat1 -t sphere -c -0.2,-0.5,-11.9 -r 0.125
#addObject .sph38 -m .mat1 -t sphere -c -0.2,-0.5,-12 -r 0.125

#nogaD_gora
#addObject .sph39 -m .mat1 -t sphere -c -0.1,0.2,-11.9 -r 0.125
#addObject .sph40 -m .mat1 -t sphere -c -0.1,0.2,-12 -r 0.125
#addObject .sph41 -m .mat1 -t sphere -c -0.2,0.2,-11.9 -r 0.125
#addObject .sph42 -m .mat1 -t sphere -c -0.2,0.2,-12 -r 0.125

#podloga
#addObject .sph3 -m .mat1 -t sphere -c 1.5,-0.5,-9 -r 0.125
#addObject .sph4 -m .mat1 -t sphere -c 1.5,-0.5,-13 -r 0.125
#addObject .sph5 -m .mat1 -t sphere -c -1.5,-0.5,-9 -r 0.125
#addObject .sph6 -m .mat1 -t sphere -c -1.5,-0.5,-13 -r 0.125

#sufit
#addObject .sph7 -m .mat1 -t sphere -c 1.5,2.5,-9 -r 0.125
#addObject .sph8 -m .mat1 -t sphere -c 1.5,2.5,-13 -r 0.125
#addObject .sph9 -m .mat1 -t sphere -c -1.5,2.5,-9 -r 0.125
#addObject .sph10 -m .mat1 -t sphere -c -1.5,2.5,-13 -r 0.125

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
