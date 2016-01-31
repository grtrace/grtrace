configSet "ResolutionX" 200
configSet "ResolutionY" 100
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" 0
configSet "CameraZ" -300
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 40"
configSet "MetricOptions" "-t schwarzschild -m 1 -x 0 -y 0 -z 0 -d 0.1 -n 500"

loadTexture .tex1 textures/milkyway.jpg

addMaterial .mat1 -e 1.0,1.0,1.0 -t .tex1 -f b

addObject .light1 -t pointlight -p 0,0,0 -c white
addObject .plane1 -m .mat1 -t texplane -c a -o 0,40,20 -a0 -b0 -F -200,140,20 -S 200,140,20 -G1 -H1 -I0 -J0 
#addObject .sph1 -m .mat1 -t sphere -c 0,0,20 -r 13

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
