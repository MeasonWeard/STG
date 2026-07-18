scr_obj_mouseHover();

if (mouseHover) {

	var txt = "";
	if (is_struct(thisSkill)) txt = thisSkill.name;
	txt += "   lvl " + string(thisSkill.level);
	scr_ui_mouseHoverText(string(txt), fnt_normal);
	
	if (mouse_check_button_pressed(mb_left)) thisSkill.level ++;
	if (mouse_check_button_pressed(mb_right)) thisSkill.level --;
	
}