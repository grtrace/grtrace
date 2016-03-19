module scene.objects.light;

import scene.objects.interfaces;
import std.getopt, std.string;
import image.color;
import math.vector;
import scriptconfig;
import config;

class PointLight : Light
{
	mixin RenderableNameHandler;
	Vectorf position;
	Color color;

	this()
	{
	}

	void setupFromOptions(string[] a)
	{
		string positionStr;
		string colorStr;
		getopt(a, std.getopt.config.caseSensitive, "position|p", &positionStr,
			"color|c", &colorStr);

		position = vectorString(positionStr);
		color = colorString(colorStr);
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
