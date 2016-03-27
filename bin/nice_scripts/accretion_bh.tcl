configSet "ResolutionX" 200
configSet "ResolutionY" 200
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "OutputFile" "test_raytrace_accretion_redshift.png"

loadScene "scenes/_common.grt"
loadScene "scenes/bhaccretion.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0 -2 -20 ANGLES VEC3 -6 0 0 FOV FLOAT 42 ;"
sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS FLOAT 500 STEPPARAM FLOAT 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
