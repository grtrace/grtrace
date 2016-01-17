#version 150 core

in vec3 VerColor[2];

uniform vec2 viewport_size;
uniform float line_thickness = 1.0f;

out vec3 GeoColor;

layout(lines) in;
layout(triangle_strip, max_vertices = 4) out;

void main()
{
	float line_thickness_A = line_thickness;
    float line_thickness_B = line_thickness_A; //TODO: line thickness depends on distance from camera
	vec2 normalized_line_beg = gl_in[0].gl_Position.xy / gl_in[0].gl_Position.w;
    vec2 normalized_line_end = gl_in[1].gl_Position.xy / gl_in[1].gl_Position.w;

    vec2 lineScreenForward = normalize(normalized_line_beg.xy - normalized_line_end.xy);
    vec2 lineScreenRight = vec2(-lineScreenForward.y, lineScreenForward.x);
    vec2 lineScreenOffsetA = (vec2(line_thickness_A) / viewport_size) * lineScreenRight;
    vec2 lineScreenOffsetB = (vec2(line_thickness_B) / viewport_size) * lineScreenRight;

    vec4 line_beg = gl_in[0].gl_Position;
    vec4 line_end = gl_in[1].gl_Position;

    gl_Position = vec4(line_beg.xy + lineScreenOffsetA*line_beg.w, line_beg.z, line_beg.w);
    GeoColor = VerColor[0];
    EmitVertex();

    gl_Position = vec4(line_beg.xy - lineScreenOffsetA*line_beg.w, line_beg.z, line_beg.w);
    GeoColor = VerColor[0];
    EmitVertex();

    gl_Position = vec4(line_end.xy + lineScreenOffsetB*line_beg.w, line_beg.z, line_beg.w);
    GeoColor = VerColor[1];
    EmitVertex();

    gl_Position = vec4(line_end.xy - lineScreenOffsetB*line_beg.w, line_beg.z, line_beg.w);
    GeoColor = VerColor[1];
    EmitVertex();

    EndPrimitive();
}
