configSet "ResolutionX" 900
configSet "ResolutionY" 900
configSet "Samples" 1
configSet "OutputFile" "room_flat.png"

loadScene "scenes/_common.grt"
#loadScene "scenes/blueroom.grt"
loadScene "scenes/sky-box-mway.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN cameraOrigin ANGLES cameraAngles FOV 30 ;"
sceneCmd "SETSPACE FLAT ;"

puts "Tcl config finished"
doTrace
waitForTrace
#dbgTrace
puts "Tcl script finished"
