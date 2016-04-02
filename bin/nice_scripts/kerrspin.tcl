configSet "ResolutionX" 600
configSet "ResolutionY" 600
configSet "Samples" 1
configSet "OutputFile" "kerrspin_profiler.png"

loadScene "scenes/_common.grt"
loadScene "scenes/bhaccretion_violet.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0 -8 -40 ANGLES VEC3 -12 0 0 FOV 25 ;"
sceneCmd "SETSPACE ANALYTIC KERR STEPS 850 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ANGMOMENTUM 1.0 ;"

puts "Tcl config finished"

doTrace
waitForTrace

puts "Tcl script finished"
