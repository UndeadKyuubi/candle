shader_type canvas_item;


uniform float start = 0.0;
uniform float end = 0.5;
uniform float darkness = 0.5;

void fragment() {
	vec4 tex=texture(TEXTURE,UV);
	
	float gradient=1.0-smoothstep(start,end,UV.y);
	float brightness=mix(1.0,1.0-darkness,gradient);
	
	COLOR=vec4(tex.rgb*brightness,tex.a);
}