module scriptconfig;

import std.string, std.array, std.stdio, std.variant, std.conv, std.getopt;
import tcltk.tcl;
import config;
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

alias ConfigValue = Algebraic!(inump, unump, fpnump, string*);
private ConfigValue[string] cfgOptions;
public __gshared Tcl_Interp* tcl;

private string tclToStr(const(Tcl_Obj*) o) nothrow
{
	const(char)* cstr;
	int len;
	cstr = Tcl_GetStringFromObj(cast(Tcl_Obj*) o, &len);
	return cstr[0 .. len].idup;
}

void InitScripting(string arg0)
{
	Tcl_FindExecutable(arg0.toStringz());
	tcl = Tcl_CreateInterp();
	Tcl_Init(tcl);
	Tcl_CreateObjCommand(tcl, "loadGUI", &tclLoadGUI, null, null);
	Tcl_CreateObjCommand(tcl, "makeScene", &tclMakeScene, null, null);
	Tcl_CreateObjCommand(tcl, "dbgTrace", &tclDbgTrace, null, null);
	Tcl_CreateObjCommand(tcl, "doTrace", &tclDoTrace, null, null);
	Tcl_CreateObjCommand(tcl, "waitForTrace", &tclFinishTrace, null, null);
	Tcl_CreateObjCommand(tcl, "configSet", &tclConfigSet, null, null);
	Tcl_CreateObjCommand(tcl, "addObject", &tclAddObject, null, null);
	Tcl_CreateObjCommand(tcl, "loadTexture", &tclLoadTexture, null, null);
	Tcl_CreateObjCommand(tcl, "addMaterial", &tclAddMaterial, null, null);

	mixin(ConfigMixin("ResolutionX"));
	mixin(ConfigMixin("ResolutionY"));

	mixin(ConfigMixin("Samples"));
	mixin(ConfigMixin("WorldSpace"));
	mixin(ConfigMixin("SpaceConfig"));
	mixin(ConfigMixin("CameraType"));
	mixin(ConfigMixin("CameraX"));
	mixin(ConfigMixin("CameraY"));
	mixin(ConfigMixin("CameraZ"));
	mixin(ConfigMixin("CameraPitch"));
	mixin(ConfigMixin("CameraYaw"));
	mixin(ConfigMixin("CameraRoll"));
	mixin(ConfigMixin("CameraOptions"));
	mixin(ConfigMixin("OutputFile"));
	mixin(ConfigMixin("MetricOptions"));
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
		throw new Exception(
			"Tcl error " ~ text(Tcl_GetErrorLine(tcl)) ~ " " ~ Tcl_GetStringResult(tcl).text());
	}
}

extern (C) int tclLoadGUI(ClientData clientData, Tcl_Interp* interp, int objc,
	const(Tcl_Obj*)* objv) nothrow
{
	Tk_Init(interp);
	return TCL_OK;
}

extern (C) int tclMakeScene(ClientData clientData, Tcl_Interp* interp, int objc,
	const(Tcl_Obj*)* objv) nothrow
{
	try
	{
		import scene.raymgr : Raytracer;

		auto space = CreateSpace(cfgWorldSpace);
		SetupCamera(cfgCameraType, vectorf(cfgCameraX, cfgCameraY, cfgCameraZ),
			cfgCameraPitch, cfgCameraYaw, cfgCameraRoll, cfgCameraOptions);
		foreach (name, object; cfgObjects)
		{
			space.AddObject(object);
			if (cfgVerbose)
				writeln("Added " ~ name ~ " ", object);
		}
		foreach (name, object; cfgLights)
		{
			space.AddLight(object);
			if (cfgVerbose)
				writeln("Added " ~ name);
		}
		cfgSpace = cast(shared(WorldSpace))(space);
		Raytracer.setSpace(space);
		FinalizeObjects();
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
		if (cfgTraceStart == cfgTraceEnd)
		{
			atomicOp!"+="(cfgTraceStart, 1);
			send(renderTid, true);
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
	while (cfgTraceStart > cfgTraceEnd)
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
		else if (cv.peek!(fpnump)() !is null)
		{
			double v;
			if (Tcl_GetDoubleFromObj(interp, cast(Tcl_Obj*) objv[2], &v) == TCL_ERROR)
			{
				return TCL_ERROR;
			}
			*(cv.get!(fpnump)) = cast(fpnum) v;
		}
		else
		{
			long v;
			if (Tcl_GetLongFromObj(interp, cast(Tcl_Obj*) objv[2], &v) == TCL_ERROR)
			{
				return TCL_ERROR;
			}
			if (cv.peek!(inump)() !is null)
			{
				*(cv.get!(inump)) = cast(inum) v;
			}
			else
			{
				*(cv.get!(unump)) = cast(unum) v;
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

void AddConfig(T)(string name, T val) if (is(T == unump) || is(T == inump)
		|| is(T == string*) || is(T == fpnump))
{
	cfgOptions[name] = val;
}

string ConfigMixin(string name)
{
	return `AddConfig("` ~ name ~ `",&cfg` ~ name ~ `);`;
}

extern (C) int tclAddObject(ClientData clientData, Tcl_Interp* interp, int objc,
	const(Tcl_Obj*)* objv) nothrow
{
	string[] args;
	string tar;
	if (objc < 2)
	{
		Tcl_WrongNumArgs(interp, objc, objv, "Needs at least 1 argument!");
		return TCL_ERROR;
	}
	for (int i = 1; i < objc; i++)
	{
		args ~= tclToStr(objv[i]);
	}
	try
	{
		string mat_name;
		string otype, oname;
		bool isTransformed = false;
		oname = args[0];
		getopt(args, std.getopt.config.passThrough,
			std.getopt.config.caseSensitive, "type|t", &otype,
			"transformed|T", &isTransformed, "material|m", &mat_name);

		if (mat_name == "" && otype != "pointlight" && otype != "accretion"
				&& otype != "texaccretion")
			throw new Exception("Most objects must have materials!");
		if (mat_name != "" && otype == "pointlight")
			throw new Exception("Lights can't have materials!");

		if (oname in cfgObjects)
		{
			throw new Exception("Object named " ~ oname ~ " already exists in the object list!");
		}
		Renderable obj;
		switch (otype)
		{
		case "sphere":
			obj = new Sphere();
			break;
		case "plane":
			obj = new Plane();
			break;
		case "texplane":
			obj = new TexturablePlane();
			break;
		case "triangle":
			obj = new Triangle();
			break;
		case "textriangle":
			obj = new TexturableTriangle();
			break;
		case "accretion":
			obj = new AccretionDisc();
			break;
		case "texaccretion":
			obj = new TexturedAccretionDisc();
			break;
		case "pointlight":
			if (oname in cfgLights)
			{
				throw new Exception("Light named " ~ oname ~ " already exists in the light list!");
			}
			cfgLights[oname] = new PointLight();
			cfgLights[oname].setName(oname);
			cfgLights[oname].setupFromOptions(args);
			return TCL_OK;
		default:
			throw new Exception("Wrong object type " ~ otype);
		}
		obj.setName(oname);
		if (isTransformed)
		{
			Renderable o2 = new Transformed(obj);
			o2.setupFromOptions(args);
			cfgObjects[oname] = o2;
			cfgObjectsMaterialNames[o2] = mat_name;
		}
		else
		{
			obj.setupFromOptions(args);
			cfgObjects[oname] = obj;
			cfgObjectsMaterialNames[obj] = mat_name;
		}
	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "\0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

extern (C) int tclLoadTexture(ClientData clientData, Tcl_Interp* interp,
	int objc, const(Tcl_Obj*)* objv) nothrow
{
	string[] args;
	if (objc != 3)
	{
		Tcl_WrongNumArgs(interp, objc, objv, "loadTexture has only 2 arguments!");
		return TCL_ERROR;
	}

	for (int i = 1; i < objc; i++)
	{
		args ~= tclToStr(objv[i]);
	}

	try
	{
		if (args[0] in cfgTextures)
		{
			throw new Exception("Texture named " ~ args[0] ~ " already exists in the texture list!");
		}
		else
		{
			cfgTextures[args[0]] = ReadImage(args[1]);

			if (cfgVerbose)
				writeln("Loaded texture " ~ args[0] ~ " from: " ~ args[1]);
		}
	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "\0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

Color colorString(string str)
{
	return str.toLower().predSwitch!("a==b")("", Colors.Black, "black",
		Colors.Black, "white", Colors.White, "red", Colors.Red, "green",
		Colors.Green, "blue", Colors.Blue, "cyan", Colors.Cyan, "magenta",
		Colors.Magenta, "yellow", Colors.Yellow, {
		fpnum[] components = [0.0, 0.0, 0.0];
		str.filter!((c) => ((!isWhite(c))))().array().splitter(',').map!((a) => to!fpnum(a)).copy(
			components);
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
		str.filter!((c) => ((!isWhite(c))))().array().splitter(',').map!((a) => to!fpnum(a)).copy(
			components);
		return vectorf(components[0], components[1], components[2]);
	}());
}

extern (C) int tclAddMaterial(ClientData clientData, Tcl_Interp* interp,
	int objc, const(Tcl_Obj*)* objv) nothrow
{
	string[] args;
	if (objc < 2)
	{
		Tcl_WrongNumArgs(interp, objc, objv, "addMaterial needs at least 1 argument!");
		return TCL_ERROR;
	}

	for (int i = 1; i < objc; i++)
	{
		args ~= tclToStr(objv[i]);
	}

	string mname = args[0];

	try
	{
		if (mname in cfgMaterials)
		{
			throw new Exception("Material named " ~ mname ~ " already exists in the material list!");
		}

		Material newMat = new Material();

		string textureName;
		string texturePath;
		string diffuseString;
		string emissionString;
		dchar filtering;
		bool isDiffuse;
		fpnum lambda;

		getopt(args, std.getopt.config.passThrough,
			std.getopt.config.caseSensitive, "texture_name|t", &textureName,
			"texture_filtering|f", &filtering, "lambda|l", &lambda,
			"is_diffuse|D", &isDiffuse, "diffuse_color|d", &diffuseString,
			"emision_color|e", &emissionString);

		newMat.is_diffuse = isDiffuse;

		newMat.diffuse_color = colorString(diffuseString);

		if (std.math.isFinite(lambda))
		{
			newMat.emission_wave_length = lambda;
			newMat.emission_color = GetSpectrumColor(lambda);
		}
		else
		{
			newMat.emission_color = colorString(emissionString);
		}

		newMat.setFiltering(filtering.toLower.predSwitch!("a==b")('n',
			&FilteringTypes.NearestNeightbour, 'b',
			&FilteringTypes.BilinearFiltering, &FilteringTypes.NearestNeightbour));

		cfgMaterials[mname] = newMat;
		cfgMaterialsTextureNames[newMat] = textureName;

		if (cfgVerbose)
			writeln("Added material: " ~ mname);

	}
	catch (Exception e)
	{
		Tcl_AppendResult(interp, ("D exception " ~ e.msg ~ "0").ptr, null);
		return TCL_ERROR;
	}
	return TCL_OK;
}

void FinalizeObjects()
in
{
	assert(cfgMaterials.length == cfgMaterialsTextureNames.length);
	assert(cfgObjects.length == cfgObjectsMaterialNames.length);
}
body
{
	foreach (mat; cfgMaterials)
	{
		if (cfgMaterialsTextureNames[mat] != "" && cfgMaterialsTextureNames[mat] in cfgTextures)
		{
			mat.texture = cfgTextures[cfgMaterialsTextureNames[mat]];
		}
	}

	foreach (obj; cfgObjects)
	{
		if (cfgObjectsMaterialNames[obj] != "" && cfgObjectsMaterialNames[obj] in cfgMaterials)
		{
			obj.material = cfgMaterials[cfgObjectsMaterialNames[obj]];
		}
	}
}
