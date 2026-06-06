event_inherited();

draw_self();

if (damageFlash > 0) {

	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, image_alpha);
	
}

if (global.debug) {
	
	draw_sprite(spr_point, 0, gunX, gunY);
	draw_sprite(spr_point, 0, aimX, aimY);
	draw_sprite(spr_point2, 0, x, y);
	draw_sprite(spr_point2, 0, centreX, centreY);
	draw_text(x - 32, y + 32, string(hp) + "/" + string(maxHp));
	
	var prevCol = draw_get_colour();
	draw_set_colour(c_aqua);
	draw_rectangle(colLeft, colTop, colRight, colBottom, true);
	draw_set_colour(prevCol);
	
	var cell = scr_hash_getCellAt(x, y);

	var cx = cell.xx;
	var cy = cell.yy;

	draw_set_colour(c_yellow);
	draw_text(x, y, string(cx) + "," + string(cy));
	
}