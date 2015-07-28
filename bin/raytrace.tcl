configSet "ResolutionX" 800
configSet "ResolutionY" 600
configSet "Samples" 1
configSet "WorldSpace" "deflect"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" 0
configSet "CameraZ" -1000
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 2"

loadTexture .tex1 textures/milkyway.jpg
#textures/checkerBoard.png

addMaterial .mat1 -D -e 1.0,1.0,1.0 -t .tex1 -f b

addObject .light1 -t pointlight -p 0,0,0 -c white
addObject .plane1 -m .mat1 -t texplane -c a -o 0,55,20 -a0 -b0 -F -36,40,20 -S 36,40,20 -G1 -H1 -I0 -J0 
addObject .sph1 -m .mat1 -t sphere -c 0,0,30 -r 13

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
