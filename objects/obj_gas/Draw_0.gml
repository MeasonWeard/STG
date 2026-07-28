//image_angle += rot;

draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, image_angle, c_green, image_alpha);

if (global.debug) {

	draw_text(x, y + 16, charges);
	draw_text(x, y + 42, life);
	
}