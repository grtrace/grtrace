configSet "ResolutionX" 200
configSet "ResolutionY" 200
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

addMaterial .mat_black -e 0.0,0.0,0.0 -f n
addMaterial .mat_disc -l 500 -f n

addObject .acr -m .mat_disc -t accretion -c a -o 0,0,0 -a90 -b90 --inner_radius 4.5 --outer_radius 12
addObject .sph1 -m .mat_black -t sphere -c 0,0,0 -r 3

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
