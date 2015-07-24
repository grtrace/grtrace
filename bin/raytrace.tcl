configset "ResolutionX" 800
configset "ResolutionY" 600
configset "Samples" 4
configset "CameraType" "linear"
configset "CameraOptions" "-x 10 -f 45"
#configset "CameraOptions" "-x 10"

loadTexture "\rLoaded \033\[0m\033\[01;31mMaria\033\[0m from fundusz" textures/photo.png
addobject .light1 -t pointlight -x0 -y-1.5 -z10 -r0.1 -g0 -b0.1
addobject .plane1 -t plane -c a -x0 -y-2 -z30 -a90 -b90
addobject .sph1 -t sphere -x0 -y5 -z10 -r5
#addobject .sph2 -t sphere -x0 -y0 -z5 -r1
#addobject .sph3 -t sphere -x-1 -y0 -z7 -r1.5
#addobject .sph4 -t sphere -x0 -y1 -z7 -r1.5
#addobject .sph5 -t sphere -x0 -y-1 -z7 -r1.5
#addobject .sph6 -t sphere -x0 -y0 -z6 -r1.5
#configset "CameraZ" -10
configset "CameraPitch" 0
configset "CameraYaw" 0
configset "CameraRoll" 180
#configset "CameraOptions" "-x 10"
puts "Tcl script finished"
