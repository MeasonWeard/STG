draw_self();

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