#version 330

precision highp float;

in highp vec3 position;
in mediump vec3 texcoord;
in lowp vec4 color;
in mediump vec3 normal;

flat out vec3 VPosition;
out vec2 VTexcoord;
out vec4 VColor;
out vec3 VNormal;
out vec3 VWNormal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

void main() 
{
    VColor = color;
    VTexcoord = texcoord.xy;
    VPosition = position;
    VNormal = normal;
    VWNormal = normalize((model * vec4(normal,0.0)).xyz);
    gl_Position = proj * view * model * vec4(position, 1.0);
}
