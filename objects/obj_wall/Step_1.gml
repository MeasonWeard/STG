event_inherited();

if (is_array(decorationSprites)) {

	var seed = scr_obj_generateSeed(self);
	random_set_seed(seed);

	if (scr_random_chance(decorationChance)) {

		var spr = scr_randomElement(decorationSprites);
	
		if (!is_undefined(spr)) {

			decoration = instance_create_layer(x, y, "Instances", obj_wallDecoration);
			decoration.sprite_index = spr;
			decoration.depth = depth - 1;
			decoration.x = x;
			decoration.y = y - sprite_height * spriteYoffset;
	
		}
	
	}
	
	randomise();
	
}