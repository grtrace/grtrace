module scriptconfig;

import std.string, std.array, std.stdio, std.variant, std.conv;
import tcltk.tcl;
import config;
//import tcltk.tk;

alias ConfigValue = Algebraic!(inump,unump,fpnump,string*);
private ConfigValue[string] cfgOptions;
public __gshared Tcl_Interp* tcl;


void InitScripting(string arg0)
{
	Tcl_FindExecutable(arg0.toStringz());
	tcl = Tcl_CreateInterp();
	Tcl_Init(tcl);
	Tcl_CreateObjCommand(tcl, "configset", &tclConfigSet, null, null);

	mixin(ConfigMixin("ResolutionX"));
	mixin(ConfigMixin("ResolutionY"));

	mixin(ConfigMixin("Samples"));
	mixin(ConfigMixin("WorldSpace"));
	mixin(ConfigMixin("CameraType"));
	mixin(ConfigMixin("CameraX"));
	mixin(ConfigMixin("CameraY"));
	mixin(ConfigMixin("CameraZ"));
	mixin(ConfigMixin("CameraPitch"));
	mixin(ConfigMixin("CameraYaw"));
	mixin(ConfigMixin("CameraRoll"));
	mixin(ConfigMixin("CameraOptions"));
	mixin(ConfigMixin("OutputFile"));
}

shared static ~this()
{
	Tcl_DeleteInterp(tcl);
}

void DoScript(string path)
{
	int res = Tcl_EvalFile(tcl, path.toStringz());
	if(res!=TCL_OK)
	{
		throw new Exception("Tcl error "~text(Tcl_GetErrorLine(tcl))~" "~Tcl_GetStringResult(tcl).text());
	}
}

extern(C) int tclConfigSet(ClientData clientData, Tcl_Interp* interp, int objc, const(Tcl_Obj*)* objv) nothrow
{
	string tar;
	const(char)* tarcs;
	int tarcl;
	if(objc!=3)
	{
		Tcl_WrongNumArgs(interp, objc, objv, "configset has only 2 arguments!");
		return TCL_ERROR;
	}
	tarcs = Tcl_GetStringFromObj(cast(Tcl_Obj*)objv[1],&tarcl);
	tar = tarcs[0..tarcl].idup;
	ConfigValue* cvp = tar in cfgOptions;
	if(cvp is null)
	{
		Tcl_AppendResult(interp, "Trying to use nonexistant configvalue\0".ptr,null);
		return TCL_ERROR;
	}
	ConfigValue cv = *cvp;
	try
	{
		if(cv.peek!(string*)()!is null)
		{
			const(char)* valcs;
			int valcl;
			valcs = Tcl_GetStringFromObj(cast(Tcl_Obj*)objv[2],&valcl);
			*(cv.get!(string*)) = cast(string)(valcs[0..valcl].idup);
		}
		else if(cv.peek!(fpnump)()!is null)
		{
			double v;
			if(Tcl_GetDoubleFromObj(interp, cast(Tcl_Obj*)objv[2], &v)==TCL_ERROR)
			{
				return TCL_ERROR;
			}
			*(cv.get!(fpnump)) = cast(fpnum)v;
		}
		else
		{
			long v;
			if(Tcl_GetLongFromObj(interp, cast(Tcl_Obj*)objv[2], &v)==TCL_ERROR)
			{
				return TCL_ERROR;
			}
			if(cv.peek!(inump)()!is null)
			{
				*(cv.get!(inump)) = cast(inum)v;
			}
			else
			{
				*(cv.get!(unump)) = cast(unum)v;
			}
		}
	}
	catch(Exception e)
	{
		Tcl_AppendResult(interp, ("D exception "~e.msg~"\0").ptr,null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

void AddConfig(T)(string name, T val) if (is(T==unump) || is(T==inump) || is(T==string*) || is(T==fpnump))
{
	cfgOptions[name] = val;
}

string ConfigMixin(string name)
{
	return `AddConfig("`~name~`",&cfg`~name~`);`;
}
