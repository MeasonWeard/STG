draw_self();

var col = playerInArea ? c_lime : #B2FFB2;
	
draw_set_colour(col);
draw_rectangle(areaLeft, areaTop, areaRight, areaBottom, true);
	
draw_set_halign(fa_middle);
draw_set_valign(fa_middle);
draw_set_font(fnt_large);
//draw_text(textX, textY, "END RUN");
	
scr_misc_resetTextAlignment();