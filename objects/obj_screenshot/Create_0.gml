filename = undefined;
spr = undefined;

depth = layers.cursor;

cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam)
camW = camera_get_view_width(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

tick = 32;

alpha = 0.9;

with (obj_screenshot) {

	if (id == other.id) continue;
	
	instance_destroy();
	
}