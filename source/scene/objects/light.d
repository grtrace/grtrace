module scene.objects.light;

import scene.objects.interfaces;
import std.string;
import image.color;
import math.vector;
import scriptconfig;
import grtrace;

class PointLight : Light
{
	mixin RenderableNameHandler;
	Vectorf position;
	Color color;

	this()
	{
	}

	void setupFromOptions(SValue[string] a)
	{
		position = optVec3(a, "POSITION");
		color = optColor(a, "EMIT");
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

	override string toString()
	{
		return format("P:%s C:%s", position, color);
	}

}
