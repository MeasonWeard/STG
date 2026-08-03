image_xscale = size;
image_yscale = size;

if (damageInRadius and setRadius) {

	setRadius = false;
	
	radius = max(sprite_width, sprite_height) * size * 0.5;
	
}

if (damageInLine and setLineLength) {

	setLineLength = false;

	lineLength = sprite_width * abs(image_xscale);

}