/// Scene creation&loading functions
module scene.creator;

import config;
import scene.raymgr;
import scene.scenemgr;
import std.typecons;
import std.variant;
import std.algorithm, std.range;
import std.math, std.conv;
import math.vector;
import image.color;
import image.spectrum;
import image.imgio;
import scene;
import scene.objects.interfaces;
import scene.objects;
import scene.materials;
import metric.initiators;
import scene.noneuclidean : PlaneDeflectSpace;
import metric.analytic : Analytic;
import metric.wrapper : WorldSpaceWrapper;
import scene.camera;

class SceneException : Exception
{
	@nogc @safe pure nothrow this(string msg, string file = __FILE__,
		size_t line = __LINE__, Throwable next = null)
	{
		super(msg, file, line, next);
	}

	@nogc @safe pure nothrow this(string msg, Throwable next,
		string file = __FILE__, size_t line = __LINE__)
	{
		super(msg, file, line, next);
	}
}

struct SceneDescription
{
	enum scriptHeader = "GRTRACE SCENE DESCRIPTION VERSION 1";
	SValue[string] defines;
	bool[string] modules;

	/**
	Populate the space with objects loaded from a script.
	Format: See docs/scenecommands.txt for specs
	**/
	void loadFromScript(string script, bool hasHeader = true)
	{
		size_t offset = 0;
		if (hasHeader)
		{
			if (script.length <= scriptHeader.length)
			{
				throw new SceneException("Script too short");
			}
			if (script[0 .. scriptHeader.length] != scriptHeader)
			{
				throw new SceneException("Script has invalid header");
			}
			offset = scriptHeader.length;
		}
		string sNoComs = split(script[offset .. $], '\n').filter!(a => !startsWith(a,
			"#")).join(" ");
		auto tokStream = splitter(sNoComs);
		string fetchToken()
		{
			string tok;
			do
			{
				if (tokStream.empty)
				{
					throw new SceneException("Unexpected EOF");
				}
				tok = tokStream.front;
				tokStream.popFront;
			}
			while (tok.length < 1);
			return tok;
		}

		fpnum fetchNumber()
		{
			string tok = fetchToken();
			return to!fpnum(tok);
		}

		void fetchEnd()
		{
			if (fetchToken() != ";")
			{
				throw new SceneException("Statements must end with a semicolon");
			}
		}

		SValue fetchValue()
		{
			string tok = fetchToken();
			fpnum x = 0.0, y = 0.0, z = 0.0;
			switch (tok)
			{
			case "FLOAT":
				return SValue(cast(SFloat) fetchNumber());
			case "WAVE":
				return SValue(cast(SWave) fetchNumber());
			case "VEC2":
				x = fetchNumber();
				y = fetchNumber();
				return SValue(SVec2(x, y));
			case "VEC3":
				x = fetchNumber();
				y = fetchNumber();
				z = fetchNumber();
				return SValue(SVec3(x, y, z));
			case "MAT4":
				SMat4 mat = SMat4.Zero;
				for (int i = 0; i < 16; i++)
				{
					mat[i] = fetchNumber();
				}
				return SValue(mat);
			case "COLOR":
				char[] hex = fetchToken().dup;
				long col = parse!(long)(hex, 16);
				z = (col & 0xFF) / 255.0;
				y = ((col >> 8) & 0xFF) / 255.0;
				x = ((col >> 16) & 0xFF) / 255.0;
				return SValue(SColor(x, y, z));
			default:
				SValue* val = tok in defines;
				if (val !is null)
				{
					return *val;
				}
				else
				{
					bool validNumber = true;
					int numDots = 0;
					foreach (dchar ch; tok)
					{
						if (ch == '-')
							continue;
						if (ch == '.')
						{
							numDots++;
							continue;
						}
						if ((ch < '0') || (ch > '9'))
						{
							validNumber = false;
							break;
						}
					}
					if (numDots > 1)
						validNumber = false;
					if (validNumber)
					{
						return SValue(SFloat(to!fpnum(tok)));
					}
					throw new SceneException("Undefined value " ~ tok);
				}
			}
		}

		void parseMaterial(ref Material m)
		{
			string tok;
			while ((tok = fetchToken()) != ";")
			{
				SValue arg;
				switch (tok)
				{
				case "DIFFUSE":
					arg = fetchValue();
					m.is_diffuse = true;
					if (arg.peek!(SColor) !is null)
					{
						m.diffuse_color = *(arg.peek!(SColor));
					}
					if (arg.peek!(SWave) !is null)
					{
						fpnum L = cast(fpnum)(*(arg.peek!(SWave)));
						m.diffuse_color = GetSpectrumColor(L);
					}
					if (arg.peek!(STexture) !is null)
					{
						string tid = cast(string)(*(arg.peek!(STexture)));
						m.texture = cfgTextures[tid];
					}
					break;
				case "EMIT":
					arg = fetchValue();
					if (arg.peek!(SColor) !is null)
					{
						m.emission_color = *(arg.peek!(SColor));
					}
					if (arg.peek!(SWave) !is null)
					{
						fpnum L = cast(fpnum)(*(arg.peek!(SWave)));
						m.emission_color = GetSpectrumColor(L);
						m.emission_wave_length = L;
					}
					break;
				case "FILTER":
					string T = fetchToken();
					switch (T)
					{
					case "NEAREST":
						m.setFiltering(&FilteringTypes.NearestNeightbour);
						break;
					case "LINEAR", "BILINEAR":
						m.setFiltering(&FilteringTypes.BilinearFiltering);
						break;
					default:
						throw new SceneException("Unsupported filtering type: " ~ T);
					}
					break;
				default:
					throw new SceneException("Unsupported material parameter " ~ tok);
				}
			}
		}

		SValue[string] fetchOptmap()
		{
			SValue[string] optMap;
			string key;
			while ((key = fetchToken()) != ";")
			{
				optMap[key] = fetchValue();
			}
			return optMap;
		}

		Renderable parseObject(string type, bool skipId = false)
		{
			string id;
			if (!skipId)
			{
				id = fetchToken();
				if (id in cfgObjects)
				{
					throw new SceneException("Object " ~ id ~ " already defined!");
				}
			}
			Renderable obj;
			switch (type)
			{
			case "TRANSFORMED":
				SValue tformV = fetchValue();
				SMat4 tform;
				if (tformV.peek!SMat4)
				{
					tform = tformV.get!SMat4;
				}
				else
				{
					throw new SceneException(
						"Transformed objects must have the first argument of type MAT4.");
				}
				Renderable internal = parseObject(fetchToken(), true);
				obj = new Transformed(internal, tform);
				obj.setName(id);
				cfgObjects[id] = obj;
				return obj;
			case "SPHERE":
				obj = new Sphere();
				break;
			case "PLANE":
				obj = new Plane();
				break;
			case "TEX.PLANE":
				obj = new TexturablePlane();
				break;
			case "TRIANGLE":
				obj = new Triangle();
				break;
			case "TEX.TRIANGLE":
				obj = new TexturableTriangle();
				break;
			case "ACCRETION":
				obj = new AccretionDisc();
				break;
			case "TEX.ACCRETION":
				obj = new TexturedAccretionDisc();
				break;
			default:
				throw new SceneException("Unsupported object type " ~ type);
			}
			SValue[string] optMap = fetchOptmap();
			if ("MATERIAL" !in optMap)
			{
				throw new SceneException("Object must have defined material: " ~ id);
			}
			obj.material = cfgMaterials[cast(string) optMap["MATERIAL"].get!SString];
			obj.setupFromOptions(optMap);
			obj.setName(id);
			if (!skipId)
			{
				cfgObjects[id] = obj;
			}
			return obj;
		}

		void parseLight(string type)
		{
			string id = fetchToken();
			if (id in cfgLights)
			{
				throw new SceneException("Light " ~ id ~ " already defined!");
			}
			Light obj;
			switch (type)
			{
			case "POINT":
				obj = new PointLight();
				break;
			default:
				throw new SceneException("Unsupported light type " ~ type);
			}
			SValue[string] optMap = fetchOptmap();
			obj.setName(id);
			obj.setupFromOptions(optMap);
			cfgLights[id] = obj;
		}

		void parseToken()
		{
			string tok = fetchToken();
			if (tok.length < 2)
				return;
			switch (tok)
			{
			case "MODULE":
				string id = fetchToken();
				fetchEnd();
				modules[id] = true;
				break;
			case "REQUIRE":
				string id = fetchToken();
				fetchEnd();
				if (id !in modules)
				{
					throw new SceneException("Required module not loaded: " ~ id);
				}
				break;
			case "DEFINE":
				string key = fetchToken();
				SValue val = fetchValue();
				if (key !in defines)
				{
					defines[key] = val;
				}
				else
				{
					throw new SceneException("Redefinition of " ~ tok ~ "!");
				}
				fetchEnd();
				break;
			case "TEXTURE":
				string id = fetchToken();
				string path = fetchToken();
				if (id in cfgTextures)
				{
					throw new SceneException("Texture " ~ id ~ " already loaded!");
				}
				cfgTextures[id] = ReadImage(path);
				defines[id] = SValue(STexture(id));
				fetchEnd();
				break;
			case "MATERIAL":
				string id = fetchToken();
				if (id in cfgMaterials)
				{
					throw new SceneException("Material " ~ id ~ " already defined!");
				}
				Material mat = new Material();
				parseMaterial(mat);
				cfgMaterials[id] = mat;
				defines[id] = SValue(cast(SString)(id));
				break;
			case "SETSPACE":
				string type = fetchToken();
				WorldSpace space;
				if (cfgSpace !is null)
				{
					throw new SceneException("Space was already created!");
				}
				switch (type)
				{
				case "FLAT", "EUCLIDEAN":
					space = new EuclideanSpace();
					break;
				case "DEFLECT":
					space = new PlaneDeflectSpace();
					break;
				case "ANALYTIC":
					string subtype = fetchToken();
					SValue[string] optMap = fetchOptmap();
					Analytic A = new Analytic();
					A.maxNumberOfSteps = cast(ulong) optFloat(optMap, "STEPS");
					A.paramStep = optFloat(optMap, "STEPPARAM");
					if (A.maxNumberOfSteps == 0)
					{
						throw new SceneException("Analytic number of steps cannot be 0");
					}
					if (A.paramStep == 0)
					{
						throw new SceneException("Analytic step parameter cannot be 0");
					}
					switch (subtype)
					{
					case "SCHWARZSCHILD":
						A.initiator = new Schwarzschild(optFloat(optMap,
							"MASS"), optVec3(optMap, "ORIGIN"));
						break;
					case "FLAT.CARTESIAN":
						A.initiator = new FlatCartesian();
						break;
					case "FLAT.RADIAL":
						A.initiator = new FlatRadial();
						break;
					case "KERR":
						A.initiator = new Kerr(optFloat(optMap, "MASS"),
							optFloat(optMap, "ANGMOMENTUM"), optVec3(optMap, "ORIGIN"));
						break;
					default:
						throw new SceneException("Unknown analytic subtype: " ~ subtype);
					}
					space = new WorldSpaceWrapper(A);
					break;
				default:
					throw new SceneException("Unknown space type: " ~ type);
				}
				foreach (obj; cfgObjects)
					space.AddObject(obj);
				foreach (lit; cfgLights)
					space.AddLight(lit);
				space.camera = cast(shared) cfgCamera;
				cfgSpace = cast(shared) space;
				Raytracer.setSpace(space);
				break;
			case "SETCAMERA":
				string type = fetchToken();
				SValue[string] opts = fetchOptmap();
				ICamera camera;
				switch (type)
				{
				case "ORTHOGONAL":
					camera = new OrthogonalCamera();
					break;
				case "LINEAR":
					camera = new LinearPerspectiveCamera();
					break;
				default:
					throw new SceneException("Unsupported camera type: " ~ type);
				}
				camera.origin = optVec3(opts, "ORIGIN");
				camera.yxratio = cast(fpnum)(cfgResolutionY) / cast(fpnum)(cfgResolutionX);
				Vectorf angs = optVec3(opts, "ANGLES");
				SetCameraAngles(camera, angs.x, angs.y, angs.z);
				camera.options = opts;
				cfgCamera = cast(shared) camera;
				if (cfgSpace !is null)
				{
					cfgSpace.camera = cast(shared) camera;
				}
				break;
			default:
				if (tok[0] == '=')
				{
					parseObject(tok[1 .. $]);
				}
				else if (tok[0] == '!')
				{
					parseLight(tok[1 .. $]);
				}
				else
				{
					throw new SceneException("Invalid token: " ~ tok);
				}
				break;
			}
		}

		while (!tokStream.empty)
		{
			parseToken();
		}
	}

	/// Load the scene description from file
	void loadFromFile(string path)
	{
		import std.file : exists, readText;

		if (!exists(path))
		{
			throw new SceneException("Scene description file doesn't exist: " ~ path);
		}
		loadFromScript(readText!string(path));
	}
}
