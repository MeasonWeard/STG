event_inherited();

if (smashable) {

	image_speed = 0;

	if (smashed) {
		image_index = 1;
		
		if (prevSmashed == false) scr_audio_playSoundAt(smashSound, x, y, false);
		
	} else {
		image_index = 0;	
	}
	
}

draw_self();

if (global.debug) {

	draw_set_colour(c_aqua);
	draw_rectangle(colLeft, colTop, colRight, colBottom, true);
	draw_set_colour(c_green);
	draw_rectangle(movLeft, movTop, movRight, movBottom, true);
	draw_text(x, y + 20, string(hashCellX) + "," + string(hashCellY));
	
}

prevSmashed = smashed;