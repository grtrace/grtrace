module image.memory;

import std.range, std.array, std.math;
import config;
import image.color;

alias Image = MemImage!ubyte;

class MemImage(T)
{
	public T[] data;
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
			static if(is(T==ubyte))
			{
				data[p++] = c.ru;
				data[p++] = c.gu;
				data[p++] = c.bu;
			}
			else
			{
				data[p++] = cast(T)c.r;
				data[p++] = cast(T)c.g;
				data[p++] = cast(T)c.b;
			}
		}
	}

	public void Poke(size_t x, size_t y, Color c)
	{
		static if(is(T==ubyte))
		{
			data[(y*width + x)*3] = c.ru;
			data[(y*width + x)*3 + 1] = c.gu;
			data[(y*width + x)*3 + 2] = c.bu;
		}
		else
		{
			data[(y*width + x)*3] = cast(T)c.r;
			data[(y*width + x)*3 + 1] = cast(T)c.g;
			data[(y*width + x)*3 + 2] = cast(T)c.b;
		}
	}

	public void Poke(size_t x, size_t y, Color c) shared
	{
		static if(is(T==ubyte))
		{
			data[(y*width + x)*3] = c.ru;
			data[(y*width + x)*3 + 1] = c.gu;
			data[(y*width + x)*3 + 2] = c.bu;
		}
		else
		{
			data[(y*width + x)*3] = cast(T)c.r;
			data[(y*width + x)*3 + 1] = cast(T)c.g;
			data[(y*width + x)*3 + 2] = cast(T)c.b;
		}
	}

	public Color PeekUV(fpnum U, fpnum V)
	{
		fpnum u,v;
		u = U*(w-1).fmod(width).round();
		v = V*(h-1).fmod(height).round();
		return Peek(cast(size_t)u, cast(size_t)v);
	}

	public Color Peek(size_t x, size_t y)
	{
		static if(is(T==ubyte))
		{
			return Color(data[(y*width + x)*3]/255.0f, data[(y*width + x)*3 + 1]/255.0f, data[(y*width + x)*3 + 2]/255.0f);
		}
		else
		{
			return Color(data[(y*width + x)*3], data[(y*width + x)*3 + 1], data[(y*width + x)*3 + 2]);
		}
	}

	public void Recreate(size_t w, size_t h)
	{
		width = w;
		height = h;
		data = repeat(cast(T)0).take(w*h*3).array().dup;
	}
}
