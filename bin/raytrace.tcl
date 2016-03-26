configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" 4
configSet "CameraZ" 0
configSet "CameraPitch" 0
configSet "CameraYaw" 270
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 42"
configSet "MetricOptions" "-t kerr -m 1 -L 1 -x 0 -y 0 -z 0 -d 0.001 -n 50000"

addMaterial .mat -D -e black -f b

addObject .sph1 -m .mat -t sphere -c 0,0,0 -r 2

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
