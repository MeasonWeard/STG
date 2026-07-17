//formatting
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);

statsLeft = camX + 20;
statsTop = camY + 20;
statsRight = statsLeft + 400;
statsBottom = statsTop + 800;

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
	weapon = player.equippedWeapon;

}

camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);

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
draw_text(camX + 40, camY + 40, txt);

scr_ui_drawItemSlot(device1, gearX, gearY, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(device2, gearX + gearSlotGap, gearY, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(headgear, gearX, gearY + gearSlotGap, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(tie, gearX + gearSlotGap, gearY + gearSlotGap, 0, gearSlotSize, fnt_normal, true);
scr_ui_drawItemSlot(weapon, weaponX, weaponY, 0, gearSlotSize, fnt_normal, true);