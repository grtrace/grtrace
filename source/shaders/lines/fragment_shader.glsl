#version 150 core

in vec3 GeoColor;

out vec4 color;

void main()
{
	color = vec4(GeoColor,0);
}