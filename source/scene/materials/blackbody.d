
module scene.materials.blackbody;

import config;
import math.interpolation;
import scene.materials.material;
import image.color;
import image.memory;
import std.string, std.algorithm, std.array, std.range, std.conv, std.math;

enum string[][] blackBodyDataRaw = splitLines(import("blackbody.txt"),KeepTerminator.no).
		map!(a => strip(a)).filter!( a => !startsWith(a,"#") ).map!(a=>a.split()).array;

__gshared Color[391] lookupTable; // range [1000;40000;d=100]

private void initLookupTable()
{
	enum bool useC10 = true;
	int id = 0;
	foreach(i,string[] D; blackBodyDataRaw)
	{
		if(id<lookupTable.length)
		{
			if(D.length<10)continue;
			static if(useC10){if((D[2]=="2deg"))continue;}
			else{if((D[2]=="10deg"))continue;}
			lookupTable[id] = Color( to!fpnum(D[6]), to!fpnum(D[7]), to!fpnum(D[8]) );
			id++;
		}
		else
		{
			break;
		} 
	}
}

shared static this()
{
	initLookupTable();
}

class BlackBodyEmissionMaterial : Material
{

	this()
	{
		diffuseColor = Color(32,32,32);
		emissionColor = lookupTable[0];
	}
	
	@property override ref Color diffuse_color()
	{
		return diffuseColor;
	}

	@property override ref Color emission_color()
	{
		return emissionColor;
	}

	override Color peekUV(fpnum U, fpnum V)
	{
		U /= 100.0;
		int i0 = cast(int)(floor(U));
		return LinearInterpolation(lookupTable[i0], lookupTable[i0+1], U-floor(U));
	}

	override bool hasTexture() const
	{
		return false;
	}

}

