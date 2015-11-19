configSet "ResolutionX" 800
configSet "ResolutionY" 600
configSet "Samples" 4
#configSet "WorldSpace" "kex"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" 0
configSet "CameraZ" -30
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 30"

loadTexture .tex1 textures/milkyway.jpg
loadTexture .texf textures/earth.png

addMaterial .mat1 -e 1.0,1.0,1.0 -t .tex1 -f b
addMaterial .mat2 -e 1.0,1.0,1.0 -t .texf -f n

addObject .light1 -t pointlight -p 0,0,0 -c white
addObject .plane1 -m .mat1 -t texplane -c a -o 0,40,20 -a0 -b0 -F -200,140,20 -S 200,140,20 -G1 -H1 -I0 -J0 
addObject .ball1 -m .mat2 -t sphere -c 0,0,10 -r 2
addObject .ball2 -m .mat2 -t sphere -c 5,0,10 -r 2
addObject .ball3 -m .mat2 -t sphere -c -5,0,10 -r 2
#addObject .sph1 -m .mat1 -t sphere -c 0,0,20 -r 13

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
