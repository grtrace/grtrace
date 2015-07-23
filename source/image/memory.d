module image.memory;

import std.range, std.array, std.math;
import core.simd;
import config;
import image.color;

class Image
{
	public ubyte[] data;
	private size_t width, height;

	public @property size_t w() const
	{
		return width;
	}

	public @property size_t h() const
	{
		return height;
	}

	this(size_t w=0, size_t h=0)
	{
		Recreate(w,h);
	}

	public void FillWith(Color c)
	{
		for(int p=0;p<width*height*3;)
		{
			data[p++] = c.ru;
			data[p++] = c.gu;
			data[p++] = c.bu;
		}
	}

	public void Poke(size_t x, size_t y, Color c)
	{
		data[(y*width + x)*3] = c.ru;
		data[(y*width + x)*3 + 1] = c.gu;
		data[(y*width + x)*3 + 2] = c.bu;
	}

	public void Poke(size_t x, size_t y, Color c) shared
	{
		data[(y*width + x)*3] = c.ru;
		data[(y*width + x)*3 + 1] = c.gu;
		data[(y*width + x)*3 + 2] = c.bu;
	}

	public Color PeekUV(fpnum U, fpnum V)
	{
		double2 uv;
		long2 wh;
		uv.ptr[0] = U;
		uv.ptr[1] = V;
		wh.ptr[0] = width;
		wh.ptr[1] = height;
		wh -= 1;
		uv *= cast(double2)wh;
		fpnum u,v;
		u = uv.ptr[0].fmod(width);
		v = uv.ptr[1].fmod(height);
		//bool uI = fabs(u-floor(u))<1e-6;
		//bool vI = fabs(v-floor(v))<1e-6;
		return Peek(cast(size_t)u, cast(size_t)v);
	}

	public Color Peek(size_t x, size_t y)
	{
		return Color(data[(y*width + x)*3]/255.0f, data[(y*width + x)*3 + 1]/255.0f, data[(y*width + x)*3 + 2]/255.0f);
	}

	public void Recreate(size_t w, size_t h)
	{
		width = w;
		height = h;
		data = repeat(cast(ubyte)0).take(w*h*3).array().dup;
	}
}
