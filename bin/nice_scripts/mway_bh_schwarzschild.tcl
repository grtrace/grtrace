configSet "ResolutionX" 700
configSet "ResolutionY" 700
configSet "Samples" 1
configSet "OutputFile" "mway_plane_bh_schwarzschild.png"

loadScene "scenes/_common.grt"
loadScene "scenes/bh-mway.grt"

sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 -50 0 0 ANGLES VEC3 0 90 0 FOV 40 ;"
sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 5000 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
