global.hud = self;
player = global.player;
rc = global.runController;
depth = layers.ui;
firstStep = true;

instructions = "";
instructionsTick = 0;
instructionsFlash = 0;

////formatting
cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam)
camW = camera_get_view_width(cam);