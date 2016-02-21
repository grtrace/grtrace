#version 330

precision highp float;

flat in vec3 VPosition;
in vec2 VTexcoord;
in vec4 VColor;
in vec3 VNormal;
in vec3 VWNormal;

out vec4 outColor;

uniform int doTexture;
uniform sampler2D tex;

void main() 
{
    vec3 lightDir = normalize(vec3(1.0,1.0,0.4));
    vec4 col = VColor * (min(1.0,max(0.0,dot(VWNormal,lightDir))+0.12)+vec4(1.0))/2.0;//VColor;
    //vec4 col = vec4(VWNormal,1.0);
    col.w = 1.0;
    if(doTexture>0)
    {
        col *= texture(tex, VTexcoord);
    }
    outColor = col;
}
