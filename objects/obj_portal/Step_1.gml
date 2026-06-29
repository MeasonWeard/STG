depth = layers.physical - y;

if (setup) {

	setup = false;
	
	areaLeft = x - 60;
	areaRight = x + 60;
	areaTop = y - sprite_get_height(spr_portal) - 20;
	areaBottom = y + 20;
	
}