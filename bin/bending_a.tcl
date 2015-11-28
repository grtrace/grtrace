configSet "ResolutionX" 200
configSet "ResolutionY" 200

configSet "Samples" 1
#configSet "WorldSpace" "kex"
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0.0001
configSet "CameraY" 0.0001
configSet "CameraZ" -10
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 45"
configSet "MetricOptions" "-t schwarzschild -m 1.5 -x 0 -y 0 -z 0 -d 0.1 -n 500"

addMaterial .mat1 -e white -d 1.0,1.0,1.0 -f b
addMaterial .EH -e black -f b

#addObject .light1 -t pointlight -p 0,0,-5 -c white

addObject .sph1 -m .mat1 -t sphere -c 0,0,10 -r 5
addObject .eh -m .EH -t sphere -c 0,0,0 -r 2

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
