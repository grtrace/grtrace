module scriptconfig;

import std.string, std.array, std.stdio;
import tcltk.tcl;
//import tcltk.tk;

Tcl_Interp* tcl;

void InitScripting(string arg0)
{
	Tcl_FindExecutable(arg0.toStringz());
	tcl = Tcl_CreateInterp();
	Tcl_Init(tcl);
}

static ~this()
{
	Tcl_DeleteInterp(tcl);
}

void DoScript(string path)
{
	int res = Tcl_EvalFile(tcl, path.toStringz());
	if(res!=TCL_OK)
	{
		throw new Exception("Tcl error");
	}
}
