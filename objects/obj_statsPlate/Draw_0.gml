//formatting
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);

draw_set_font(fnt_normal);

statsLeft = camX + 20;
statsTop = camY + 20;
statsRight = statsLeft + 400;
statsBottom = statsTop + 500;

var pad = 20;

gearLeft = statsRight + 20;
gearRight = gearLeft + 600;
gearTop = statsTop;
gearBottom = statsBottom;

gearX = gearLeft + 32;
gearY = gearTop + 32;

weaponX = gearLeft + 256;
weaponY = gearY;


//get info
if (instance_exists(player)) {
	
	device1 = player.gear.device1;
	device2 = player.gear.device2;
	tie = player.gear.tie;
	headgear = player.gear.headgear;
	coat = player.gear.coat;
	weapon = player.equippedWeapon;

}

camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);

var txt = "";

if (tab == "core") {
	
	txt = "CORE STATS\n\n" + txtCore;	
	
} else if (tab == "defense") {
	
	txt = "DEFENSE STATS\n\n" + txtDef;	
	
} else if (tab == "offense") {
	
	txt = "OFFENSE STATS\n\n" + txtOff;
	
}

var tabTxt = string(tabIndex + 1) + " / " + string(array_length(tabs)) + "   ";
tabTxt += "\n< Press Tab >";

scr_misc_resetTextAlignment();

draw_set_colour(data.colours.windowBackground);
draw_rectangle(statsLeft, statsTop, statsRight, statsBottom, false);
draw_set_colour(c_black);
draw_rectangle(statsLeft, statsTop, statsRight, statsBottom, true);

draw_set_colour(#324E7F);
draw_rectangle(gearLeft, gearTop, gearRight, gearBottom, false);
draw_set_colour(c_black);
draw_rectangle(gearLeft, gearTop, gearRight, gearBottom, true);

draw_set_colour(data.colours.windowText);
draw_text(statsLeft + pad, statsTop + pad, txt);

draw_set_halign(fa_right);
draw_text(statsRight - pad, statsTop + pad, tabTxt);

scr_ui_drawItemSlot(device1, gearX, gearY, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(device2, gearX + gearSlotGap, gearY, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(headgear, gearX, gearY + gearSlotGap, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(coat, gearX + gearSlotGap, gearY + gearSlotGap, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(tie, gearX + gearSlotGap * 2, gearY + gearSlotGap, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(weapon, weaponX, weaponY, 0, gearSlotSize, fnt_normal, true);
//scr_ui_drawItemSlot(coat, weaponX, weaponY, 0, gearSlotSize, fnt_normal, true);

