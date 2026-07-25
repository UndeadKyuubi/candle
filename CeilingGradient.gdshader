shader_type canvas_item;

uniform vec4 ceiling_color : source_color = vec4(0.0, 0.0, 0.0, 0.1);
uniform float start = 0.0;
uniform float end = 0.5;

void fragment() {
    float gradient = 1.0 - smoothstep(start, end, UV.y);
    COLOR = vec4(ceiling_color.rgb, ceiling_color.a * gradient);
}