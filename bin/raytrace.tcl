configset "ResolutionX" 800
configset "ResolutionY" 600
configset "Samples" 2
#configset "WorldSpace" "deflect"
configset "SpaceConfig" ""
configset "CameraType" "linear"
configset "CameraOptions" "-x 10 -f 45"

loadTexture .tex1 textures/earth.png
loadTexture .tex2 textures/stone.png

addMaterial .mat1 -D -d 1.0,1.0,1.0 -t .tex2 -f b
addMaterial .mate -D -d 1.0,1.0,1.0 -t .tex1 -f b

addobject .light1 -t pointlight -p 0,0,0 -c 1.0,1.0,1.0
addobject .lighta -t pointlight -p 0,0,8 -c 1,1,1
#addobject .light2 -t pointlight -p 0,0,-1000 -c 1,1,1

addobject .plane1 -m .mat1 -t texplane -c a -o 0,2,0 -a90 -b45 -F 1,2,0 -S 0,2,0 -G0 -H0 -I1 -J1
addobject .plane2 -m .mat1 -t texplane -c a -o 0,2,0 -a90 -b-45 -F 1,2,0 -S 0,2,0 -G0 -H0 -I1 -J1
addobject .plane3 -m .mat1 -t texplane -c a -o 0,-2,0 -a90 -b-90 -F 1,-2,0 -S 0,-2,0 -G0 -H0 -I1 -J1
#addobject .sph1 -m .mate -t sphere -c 0,0,10 -r 1

#configset "CameraZ" -10
configset "CameraPitch" 0
configset "CameraYaw" 0
configset "CameraRoll" 0
#configset "CameraOptions" "-x 10"
puts "Tcl script finished"

