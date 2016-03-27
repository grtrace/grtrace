configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "OutputFile" "checker_board_plane_bh_schwarzschild.png"

loadScene "scenes/_common.grt"
loadScene "scenes/checkerboard.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0.000001 0.000001 -10 ANGLES VEC3 0 0 45 FOV FLOAT 45 ;"
sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 600 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
