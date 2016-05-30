configSet "ResolutionX" 900
configSet "ResolutionY" 900
configSet "Samples" 1
configSet "OutputFile" "raytrace_accretion_kerr_hq_schw.png"

loadScene "scenes/_common.grt"
#loadScene "scenes/bhaccretion_violet.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0 -8 -80 ANGLES VEC3 -6 0 0 FOV 23 ;"
# sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 5000 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"
#sceneCmd "SETSPACE ANALYTIC KERR STEPS 5000 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ANGMOMENTUM 0.9 ;"
sceneCmd "SETSPACE ANALYTIC REISSNER STEPS 5000 STEPPARAM 0.1 MASS 0 CHARGE 1 ORIGIN vec3.0 ;"
#sceneCmd "SETSPACE FLAT ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
