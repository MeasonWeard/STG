draw_self();


if (isCurrent) {

	var borderCol = c_lime;
	
	draw_set_colour(borderCol);
	var in = 1;
	var alpha = 0.62;
	
	repeat(5) {

		draw_set_alpha(alpha);

		draw_rectangle(x + in, y + in, x + 64 - in, y + 64 - in, true);
		draw_rectangle(x-1 + in, y-1 + in, x + 65 - in, y + 65 - in, true);
		
		in ++;
		alpha -= 0.09;
		
	}

	draw_set_alpha(1);
	
}

if (active == true) {
	
	var borderCol = c_fuchsia;
	
	draw_set_colour(borderCol);
	draw_rectangle(x, y, x + 64, y + 64, true);
	draw_rectangle(x-1, y-1, x + 65, y + 65, true);
	
} else {

	if (is_struct(project) and project.level > 0) {
	
		var borderCol = c_aqua;
	
		draw_set_colour(borderCol);
		draw_rectangle(x, y, x + 64, y + 64, true);
		draw_rectangle(x-1, y-1, x + 65, y + 65, true);
	
	}
	
}