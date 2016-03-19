configSet "ResolutionX" 800
configSet "ResolutionY" 800
configSet "Samples" 1
configSet "WorldSpace" "test"
configSet "SpaceConfig" ""
configSet "CameraType" "linear"
configSet "CameraX" 0.000001
configSet "CameraY" 0.000001
configSet "CameraZ" -10
configSet "CameraPitch" 0
configSet "CameraYaw" 0
configSet "CameraRoll" 45
configSet "CameraOptions" "-f 45"
configSet "OutputFile" "checker_board_plane_bh_schwarzschild.png"
configSet "MetricOptions" "-t schwarzschild -m 0.5 -x 0 -y 0 -z 0 -d 0.1 -n 600"

loadTexture .tex1 textures/checkerBoard.png
addMaterial .mat_plane -D -d black -e white -t .tex1 -f n

addObject .plane1 -m .mat_plane -t texplane -c a -o 0,0,20 -a0 -b0 -F 1,0,20 -S 0,1,20 -G1 -H1 -I0 -J0 

addMaterial .mat_eh -D -e black -f b
addObject .sph1 -m .mat_eh -t sphere -c 0,0,0 -r 1

makeScene
puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
