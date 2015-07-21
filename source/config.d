module config;

alias fpnum = double;
alias inum = long;
alias unum = ulong;
alias fpnump = fpnum*;
alias inump = inum*;
alias unump = unum*;

bool cfgVerbose = false;
string cfgScript = "raytrace.tcl";
inum cfgResolutionX = 320;
inum cfgResolutionY = 240;

fpnum eps = 1e-9;

// physical constants
enum P : fpnum
{
	c = 1.0,
	G = 1.0,
	hd = 2.612e-70, // m^2
	MS = 1477, // m
	MZ = 0.004435, // m
	LS = 1.08e-26
}

