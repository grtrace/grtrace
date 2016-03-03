configSet "ResolutionX" 900
configSet "ResolutionY" 900

configSet "Samples" 1
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" -0.9
configSet "CameraY" 0.8
configSet "CameraZ" -14.6
configSet "CameraPitch" 6
configSet "CameraYaw" 10
configSet "CameraRoll" 180
configSet "CameraOptions" "-f 30"
configSet "OutputFile" "room_flat.png"

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
addObject .rig1 -m .cr5 -t triangle -a 1.5,2.5,-13 -b 1.5,2.5,-9 -c 1.5,-0.5,-9
addObject .rig2 -m .cr5 -t triangle -a 1.5,2.5,-13 -b 1.5,-0.5,-13 -c 1.5,-0.5,-9
#====================================================================================
#====================================================================================
#stol
#nogaA
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

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
