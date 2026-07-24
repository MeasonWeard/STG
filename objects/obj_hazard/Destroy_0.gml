if (deathSprite != undefined) {

	var gib = instance_create_layer(x, y, "Instances", obj_gib);
	gib.sprite_index = deathSprite;
	gib.depth = depth;
	gib.disappear = true;
	gib.image_xscale = image_xscale;
	gib.image_yscale = image_yscale;
	
}