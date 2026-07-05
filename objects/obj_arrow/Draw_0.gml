if (drawDelay > 0) {
	
	drawDelay--;
	
} else {
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, col, image_alpha);

	if (is_string(text)) {
	
		var xx =  x - lengthdir_x(textDist, dir);
		var yy = y - lengthdir_y(textDist, dir);
	
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
	
		draw_set_colour(col);
		draw_set_font(fnt_large);
	
		draw_set_alpha(0.8);
	
		draw_text(xx, yy, text);
	
		scr_misc_resetTextAlignment();
		draw_set_alpha(1);

	}
	
	
}


