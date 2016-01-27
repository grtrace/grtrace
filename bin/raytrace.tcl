configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
#configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" 0
configSet "CameraZ" -15
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 45"

#loadTexture .tex1 textures/stone.png

addMaterial .mat1 -d 1.0,1.0,1.0 -e 0.0,0.0,0.0 -f b

addObject .light1 -t pointlight -p 0,2,0 -c white
#addObject .plane1 -m .mat1 -t texplane -c a -o 0,0,20 -a0 -b0 -F -90,90,20 -S -70,90,20 -G1 -H1 -I0 -J0
addObject .sph1 -m .mat1 -t sphere -c 0,0,0 -r 1

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
