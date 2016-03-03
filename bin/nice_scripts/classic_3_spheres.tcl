configSet "ResolutionX" 1600
configSet "ResolutionY" 900
configSet "Samples" 4
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" 0
configSet "CameraZ" 0
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-f 45"
configSet "OutputFile" "clasic_3_spheres.png"

addMaterial .red_diffuse -D -d red -f b
addMaterial .green_diffuse -D -d green -f b
addMaterial .blue_diffuse -D -d blue -f b
addMaterial .white_diffuse -D -d white -f b

addObject .light1 -t pointlight -p 0,-10,-5 -c white

addObject .plane1 -m .white_diffuse -t plane -c a -o 0,10,0 -a90 -b90

addObject .sph1 -m .red_diffuse -t sphere -c 0,0,5 -r 2
addObject .sph2 -m .green_diffuse -t sphere -c 5,0,8 -r 2
addObject .sph3 -m .blue_diffuse -t sphere -c -5,0,8 -r 2

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
