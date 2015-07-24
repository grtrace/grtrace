configset "ResolutionX" 800
configset "ResolutionY" 600
configset "Samples" 1
configset "CameraType" "linear"
configset "CameraOptions" "-x 10 -f 45"
#configset "CameraOptions" "-x 10"

loadTexture .tex1 textures/photo.png
addobject .light1 -t pointlight -x0 -y0 -z0 -r1 -g1 -b1
addobject .plane1 -m .mat1 -t texplane -c a -x0 -y2 -z0 -a90 -b90 -A1 -B2 -C0 -D0 -E2 -F0 -G0 -H0 -I1 -J1
addobject .sph1 -m .mat1 -t sphere -x0 -y0 -z2 -r1
addMaterial .mat1 -D -d 1.0,1.0,1.0 -t .tex1 -f b
#addobject .sph2 -t sphere -x0 -y0 -z5 -r1
#addobject .sph3 -t sphere -x-1 -y0 -z7 -r1.5
#addobject .sph4 -t sphere -x0 -y1 -z7 -r1.5
#addobject .sph5 -t sphere -x0 -y-1 -z7 -r1.5
#addobject .sph6 -t sphere -x0 -y0 -z6 -r1.5
#configset "CameraZ" -10
configset "CameraPitch" 0
configset "CameraYaw" 0
configset "CameraRoll" 0
#configset "CameraOptions" "-x 10"
puts "Tcl script finished"
