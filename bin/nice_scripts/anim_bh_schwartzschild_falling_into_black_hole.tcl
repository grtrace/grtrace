set Folder "out_bh_schwartzschild_falling_into_black_hole"
file mkdir "$Folder"
configSet "ResolutionX" 200
configSet "ResolutionY" 200
configSet "Samples" 1

loadScene "scenes/_common.grt"
loadScene "scenes/sky-box-mway.grt"
sceneCmd "SETSPACE SKYBOXANALYTIC SCHWARZSCHILD STEPS 1000 STEPPARAM 0.1 MASS 1 ORIGIN vec3.0 ;"

#DEFINE cameraOrigin VEC3 -0.9 0.8 -14.6 ;
#1000->100 10
#100->20 10
#20->5 10
#5->3 20
#3->2 20
set EndX -2
set BegX -3
set Iterations 20
puts "Tcl config finished"

for {set Iter 0} {$Iter <= $Iterations} {incr Iter} {
  puts "Frame $Iter/$Iterations"
  set CI [expr "$Iter.0/$Iterations"]
  set XI [expr "1.0-$CI"]
  set X [expr "$XI*$BegX + $CI*$EndX"]
  sceneCmd "ZEROCAMERA ;"
  sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 $X 0 0 ANGLES VEC3 0 -45 180 FOV 30 ;"
  configSet "OutputFile" [format "$Folder/out_%04.4f.png" $X]
  doTrace
  waitForTrace
}

#doTrace
#waitForTrace



puts "Tcl script finished"
