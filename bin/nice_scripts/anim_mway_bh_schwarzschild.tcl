set FOLDER "new_out_mway_bh_schwarzschild"
file mkdir "$FOLDER"
set POS_MIN -35
set POS_MAX 0
set ITERATIONS 40

configSet "ResolutionX" 600
configSet "ResolutionY" 600
configSet "Samples" 1

loadScene "scenes/_common.grt"
loadScene "scenes/bh-mway.grt"

sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 -50 0 0 ANGLES VEC3 0 90 0 FOV 40 ;"
sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 5000 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ;"

puts "Tcl config finished"

for {set Iter 0} {$Iter <= $ITERATIONS} { incr Iter } {
	set pos [expr "$POS_MIN + (($POS_MAX-$POS_MIN)*$Iter.0)/$ITERATIONS"]
	puts "Frame $Iter/$ITERATIONS (x=0 y=z=$pos)"

	sceneCmd "ZEROSPACE ;"
	sceneCmd "SETSPACE ANALYTIC SCHWARZSCHILD STEPS 5000 STEPPARAM 0.1 MASS mass ORIGIN VEC3 0 $pos $pos ;"

	configSet "OutputFile" [format "$FOLDER/img%06.3f.png" $pos]
  	doTrace
  	waitForTrace
}

puts "Tcl script finished"
