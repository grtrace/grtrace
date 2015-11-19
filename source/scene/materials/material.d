﻿module scene.materials.material;

import config;
import image;
import math.interpolation;
import core.simd;
import std.math;

final class FilteringTypes
{
	public alias FuncType = Color function(Image,fpnum,fpnum);
	static Color NearestNeightbour(Image im,fpnum U,fpnum V)
	{
		return im.PeekUV(U,V);
	}
	static Color BilinearFiltering(Image im,fpnum U,fpnum V)
	{
		fpnum u,v;

		u = U*(im.w-1).fmod(im.w).round();
		v = V*(im.h-1).fmod(im.h).round();

		return BilinearInterpolation(
			im.Peek((cast(size_t)u), (cast(size_t)v)), im.Peek((cast(size_t)u)+1, (cast(size_t)v)),
			im.Peek((cast(size_t)u), (cast(size_t)v)+1), im.Peek((cast(size_t)u)+1, (cast(size_t)v)+1),
			U-(cast(fpnum)u)/(cast(fpnum)im.w),
			V-(cast(fpnum)v)/(cast(fpnum)im.h));
	}
}

class Material
{
	alias UVFunc = Color function(Image,fpnum,fpnum);

	private Image im = null;
	private UVFunc f = null;
	private bool isDiffuse = false;

	private Color emissionColor = Colors.Black;
	private Color diffuseColor = Colors.Black;

	this()
	{
	}

	@property ref bool is_diffuse()
	{
		return isDiffuse;
	}
	
	@property ref Color diffuse_color()
	{
		return diffuseColor;
	}

	@property ref Color emission_color()
	{
		return emissionColor;
	}

	void loadTextureFromFile(string name)
	{
		im = ReadImage(name);
		f = &FilteringTypes.NearestNeightbour;
		isDiffuse = true;
		diffuseColor = Colors.White;
	}

	void setFiltering(FilteringTypes.FuncType filter)
	{
		f = filter;
	}

	Color peekUV(fpnum U, fpnum V)
	{
		return f(im, U, V);
	}

	bool hasTexture() const
	{
		return im !is null;
	}

	@property ref Image texture()
	{
		return im;
	}

}
