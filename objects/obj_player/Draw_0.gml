if (!active) exit;

image_alpha = sc.pictureMode ? 0 : 1;

event_inherited();

if (global.debug) {

	draw_text(x, y - 120, string(hashCellX) + "," + string(hashCellY));
	draw_text(x, y - 300, finalStats.meleeResMin);

}