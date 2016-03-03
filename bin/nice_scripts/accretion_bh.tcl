configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0
configSet "CameraY" -2
configSet "CameraZ" -20
configSet "CameraPitch" -6
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 42"
configSet "OutputFile" "raytrace_accretion_redshift.png"
configSet "MetricOptions" "-t schwarzschild -m 1.5 -x 0 -y 0 -z 0 -d 0.1 -n 500"

addMaterial .mat -D -e black -f b

addObject .sph1 -m .mat1 -t sphere -c 0,0,20 -r 13

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
