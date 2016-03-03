configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
#configSet "WorldSpace" ""
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" -2
configSet "CameraZ" -10
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 45"

#loadTexture .tex1 textures/stone.png

addMaterial .mat1 -D -e 1.0,1.0,1.0 -t .tex1 -f b
addMaterial .mat2 -D -e 1.0,0.0,0.0 -f b

#addObject .light1 -t pointlight -p 0,0,0 -c white
#addObject .plane1 -m .mat2 -t texplane -c a -o 0,0,20 -a0 -b0 -F -90,90,20 -S -70,90,20 -G1 -H1 -I0 -J0
addObject .acr -m .mat2 -t accretion -c a -o 0,0,0 -a90 -b90 --inner_radius 4 --outer_radius 6
addObject .sph1 -m .mat1 -t sphere -c 0,0,0 -r 3
#addObject .sph2 -m .mat1 -t sphere -c 0,0,7 -r 3

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
