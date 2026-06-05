event_inherited();

if (delay == 0) {

	draw_set_colour(col);

	for (var i = 0; i < array_length(parts); i++) {
	
		var p = parts[i];
		draw_circle(p.x, p.y, p.rad, false);
	
	}

	draw_set_colour(c_white);

}