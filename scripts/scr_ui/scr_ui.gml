function scr_ui_convertToScreenSpace(xx, yy) {
	
	var cam = view_camera[0];

	// Camera view
	var camX = camera_get_view_x(cam);
	var camY = camera_get_view_y(cam);
	var camW = camera_get_view_width(cam);
	var camH = camera_get_view_height(cam);

	// Viewport
	var vx = view_xport[0];
	var vy = view_yport[0];
	var vw = view_wport[0];
	var vh = view_hport[0];

	// Normalize camera (0–1 range)
	var nx = (xx - camX) / camW;
	var ny = (yy - camY) / camH;

	// Clamp so off-screen values don’t break edge checks
	nx = clamp(nx, 0, 1);
	ny = clamp(ny, 0, 1);

	// Convert to screen space
	var sx = vx + nx * vw;
	var sy = vy + ny * vh;

	return {
		xx: sx,
		yy: sy
	}
	
}

function scr_ui_drawMiniMap(miniMap, cellSize, xx, yy, flashX, flashY) {

	var mapW = array_length(miniMap);
	if (mapW <= 0) return;

	var mapH = array_length(miniMap[0]);

	var flash = is_real(flashX) and is_real(flashY) and flashX >= 0 and flashX < mapW
	and flashY >= 0 and flashY < mapH and ((current_time div 500) mod 2 == 0);

	for (var mx = 0; mx < mapW; mx++) {

		for (var my = 0; my < mapH; my++) {

			var col = miniMap[mx][my];

			if (flash and mx == flashX and my == flashY) {
				col = c_white;
			}

			var left   = xx + (mx * cellSize);
			var top    = yy + (my * cellSize);
			var right  = left + cellSize;
			var bottom = top + cellSize;

			// Fill
			draw_set_colour(col);
			draw_rectangle(left, top, right, bottom, false);

			// Border
			draw_set_colour(c_white);
			draw_rectangle(left, top, right, bottom, true);

		}

	}

	draw_set_colour(c_white);

}