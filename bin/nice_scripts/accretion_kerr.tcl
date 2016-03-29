configSet "ResolutionX" 200
configSet "ResolutionY" 200
configSet "Samples" 1
configSet "OutputFile" "raytrace_accretion_kerr_08_p.png"

loadScene "scenes/_common.grt"
loadScene "scenes/bhaccretion_violet.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0 -8 -80 ANGLES VEC3 -6 0 0 FOV 20 ;"
# sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 5000 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"
sceneCmd "SETSPACE ANALYTIC KERR STEPS 5000 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ANGMOMENTUM 0.8 ;"
# sceneCmd "SETSPACE FLAT ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
