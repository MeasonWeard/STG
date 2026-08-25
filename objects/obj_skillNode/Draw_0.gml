draw_self();

if (is_struct(thisSkill)) {
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(thisSkill.txtCol);
	draw_set_font(fnt_normal);
	draw_text(x + 4, y + 4, string(thisSkill.level));
	
	if (locked) {
		
		draw_set_colour(c_grey);
		draw_set_alpha(0.75);
		draw_rectangle(x, y, x + 64, y + 64, false);
		draw_set_alpha(1);

	}
	
	if (thisSkill.level > 0) {
	
		var borderCol = thisSkill.level < thisSkill.maxLevel ? c_aqua : c_fuchsia;
	
		draw_set_colour(borderCol);
		draw_rectangle(x, y, x + 64, y + 64, true);
		draw_rectangle(x-1, y-1, x + 65, y + 65, true);
	}

}