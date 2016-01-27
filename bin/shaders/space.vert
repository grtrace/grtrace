#version 330 core

in vec3 position;
in vec3 texcoord;
in vec4 color;
in vec3 normal;

out vec3 VPosition;
out vec2 VTexcoord;
out vec4 VColor;
out vec3 VNormal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

void main() 
{
    VColor = color;
    VTexcoord = texcoord.xy;
    VPosition = position;
    VNormal = normal;
    gl_Position = proj * view * model * vec4(position, 1.0);
}
