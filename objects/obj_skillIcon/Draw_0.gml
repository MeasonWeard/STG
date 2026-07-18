var icon = spr_icon_blank;

if (is_struct(thisSkill)) {
	icon = thisSkill.icon;
}

scr_ui_skillIconFromData(x, y, 0, icon, "", "", 1, 0, false, false);

if (is_real(slot)) {

	draw_set_halign(fa_middle);
	draw_set_font(fnt_large);
	draw_text(textX, textY, slot);
	
	scr_misc_resetTextAlignment();
	
}