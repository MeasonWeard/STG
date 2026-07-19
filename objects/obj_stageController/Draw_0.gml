scr_showDevInfo();

if (global.debug) {

	draw_set_colour(c_red);
	draw_set_alpha(0.25);

	for (var xx = 0; xx <= room_width; xx += HASH_CELL_SIZE) {
	    draw_line(xx, 0, xx, room_height);
	}

	for (var yy = 0; yy <= room_height; yy += HASH_CELL_SIZE) {
	    draw_line(0, yy, room_width, yy);
	}

	draw_set_alpha(1);
	
}