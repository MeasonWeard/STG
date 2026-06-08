if (global.debug) {
	
	draw_self();
	draw_set_colour(c_white);
	
	draw_rectangle(movLeft, movTop, movRight, movBottom, true);
	
	draw_text(x, y, string(hashCellX) + "," + string(hashCellY));

}