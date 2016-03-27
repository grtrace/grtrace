configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "OutputFile" "checker_board_plane_flat.png"

loadScene "scenes/_common.grt"
loadScene "scenes/checkerboard.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0.000001 0.000001 -10 ANGLES VEC3 0 0 45 FOV FLOAT 45 ;"
sceneCmd "SETSPACE FLAT ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
