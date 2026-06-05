function scr_display_applyIntegerScaling() {
	var iw = INTERNAL_WIDTH;
	var ih = INTERNAL_HEIGHT;

	var dw = window_get_width();   // ✅ CRITICAL FIX — use **window** size, not display
	var dh = window_get_height();

	var scale_x = floor(dw / iw);
	var scale_y = floor(dh / ih);
	var scale = min(scale_x, scale_y);

	var vp_w = iw * scale;
	var vp_h = ih * scale;
	var vp_x = (dw - vp_w) div 2;
	var vp_y = (dh - vp_h) div 2;

	view_set_wport(0, vp_w);
	view_set_hport(0, vp_h);
	view_set_xport(0, vp_x);
	view_set_yport(0, vp_y);

	camera_set_view_size(view_camera[0], iw, ih);

	global.gui_scale = scale;
	global.gui_offset_x = vp_x;
	global.gui_offset_y = vp_y;
	
	global.surfaceRebuildRequested = true;

}

function scr_display_setCameraView(w, h) {
	// Resize the internal camera
	var cam = view_camera[0];

	camera_set_view_size(cam, w, h);

	// Make the viewport match the camera size so it doesn't stretch
	var vp = 0; // assuming using view[0]
	view_set_wport(vp, w);
	view_set_hport(vp, h);
	
}

function scr_display_switchFullscreen() {

	var fs = window_get_fullscreen();
	fs = !fs;
	
	//scr_display_refreshWindowSize();
	window_set_fullscreen(fs);

	var w = window_get_width();
	var h = window_get_height();

	view_set_wport(0, w);
	view_set_hport(0, h);
	view_set_xport(0, 0);
	view_set_yport(0, 0);

	camera_set_view_size(view_camera[0], INTERNAL_WIDTH, INTERNAL_HEIGHT);

	global.displayController.scaleGUI = true;
	
}

function scr_display_cycleResolution() {

	var data = global.data;
	var index = data.resolutionIndex;
	var resolutions = data.resolutions;
	var len = array_length(resolutions);
	
	index ++;
	
	if (index >= len) index = 0;
	
	var res = resolutions[index];
	
	var w = res[0];
	var h = res[1];
	
	global.window_w = w;
	global.window_h = h;
	
	data.resolutionIndex = index;
	
	scr_display_refreshWindowSize();
	
}

function scr_display_refreshWindowSize() {

	window_set_size(global.window_w, global.window_h);
	
}