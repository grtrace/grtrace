module scene.materials.material;

import grtrace;
import image;
import math.interpolation;
import math.vector;
import math.geometric;
import core.simd;
import std.math;

final class FilteringTypes
{
	public alias FuncType = Color function(Image, fpnum, fpnum);
	static Color NearestNeightbour(Image im, fpnum U, fpnum V)
	{
		return im.PeekUV(U, V);
	}

	static Color BilinearFiltering(Image im, fpnum U, fpnum V)
	{
		fpnum u, v;

		u = U * (im.w - 1).fmod(im.w).round();
		v = V * (im.h - 1).fmod(im.h).round();

		return BilinearInterpolation(im.Peek((cast(size_t) u), (cast(size_t) v)),
				im.Peek((cast(size_t) u) + 1, (cast(size_t) v)),
				im.Peek((cast(size_t) u), (cast(size_t) v) + 1),
				im.Peek((cast(size_t) u) + 1, (cast(size_t) v) + 1),
				U - (cast(fpnum) u) / (cast(fpnum) im.w), V - (cast(fpnum) v) / (cast(fpnum) im.h));
	}
}

class Material
{
	alias UVFunc = Color function(Image, fpnum, fpnum);

	protected Image im = null;
	protected UVFunc f = null;
	protected bool isDiffuse = false;

	protected Color emissionColor = Colors.Black;
	protected fpnum emissionWavelength = fpnum.nan;
	protected Color diffuseColor = Colors.Black;

	this()
	{
		f = &FilteringTypes.NearestNeightbour;
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

	@property ref fpnum emission_wave_length()
	{
		return emissionWavelength;
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

	static struct LightHit
	{
		Vectorf position;
		Vectorf direction;
		Color color;
	}

	Color calculateColor(fpnum U, fpnum V, Vectorf camNormal, LightHit[] lights)
	{
		Color tmp = emission_color();
		if (is_diffuse())
		{
			Color diffColor = diffuse_color();
			foreach (ref LightHit light; lights)
			{
				fpnum DP = camNormal * light.direction;
				if (DP > 0)
				{
					tmp = tmp + diffColor * light.color * (DP);
				}
			}
		}
		if (hasTexture())
		{
			tmp *= peekUV(U, V);
		}
		return tmp;
	}

}
