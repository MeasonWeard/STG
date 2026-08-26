scr_ui_drawItemSlot(item, x, y, 0, slotSize, fnt_normal, true, unequip, undefined, unequip);

if (!is_struct(item)) {

	draw_set_halign(fa_left);
	draw_text(x + 8, y + 8, emptyText);
	
}