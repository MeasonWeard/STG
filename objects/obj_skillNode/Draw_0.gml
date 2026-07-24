draw_self();

if (is_struct(thisSkill)) {
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(thisSkill.txtCol);
	draw_set_font(fnt_normal);
	draw_text(x + 4, y + 4, string(thisSkill.level));

}