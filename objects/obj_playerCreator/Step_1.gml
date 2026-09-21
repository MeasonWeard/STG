if (reset) {

	reset = false;

	hairColourUniform = shader_get_uniform(shader_player, "hairColour");
	skinColourUniform = shader_get_uniform(shader_player, "skinColour");
	texelSizeUniform = shader_get_uniform(shader_player, "texelSize");
	spriteUVUniform = shader_get_uniform(shader_player, "spriteUV");
	
}