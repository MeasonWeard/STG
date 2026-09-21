reset = false;

image_speed = 0;
image_xscale = 2;
image_yscale = 2;

hairColour = #141414;
skinColour = #70412D;

hairColourUniform = shader_get_uniform(shader_player, "hairColour");
skinColourUniform = shader_get_uniform(shader_player, "skinColour");
texelSizeUniform = shader_get_uniform(shader_player, "texelSize");
spriteUVUniform = shader_get_uniform(shader_player, "spriteUV");