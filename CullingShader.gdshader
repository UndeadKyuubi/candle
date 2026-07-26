shader_type canvas_item;

void fragment()
{
    vec4 color = texture(TEXTURE, UV);
    float shadow = 1.0 - color.r;

    COLOR = vec4(0.0, 0.0, 0.0, shadow);
}