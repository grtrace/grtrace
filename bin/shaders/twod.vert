#version 330

precision highp float;

in vec3 position;
in vec3 texcoord;
in vec4 color;

out vec3 VPosition;
out vec2 VTexcoord;
out vec4 VColor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;
uniform mat4 texModel;

void main() 
{
    VColor = color;
    VTexcoord = (texModel * vec4(texcoord, 1.0)).xy;
    VPosition = position;
    gl_Position = proj * view * model * vec4(position, 1.0);
}
