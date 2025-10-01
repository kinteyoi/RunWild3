shader_type canvas_item;

uniform vec4 ColorUniform : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float HowShiny = 0.0; // Metallic not meaningful in 2D
uniform float Roughness = 0.2;

void fragment() {
    vec3 n_out4p0 = ColorUniform.rgb;
    float n_out4p1 = ColorUniform.a;

    COLOR.rgb = n_out4p0;
    COLOR.a   = n_out4p1;
}