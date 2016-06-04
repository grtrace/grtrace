configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "OutputFile" "_dummy.png"

loadScene "scenes/_common.grt"
loadScene "scenes/justhole.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 6 0 0 ANGLES VEC3 -6 0 0 FOV 42 ;"
sceneCmd "SETSPACE ANALYTIC REISSNER STEPS 5000 STEPPARAM 0.01 MASS mass CHARGE 1 ORIGIN vec3.0 ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
