event_inherited();

draw_self();

if (global.debug) {

	draw_set_colour(c_aqua);
	draw_rectangle(colLeft, colTop, colRight, colBottom, true);
	draw_set_colour(c_green);
	draw_rectangle(movLeft, movTop, movRight, movBottom, true);
	
	draw_text(x, y + 20, hp);
	
}