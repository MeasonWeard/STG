event_inherited();

if (sprite == undefined) {

	var prevCol = draw_get_colour();
	
	draw_set_alpha(alpha);
	draw_set_colour(col);
	
	draw_circle(x, y, radius, false);

	draw_set_alpha(1);
	draw_set_colour(prevCol);

	alpha -= alphaDecay;
	
} else {
	

}

if (life < 1) instance_destroy();
life --;