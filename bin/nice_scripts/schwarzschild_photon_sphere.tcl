configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 4.5
configSet "CameraY" 0.0001
configSet "CameraZ" 0.0001
configSet "CameraPitch" -6
configSet "CameraYaw" 0
configSet "CameraRoll" 0
configSet "CameraOptions" "-x 10 -f 42"
configSet "OutputFile" "raytrace_accretion_redshift.png"
configSet "MetricOptions" "-t schwarzschild -m 1.5 -x 0 -y 0 -z 0 -d 0.05 -n 1000"

addObject .sph1 -m .mat1 -t sphere -c 0,0,0 -r 3


makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
