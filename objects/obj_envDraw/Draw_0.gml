if (!surface_exists(wallSurface)) {
	wallSurface = surface_create(room_width, wallHeight);
	drawWalls = true;
}

if (drawWalls) {

	drawWalls = false;
	
	var wallListLen = array_length(wallList);

	if (wallListLen > 0) {

	    surface_set_target(wallSurface);
		draw_clear_alpha(c_black, 0);
		
		var wallIndex = 0;

		for (var i = 0; i < wallsAmount; i ++) {
	
			var spr = wallList[wallIndex];
			var xx = i * wallWidth;
		
			draw_sprite(spr, 0, xx, wallHeight);
			
			wallIndex ++;
			
			if(wallIndex >= wallListLen) wallIndex = 0;
	
		}
		
		surface_reset_target();
	
	}
	
}

if (surface_exists(wallSurface)) {
	
	draw_surface(wallSurface, 0, -wallHeight);
	
}