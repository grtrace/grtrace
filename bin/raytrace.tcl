configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 3.5673032817411249649859436476484130761924132393610857
configSet "CameraY" 0
configSet "CameraZ" 0
configSet "CameraPitch" 90
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 42"
configSet "MetricOptions" "-t kerr -m 1 -L 0.5 -x 0 -y 0 -z 0 -d 0.001 -n 40000"

addMaterial .mat -D -e black -f b

addObject .sph1 -m .mat -t sphere -c 0,0,0 -r 1.93185165257813657349948639

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
