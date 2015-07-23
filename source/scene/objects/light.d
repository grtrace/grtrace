module scene.objects.light;

import scene.objects.interfaces;
import std.getopt;
import image.color;
import math.vector;
import config;

class PointLight : Light
{
	Vectorf position;
	Color color;

	this()
	{
	}

	void setupFromOptions(string[] a)
	{
		fpnum x,y,z;
		float r,g,b;
		getopt(a,std.getopt.config.caseSensitive,
			"x",&x,
			"y",&y,
			"z",&z,
			"r",&r,
			"g",&g,
			"b",&b);
		position = vectorf(x,y,z);
		color = Color(r,g,b);
	}

	Vectorf getPosition()
	{
		return position;
	}

	Color getColor()
	{
		return color;
	}

	Vectorf getPosition() shared
	{
		return position;
	}
	
	Color getColor() shared
	{
		return color;
	}

}

