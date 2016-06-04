set FOLDER "out_mway_bh_reissner_charging"
file mkdir "$FOLDER"
set CHARGE_MIN 0
set CHARGE_MAX 2
set ITERATIONS 20

configSet "ResolutionX" 700
configSet "ResolutionY" 700
configSet "Samples" 1

loadScene "scenes/_common.grt"
loadScene "scenes/bh-mway.grt"

sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 -50 0 0 ANGLES VEC3 0 90 0 FOV 40 ;"
sceneCmd "SETSPACE ANALYTIC REISSNER STEPS 5000 STEPPARAM 0.1 MASS 1 CHARGE 0 ORIGIN vec3.0 ;"

puts "Tcl config finished"

for {set Iter 0} {$Iter <= $ITERATIONS} { incr Iter } {
	set charge [expr "$CHARGE_MIN + (($CHARGE_MAX-$CHARGE_MIN)*$Iter.0)/$ITERATIONS"]
	puts "Frame $Iter/$ITERATIONS (q=$charge)"

	sceneCmd "ZEROSPACE ;"
	sceneCmd "SETSPACE ANALYTIC REISSNER STEPS 5000 STEPPARAM 0.1 MASS 1 CHARGE $charge ORIGIN VEC3 0 0 0 ;"

	configSet "OutputFile" [format "$FOLDER/img%03d.png" $Iter]
  	doTrace
  	waitForTrace
}

puts "Tcl script finished"
