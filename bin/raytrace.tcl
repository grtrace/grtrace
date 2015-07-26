configSet "ResolutionX" 640
configSet "ResolutionY" 480
configSet "Samples" 1
#configSet "WorldSpace" "deflect"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" 0
configSet "CameraZ" -100
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 30"

loadTexture .tex1 textures/photo.png

addMaterial .mat1 -D -d 1.0,1.0,1.0 -t .tex1 -f b

addObject .light1 -t pointlight -p 0,5,0 -c white
#addObject .plane1 -m .mat1 -t texplane -c a -o 0,2,0 -a90 -b90 -F 1,2,0 -S 0,2,0 -G0 -H0 -I1 -J1
addObject .sph1 -m .mat1 -t sphere -c 0,0,10 -r 1
#addObject .sph2 -m .mat1 -t sphere -c 0,0,20 -r 6
makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
