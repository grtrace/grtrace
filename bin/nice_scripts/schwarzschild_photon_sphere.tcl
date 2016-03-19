configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 4.5
configSet "CameraY" 0
configSet "CameraZ" 0
configSet "CameraPitch" -6
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 42"
configSet "MetricOptions" "-t schwarzschild -m 1.5 -x 0 -y 0 -z 0 -d 0.01 -n 5000"

addMaterial .mat -D -e black -f b

addObject .sph1 -m .mat -t sphere -c 0,0,0 -r 3

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
