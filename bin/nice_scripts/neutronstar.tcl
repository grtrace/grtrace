configSet "ResolutionX" 1200
configSet "ResolutionY" 1200
configSet "Samples" 2
configSet "OutputFile" "raytrace_neutronstar_bh_schw.png"

loadScene "scenes/_common.grt"
loadScene "scenes/neutronstar.grt"

puts "Tcl config finished"
doTrace
waitForTrace
puts "Tcl script finished"
