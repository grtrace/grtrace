configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "OutputFile" "sphere_and_black_hole_bh_schwarzschild.png"

loadScene "scenes/_common.grt"
loadScene "scenes/sphereandhole.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0.0001 0.0001 -10 ANGLES VEC3 0 0 0 FOV 45 ;"
sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 500 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
