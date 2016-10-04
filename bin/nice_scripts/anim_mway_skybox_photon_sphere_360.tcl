set Folder "out_mway_skybox_photon_sphere_360"
file mkdir "$Folder"
set StartYaw 0
set EndYaw 360
set Iterations 20

configSet "ResolutionX" 200
configSet "ResolutionY" 200
configSet "Samples" 1

loadScene "scenes/_common.grt"
loadScene "scenes/sky-box-mway.grt"
sceneCmd "SETSPACE SKYBOXANALYTIC SCHWARZSCHILD STEPS 500 STEPPARAM 0.1 MASS 1 ORIGIN vec3.0 ;"

puts "Tcl config finished"

for {set Iter 0} {$Iter <= $Iterations} {incr Iter} {
  puts "Frame $Iter/$Iterations"
  set CI [expr "$Iter.0/$Iterations"]
  set XI [expr "1.0-$CI"]
  set YAW [expr "$XI*$StartYaw + $CI*$EndYaw"]
  sceneCmd "ZEROCAMERA ;"
  sceneCmd "SETCAMERA LINEAR ORIGIN VEC3 20 0 0 ANGLES VEC3 0 $YAW 180 FOV 30 ;"
  configSet "OutputFile" [format "$Folder/room_flat_%04d.png" $Iter]
  doTrace
  waitForTrace
}

#doTrace
#waitForTrace



puts "Tcl script finished"
