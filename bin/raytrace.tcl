configset "ResolutionX" 800
configset "ResolutionY" 600
configset "Samples" 1
#configset "WorldSpace" "deflect"
configset "SpaceConfig" ""
configset "CameraType" "linear"
configset "CameraOptions" "-x 10 -f 45"

loadTexture .tex1 textures/photo.png

addMaterial .mat1 -D -d 1.0,1.0,1.0 -t .tex1 -f b
addMaterial .mate -D -e 1.0,0.0,0.0 -d 0.2,0.8,0.9 -t .tex1 -f b

addobject .light1 -t pointlight -x0 -y0 -z0 -r1 -g1 -b1
addobject .plane1 -m .mat1 -t texplane -c a -x0 -y2 -z0 -a90 -b90 -A1 -B2 -C0 -D0 -E2 -F0 -G0 -H0 -I1 -J1
#addobject .sph1 -m .mate -t sphere -x0 -y0 -z20 -r1

#configset "CameraZ" -10
configset "CameraPitch" 0
configset "CameraYaw" 0
configset "CameraRoll" 0
#configset "CameraOptions" "-x 10"
puts "Tcl script finished"
