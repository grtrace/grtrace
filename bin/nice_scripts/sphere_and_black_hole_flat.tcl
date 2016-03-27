configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0.0001
configSet "CameraY" 0.0001
configSet "CameraZ" -10
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-f 45"
configSet "OutputFile" "sphere_and_black_hole_flat.png"

addMaterial .mat1 -e white -d 1.0,1.0,1.0 -f b

addObject .sph1 -m .mat1 -t sphere -c 0,0,10 -r 5

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"