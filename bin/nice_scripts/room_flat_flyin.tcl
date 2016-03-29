set Folder "out_flyroom"
file mkdir "$Folder"
configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1

#DEFINE cameraOrigin VEC3 -0.9 0.8 -14.6 ;
set TarX -0.9
set TarY 0.8
set TarZ -14.6
set BegX -0.9
set BegY 0.8
set BegZ -30
set Iterations 60

loadScene "scenes/_common.grt"
loadScene "scenes/blueroom.grt"
sceneCmd "SETSPACE FLAT ;"
sceneCmd "SETCAMERA LINEAR ORIGIN cameraOrigin ANGLES cameraAngles FOV 30 ;"

puts "Tcl config finished"

for {set Iter 0} {$Iter <= $Iterations} {incr Iter} {
  puts "Frame $Iter/$Iterations"
  set CI [expr "$Iter.0/$Iterations"]
  set XI [expr "1.0-$CI"]
  set X [expr "$XI*$BegX + $CI*$TarX"]
  set Y [expr "$XI*$BegY + $CI*$TarY"]
  set Z [expr "$XI*$BegZ + $CI*$TarZ"]
  sceneCmd "ZEROCAMERA ;"
  sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 $X $Y $Z ANGLES cameraAngles FOV 30 ;"
  configSet "OutputFile" [format "$Folder/room_flat_%04d.png" $Iter]
  doTrace
  waitForTrace
}

#doTrace
#waitForTrace



puts "Tcl script finished"
