if (tick < 25) {

	draw_set_colour(c_white);
	draw_set_alpha(alpha);
	draw_rectangle(x, y, x + camW, y + camH, false);
	
	alpha -= 0.025;
	
	if (!sprite_exists(spr)) {
		
		spr = sprite_add(filename, 1, false, false, 0, 0);
		
	} else {
	
		var h = sprite_get_height(spr);
		var w = sprite_get_width(spr);
		
		var nh = h * 0.5;
		var nw = w * 0.5;
		
		draw_sprite_stretched(spr, 0, camXmid - nw * 0.5, camYmid - nh * 0.5, nw, nh);
	
	}
	
}

if (tick <= 0) {
	
	instance_destroy();
	
}

tick --;