configset "ResolutionX" 800
configset "ResolutionY" 600
configset "Samples" 2
configset "CameraType" "linear"
configset "CameraOptions" "-x 10 -f 45"
addobject .light1 -t pointlight -x0 -y5 -z-5 -r0.9 -g0.1 -b0.1
addobject .light2 -t pointlight -x0 -y-6 -z5 -r0.7 -g0.4 -b0.1
addobject .light3 -t pointlight -x0 -y7 -z-5 -r0.2 -g0.1 -b0.6
addobject .light4 -t pointlight -x0 -y-8 -z5 -r0.1 -g0.6 -b0.6
addobject .light5 -t pointlight -x0 -y9 -z-5 -r0.4 -g0.6 -b0.6
addobject .sph1 -t sphere -x7 -y0 -z0 -r2
#addobject .sph2 -t sphere -x0 -y0 -z5 -r1
#addobject .sph3 -t sphere -x-1 -y0 -z7 -r1.5
#addobject .sph4 -t sphere -x0 -y1 -z7 -r1.5
#addobject .sph5 -t sphere -x0 -y-1 -z7 -r1.5
#addobject .sph6 -t sphere -x0 -y0 -z6 -r1.5
#configset "CameraZ" -10
configset "CameraPitch" 0
configset "CameraYaw" 90
configset "CameraRoll" 0
#configset "CameraOptions" "-x 10"
puts "Tcl script finished"
