module scene.materials.material;

import config;
import image;
import math.interpolation;
import core.simd;
import std.math;

enum FilteringTypes : Color function(Image,fpnum,fpnum)
{
	NearestNeightbour = (im,U,V)
	{
		return im.PeekUV(U,V);
	},
	BilinearFiltering = (im,U,V)
	{
		fpnum u,v;

		u = U*(im.w-1).fmod(im.w).round();
		v = V*(im.h-1).fmod(im.h).round();

		return BilinearInterpolation(
			im.Peek((cast(size_t)u), (cast(size_t)v)), im.Peek((cast(size_t)u)+1, (cast(size_t)v)),
			im.Peek((cast(size_t)u), (cast(size_t)v)+1), im.Peek((cast(size_t)u)+1, (cast(size_t)v)+1),
			U-(cast(fpnum)u)/(cast(fpnum)im.w),
			V-(cast(fpnum)u)/(cast(fpnum)im.h));
	}
}

class Material
{
	alias UVFunc = Color function(Image,fpnum,fpnum);

	private Image im = null;
	private UVFunc f = null;
	private bool isDiffuse = false;
	private Color diffuseColor = Colors.Black;

	this()
	{
	}

	@property bool is_diffuse()
	{
		return isDiffuse;
	}
	
	@property Color diffuse_color()
	{
		return diffuseColor;
	}

	void loadTextureFromFile(string name)
	{
		im = ReadImage(name);
		f = FilteringTypes.NearestNeightbour;
	}

	void setFiltering(FilteringTypes filter)
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

	@property Image texture()
	{
		return im;
	}

}
