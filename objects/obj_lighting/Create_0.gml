depth = layers.lighting;

cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam);
camW = camera_get_view_width(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

cols = [c_red, c_blue, c_green];

transitionFreq = 1;
transitionSmoothness = 1;

transitionPos = 0;

alpha = 0.3;

pad = 256;