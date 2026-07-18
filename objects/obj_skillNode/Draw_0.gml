draw_self();

if (is_struct(thisSkill)) {
	
	draw_set_colour(c_white);
	draw_text(x + 4, y + 4, string(thisSkill.level));

}