configset "ResolutionX" 512
configset "ResolutionY" 512
configset "Samples" 1
configset "WorldSpace" "deflect"
configset "SpaceConfig" ""
configset "CameraType" "linear"
configset "CameraOptions" "-x 10 -f 5"
#configset "CameraOptions" "-x 10"

#loadTexture .tex1 textures/photo.png
#addobject .light1 -t pointlight -x-10 -y0 -z0 -r1 -g0 -b0
#addobject .light2 -t pointlight -x0 -y-10 -z0 -r0 -g1 -b0
#addobject .light3 -t pointlight -x0 -y10 -z0 -r0 -g0 -b1
#addobject .lightw -t pointlight -x0 -y3000 -z2000 -r0 -g0 -b1
#addobject .lighta -t pointlight -x0 -y-3000 -z2000 -r0 -g1 -b0
#addobject .lightb -t pointlight -x3000 -y0 -z2000 -r1 -g0 -b1
#addobject .lightc -t pointlight -x-3000 -y0 -z2000 -r0 -g1 -b1
#addobject .lightd -t pointlight -x3000 -y3000 -z2000 -r0.5 -g0.5 -b0.5
addobject .light -t pointlight -x0 -y0 -z-10000 -r1 -g1 -b1
#addobject .plane1 -t plane -c a -x0 -y-10000 -z1000 -a90 -b90
addobject .sph1 -t sphere -x0 -y2000 -z2000 -r1000
#addobject .sph1 -t sphere -x0 -y0 -z0 -r1
configset "CameraZ" -100000
configset "CameraPitch" 0
configset "CameraYaw" 0
configset "CameraRoll" 180
#configset "CameraOptions" "-x 10"
puts "Tcl script finished"

