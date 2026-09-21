shader_set(shader_player);

//hair colour
var r = colour_get_red(hairColour) / 255;
var g = colour_get_green(hairColour) / 255;
var b = colour_get_blue(hairColour) / 255;

shader_set_uniform_f(hairColourUniform, r, g, b);

//skin colour
r = colour_get_red(skinColour) / 255;
g = colour_get_green(skinColour) / 255;
b = colour_get_blue(skinColour) / 255;

shader_set_uniform_f(skinColourUniform, r, g, b);

//texture dimensions
var tex = sprite_get_texture(sprite_index, floor(image_index));

var texelW = texture_get_texel_width(tex);
var texelH = texture_get_texel_height(tex);

shader_set_uniform_f(texelSizeUniform, texelW, texelH);

//current animation frame UVs
var uvs = sprite_get_uvs(sprite_index, floor(image_index));

shader_set_uniform_f(
    spriteUVUniform,
    uvs[0],
    uvs[1],
    uvs[2],
    uvs[3]
);

//draw player
draw_self();

shader_reset();