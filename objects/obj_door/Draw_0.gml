draw_self();

if (global.debug) {

	draw_set_colour(c_blue);
	draw_rectangle(areaLeft, areaTop, areaRight, areaBottom, true);
	
}

if(open) {

	var col = playerinArea ? c_lime : #B2FFB2;
	
	draw_set_colour(col);
	draw_rectangle(areaLeft, areaTop, areaRight, areaBottom, true);
	
	draw_set_halign(fa_middle);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_large);
	draw_text(textX, textY, "EXIT");
	
	scr_misc_resetTextAlignment();
	
}