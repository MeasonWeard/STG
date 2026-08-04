draw_self();

if (global.debug) {

	draw_set_colour(c_blue);
	draw_rectangle(areaLeft, areaTop, areaRight, areaBottom, true);
	
}

if(open) {

	var col = playerinArea ? c_lime : #B2FFB2;
	var txt = sc.hub? doorText : "EXIT";

	
	draw_set_colour(col);
	draw_rectangle(areaLeft, areaTop, areaRight, areaBottom, true);
	
	draw_set_halign(fa_middle);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_large);
	draw_text(textX, textY, txt);
	
	scr_misc_resetTextAlignment();
	
}

if (displayTag) {

	var angle = 35;
	if (side == "left") angle = 125;
	if (side == "bottom") angle = 215;
	
	var xx = x;
	var yy = y - sprite_height - 12;
	
	if (side == "bottom") {
		xx = x - 12 - sprite_width * 0.5;
		yy = y - sprite_height + 12;
	}
	
	scr_ui_displayTag(xx, yy, 100, tagText, c_lime, fnt_normal, angle);
	
}