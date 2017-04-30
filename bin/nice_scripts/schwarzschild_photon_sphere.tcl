configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "Integrator" "RK5"
configSet "OutputFile" "_dummy.png"

loadScene "scenes/_common.grt"
loadScene "scenes/justhole.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 6 0 0 ANGLES VEC3 -6 0 0 FOV 42 ;"
sceneCmd "SETSPACE ANALYTIC REISSNER CHARGE 0 STEPS 1000 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
