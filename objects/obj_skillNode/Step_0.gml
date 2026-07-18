scr_obj_mouseHover();

if (mouseHover) {

	var txt = "";
	if (is_struct(thisSkill)) txt = thisSkill.name;
	scr_ui_mouseHoverText(string(txt), fnt_normal);
	
}