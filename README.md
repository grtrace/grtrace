### GRTrace
General Relativity rayTracer
A scientific project done by 2 high school students - Jakub Szewczyk and Grzegorz Uriasz.

This is an implementation of the raytracing algorithm we have developed, the rays are casted in a curved spacetime,
which is specified by either an analytic metric description (e.g. [Kerr metric](source/metric/initiators/kerr.d)) or a 
numeric one (not yet implemented). The path is traced by numerically integrating the 0th geodesic equation using the Runge-Kutta
method of 4th order, curving of light rays and gravitational Doppler effect are taken into account. GRTrace allows to generate
a full image from a specified perspective or to trace single rays and visualise them in a visual helper, implemented as an OpenGL window.

## Usage
Compile the project using dub and either dmd or ldc2. Command line arguments are documented when the command `grtrace -h` is run,
the most important modes of the program are:
 * Raytracing according to a script: `grtrace -s accretion_bh.tcl`
 * Fast approximation (traces every 25th pixel) according to a script: `grtrace -f -s accretion_bh.tcl`
 * Raytracing, then running the visual ray inspector: `grtrace -d -s accretion_bh.tcl`
 * Running just the visual inspector: `grtrace -n -d -s accretion_bh.tcl`
GRTrace can make use of multiple processor cores (number of threads controlled by the `-t/--threads` switch) and a GPU unit for acceleration (not yet implemented).
Scene descriptions are two-part: the objects and metric are described in a custom scripting language,
the list of commands is in the file [docs/scenecommands.txt](docs/scenecommands.txt) and the main raytracing process is controlled by a Tcl script,
specified by the `-s` switch, which can for example schedule multiple raytraces in a row, creating an animation. Multiple sample scripts are included in
the `bin` and `bin/nice_scripts` folders.

## Applications
This program can be used in numeric relativity simulations for the purposes of visualising new metrics and researching their effect on light, but it
can also aid in education, by allowing to experiment with curved spacetimes on a personal computer, because the algorithms are optimized for running
on single machines with a multi-core CPU and preferably a GPU. Specially raytraced transformation grids can also help in astronomy to "undo" the
deformations of images done by massive celestial bodies and clusters of objects.
