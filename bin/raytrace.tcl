configSet "ResolutionX" 800
configSet "ResolutionY" 600
configSet "Samples" 1
#configSet "WorldSpace" "deflect"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraOptions" "-x 10 -f 45"

loadTexture .tex1 textures/photo.png

addMaterial .mat1 -D -d 1.0,1.0,1.0 -t .tex1 -f b

addObject .light1 -t pointlight -x0 -y0 -z0 -r1 -g1 -b1
addObject .plane1 -m .mat1 -t texplane -c a -x0 -y2 -z0 -a90 -b90 -A1 -B2 -C0 -D0 -E2 -F0 -G0 -H0 -I1 -J1
#addObject .sph1 -m .mat1 -t sphere -x0 -y0 -z20 -r1

#configSet "CameraZ" -10
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 0
#configSet "CameraOptions" "-x 10"
makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"