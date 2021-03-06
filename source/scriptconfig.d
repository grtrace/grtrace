module scriptconfig;

import std.string, std.array, std.stdio, std.variant, std.conv, std.getopt, std.uni, std.utf;
import tcltk.tcl;
import grtrace;
import scene.objects;
import scene.materials.material;
import image.memory;
import image.imgio;
import image.color;
import image.spectrum;
import math.vector;
import scene.scenemgr, scene.camera;
import std.uni, std.range, std.algorithm;
import tcltk.tk;
import std.concurrency : send;
import core.thread : Thread;
import core.time : dur;
import core.atomic;
import metric;

alias ConfigValue = Algebraic!(inum*, unum*, fpnum*, string*, Integrator*);
private ConfigValue[string] cfgOptions;
public __gshared Tcl_Interp* tcl;
private __gshared GRTrace* grt;

private string tclToStr(const(Tcl_Obj*) o) nothrow
{
	const(char)* cstr;
	int len;
	cstr = Tcl_GetStringFromObj(cast(Tcl_Obj*) o, &len);
	return cstr[0 .. len].idup;
}

void InitScripting(GRTrace* grt, string arg0)
{
	.grt = grt;
	Tcl_FindExecutable(arg0.toStringz());
	tcl = Tcl_CreateInterp();
	Tcl_Init(tcl);
	Tcl_CreateObjCommand(tcl, "loadGUI", &tclLoadGUI, null, null);
	Tcl_CreateObjCommand(tcl, "loadScene", &tclLoadScene, null, null);
	Tcl_CreateObjCommand(tcl, "sceneCmd", &tclSceneCmd, null, null);
	Tcl_CreateObjCommand(tcl, "dbgTrace", &tclDbgTrace, null, null);
	Tcl_CreateObjCommand(tcl, "doTrace", &tclDoTrace, null, null);
	Tcl_CreateObjCommand(tcl, "waitForTrace", &tclFinishTrace, null, null);
	Tcl_CreateObjCommand(tcl, "configSet", &tclConfigSet, null, null);

	mixin(ConfigMixin("ResolutionX"));
	mixin(ConfigMixin("ResolutionY"));
	mixin(ConfigMixin("Integrator"));

	mixin(ConfigMixin("Samples"));
	mixin(ConfigMixin("OutputFile"));
	mixin(ConfigMixin("MaxDepth"));
}

shared static ~this()
{
	if (tcl !is null)
	{
		Tcl_DeleteInterp(tcl);
	}
}

void DoScript(string path)
{
	int res = Tcl_EvalFile(tcl, path.toStringz());
	if (res != TCL_OK)
	{
		throw new Exception("Tcl error " ~ text(
				Tcl_GetErrorLine(tcl)) ~ " " ~ Tcl_GetStringResult(tcl).text());
	}
}

extern (C) int tclLoadGUI(ClientData clientData, Tcl_Interp* interp, int objc,
		const(Tcl_Obj*)* objv) nothrow
{
	Tk_Init(interp);
	return TCL_OK;
}

import scene.creator;

__gshared SceneDescription sceneParser;

extern (C) int tclLoadScene(ClientData clientData, Tcl_Interp* interp, int objc,
		const(Tcl_Obj*)* objv) nothrow
{
	try
	{
		import scene.raymgr : Raytracer;

		if (objc != 2)
		{
			Tcl_WrongNumArgs(interp, objc, objv,
					"loadScene requires a path to the scene description");
			return TCL_ERROR;
		}
		string path = tclToStr(objv[1]);
		sceneParser.loadFromFile(grt, path);
	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "\0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

extern (C) int tclSceneCmd(ClientData clientData, Tcl_Interp* interp, int objc,
		const(Tcl_Obj*)* objv) nothrow
{
	try
	{
		import scene.raymgr : Raytracer;

		if (objc != 2)
		{
			Tcl_WrongNumArgs(interp, objc, objv, "sceneCmd requires a command");
			return TCL_ERROR;
		}
		string cmd = tclToStr(objv[1]);
		sceneParser.loadFromScript(grt, cmd, false);
	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "\0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

extern (C) int tclDbgTrace(ClientData clientData, Tcl_Interp* interp, int objc,
		const(Tcl_Obj*)* objv) nothrow
{
	try
	{
		import scene.raymgr : Raytracer;

		Raytracer.computeMultiThread();
		Raytracer.saveImage();
		Raytracer.cleanup();
	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "\0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

extern (C) int tclDoTrace(ClientData clientData, Tcl_Interp* interp, int objc,
		const(Tcl_Obj*)* objv) nothrow
{
	try
	{
		if (grt.config.traceStart == grt.config.traceEnd)
		{
			atomicOp!"+="((cast(shared) grt).config.traceStart, 1);
			send(grt.renderTid, true);
		}
	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "\0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

extern (C) int tclFinishTrace(ClientData clientData, Tcl_Interp* interp,
		int objc, const(Tcl_Obj*)* objv) nothrow
{
	while (grt.config.traceStart > grt.config.traceEnd)
	{
		Thread.sleep(dur!"msecs"(90));
	}
	return TCL_OK;
}

extern (C) int tclConfigSet(ClientData clientData, Tcl_Interp* interp, int objc,
		const(Tcl_Obj*)* objv) nothrow
{
	string tar;
	if (objc != 3)
	{
		Tcl_WrongNumArgs(interp, objc, objv, "configset has only 2 arguments!");
		return TCL_ERROR;
	}
	tar = tclToStr(objv[1]);
	ConfigValue* cvp = tar in cfgOptions;
	if (cvp is null)
	{
		Tcl_AppendResult(interp, "Trying to use nonexistant configvalue\0".ptr, null);
		return TCL_ERROR;
	}
	ConfigValue cv = *cvp;
	try
	{
		if (cv.peek!(string*)() !is null)
		{
			*(cv.get!(string*)) = tclToStr(objv[2]);
		}
		else if (cv.peek!(Integrator*)() !is null)
		{
			string V = tclToStr(objv[2]);
			*(cv.get!(Integrator*)) = to!Integrator(V);
		}
		else if (cv.peek!(fpnum*)() !is null)
		{
			double v;
			if (Tcl_GetDoubleFromObj(interp, cast(Tcl_Obj*) objv[2], &v) == TCL_ERROR)
			{
				return TCL_ERROR;
			}
			*(cv.get!(fpnum*)) = cast(fpnum) v;
		}
		else
		{
			long v;
			if (Tcl_GetLongFromObj(interp, cast(Tcl_Obj*) objv[2], &v) == TCL_ERROR)
			{
				return TCL_ERROR;
			}
			if (cv.peek!(inum*)() !is null)
			{
				*(cv.get!(inum*)) = cast(inum) v;
			}
			else
			{
				*(cv.get!(unum*)) = cast(unum) v;
			}
		}
	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "\0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

void AddConfig(T)(string name, T val)
		if (is(T == unum*) || is(T == inum*) || is(T == string*)
			|| is(T == fpnum*) || is(T == Integrator*))
{
	cfgOptions[name] = val;
}

string ConfigMixin(string name)
{
	return `AddConfig("` ~ name ~ `",&grt.config.`
		~ [toLower(cast(dchar) name[0])].toUTF8 ~ name[1 .. $] ~ `);`;
}

Color colorString(string str)
{
	return str.toLower().predSwitch!("a==b")("", Colors.Black, "black",
			Colors.Black, "white", Colors.White, "red", Colors.Red, "green",
			Colors.Green, "blue", Colors.Blue, "cyan", Colors.Cyan, "magenta",
			Colors.Magenta, "yellow", Colors.Yellow, {
				fpnum[] components = [0.0, 0.0, 0.0];
				str.filter!((c) => ((!isWhite(c))))().array().splitter(',')
					.map!((a) => to!fpnum(a)).copy(components);
				return Color(components[0], components[1], components[2]);
			}());
}

Vectorf vectorString(string str)
{
	ICamera cam = cast(ICamera)(WorldSpace.camera);
	return str.toLower().predSwitch!("a==b")("", vectorf(0, 0, 0), "up",
			cam.updir, "down", -cam.updir, "left", -cam.rightdir, "right",
			cam.rightdir, "front", cam.lookdir, "back", -cam.lookdir, {
				fpnum[] components = [0.0, 0.0, 0.0];
				str.filter!((c) => ((!isWhite(c))))().array().splitter(',')
					.map!((a) => to!fpnum(a)).copy(components);
				return vectorf(components[0], components[1], components[2]);
			}());
}
