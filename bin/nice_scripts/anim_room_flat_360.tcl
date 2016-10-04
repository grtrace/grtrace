set Folder "out-sky-box-mway-360"
file mkdir "$Folder"
configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1

#DEFINE cameraOrigin VEC3 -0.9 0.8 -14.6 ;
set StartYaw 0
set EndYaw 360
set Iterations 120

loadScene "scenes/_common.grt"
loadScene "scenes/sky-box-mway.grt"
sceneCmd "SETSPACE FLAT ;"
sceneCmd "SETCAMERA LINEAR ORIGIN cameraOrigin ANGLES cameraAngles FOV 30 ;"

puts "Tcl config finished"

for {set Iter 0} {$Iter <= $Iterations} {incr Iter} {
  puts "Frame $Iter/$Iterations"
  set CI [expr "$Iter.0/$Iterations"]
  set XI [expr "1.0-$CI"]
  set YAW [expr "$XI*$StartYaw + $CI*$EndYaw"]
  sceneCmd "ZEROCAMERA ;"
  sceneCmd "SETCAMERA LINEAR ORIGIN cameraOrigin ANGLES VEC3 0 $YAW 180 FOV 30 ;"
  configSet "OutputFile" [format "$Folder/room_flat_%04d.png" $Iter]
  doTrace
  waitForTrace
}

#doTrace
#waitForTrace



puts "Tcl script finished"
