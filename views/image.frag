#version 150 core

in vec2 texture_coord;
uniform sampler2D tex;

out vec4 color;

void main()
{
	//color = texture(tex, texture_coord);
    color = vec4(1,1,1,1);
}