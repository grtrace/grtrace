configset "ResolutionX" 800
configset "ResolutionY" 600
configset "Samples" 4
configset "CameraType" "linear"
configset "CameraOptions" "-x 10 -f 60"
#configset "CameraOptions" "-x 10"
addobject .light2 -t pointlight -x0 -y11 -z0 -r0 -g0.8 -b0.3
#addobject .lightc -t pointlight -x0 -y0 -z0 -r0.7 -g0.55 -b0.4
addobject .plane1 -t plane -c a -x0 -y-2 -z30 -a90 -b90
addobject .sph1 -t sphere -x0 -y5 -z10 -r5
addobject .sph2 -t sphere -x7 -y5 -z10 -r1
addobject .sph3 -t sphere -x-7 -y5 -z10 -r1
#configset "CameraZ" -10
configset "CameraPitch" -10
configset "CameraYaw" 0
configset "CameraRoll" 180
#configset "CameraOptions" "-x 10"
puts "Tcl script finished"
