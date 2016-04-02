set Folder "out_kerrspin"
file mkdir "$Folder"
configSet "ResolutionX" 128
configSet "ResolutionY" 128
configSet "Samples" 1
configSet "OutputFile" "$Folder/test.png"

set TarL 1.5
set BegL 1.1
set Iterations 4

loadScene "scenes/_common.grt"
loadScene "scenes/bhaccretion_violet.grt"
sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 0 -8 -40 ANGLES VEC3 -12 0 0 FOV 25 ;"
sceneCmd "SETSPACE ANALYTIC KERR STEPS 850 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ANGMOMENTUM 16 ;"

puts "Tcl config finished"

for {set Iter 0} {$Iter <= $Iterations} {incr Iter} {
  set CI [expr "$Iter.0/$Iterations"]
  set XI [expr "1.0-$CI"]
  set L [expr "$XI*$BegL + $CI*$TarL"]
  puts "Frame $Iter/$Iterations (L=$L)"
  sceneCmd "ZEROSPACE ;"
  sceneCmd "SETSPACE ANALYTIC KERR STEPS 850 STEPPARAM 0.1 MASS mass ORIGIN vec3.0 ANGMOMENTUM $L ;"
  configSet "OutputFile" [format "$Folder/img%03d.png" $Iter]
  doTrace
  waitForTrace
}

#doTrace
#waitForTrace

puts "Tcl script finished"
