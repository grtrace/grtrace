configSet "ResolutionX" 800
configSet "ResolutionY" 600
configSet "Samples" 1
configSet "OutputFile" "clasic_3_spheres.png"

loadScene "scenes/_common.grt"
loadScene "scenes/classicspheres.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0 0 0 ANGLES VEC3 0 0 0 FOV 45 ;"
sceneCmd "SETSPACE FLAT ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
