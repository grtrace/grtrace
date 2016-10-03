configSet "ResolutionX" 400
configSet "ResolutionY" 400

configSet "Samples" 1
configSet "OutputFile" "room_bh_schwarzschild.png"

loadScene "scenes/_common.grt"
loadScene "scenes/blueroom.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN cameraOrigin ANGLES cameraAngles FOV 30 ;"
sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 500 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"
#doTrace
#waitForTrace
dbgTrace
puts "Tcl script finished"
