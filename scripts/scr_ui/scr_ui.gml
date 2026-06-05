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