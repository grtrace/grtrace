configSet "ResolutionX" 200
configSet "ResolutionY" 200
configSet "Samples" 1
configSet "OutputFile" "raytrace_accretion_redshift.png"

loadScene "scenes/_common.grt"
loadScene "scenes/bhaccretion.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0 -2 -20 ANGLES VEC3 -6 0 0 FOV 42 ;"
sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 500 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
