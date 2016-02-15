#version 330

precision highp float;

flat in vec3 VPosition;
in vec2 VTexcoord;
in vec4 VColor;
in vec3 VNormal;

out vec4 outColor;

uniform int doTexture;
uniform sampler2D tex;

void main() 
{
    vec4 col = vec4(VPosition,1.0);//VColor;
    if(doTexture>0)
    {
        col *= texture(tex, VTexcoord);
    }
    outColor = col;
}
