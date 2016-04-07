set FOLDER "out_mway_flat"
file mkdir "$FOLDER"
set POS_MIN -35
set POS_MAX 35	
set ITERATIONS 10

configSet "ResolutionX" 700
configSet "ResolutionY" 700
configSet "Samples" 1

loadScene "scenes/_common.grt"
loadScene "scenes/flat-mway.grt"

sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 -50 0 0 ANGLES VEC3 0 90 0 FOV 40 ;"
sceneCmd "SETSPACE FLAT ;"

puts "Tcl config finished"

for {set Iter 0} {$Iter <= $ITERATIONS} { incr Iter } {
	set pos [expr "$POS_MIN + (($POS_MAX-$POS_MIN)*$Iter.0)/$ITERATIONS"]
	puts "Frame $Iter/$ITERATIONS (x=0 y=z=$pos)"

	sceneCmd "ZEROSPACE ;"
	sceneCmd "MODIFYOBJ sph1 MATERIAL .black CENTER VEC3 0 $pos $pos RADIUS radius ;"
	sceneCmd "SETSPACE FLAT ;"

	configSet "OutputFile" [format "$FOLDER/img%03d.png" $Iter]
  	doTrace
  	waitForTrace
}

puts "Tcl script finished"