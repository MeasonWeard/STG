global.hud = self;
player = global.player;
rc = global.runController;
depth = layers.ui;
firstStep = true;

instructions = "";
instructionsTick = 0;
instructionsFlash = 0;

miniMap = scr_mapGen_createMiniMap(rc.map, true);

////formatting
cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam)
camW = camera_get_view_width(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

mapX = camX + 32;
mapY = camY + 32;

healthBarWidth = camW * 0.5;
healthBarHeight = 20;
healthBarLeft = camXmid - healthBarWidth * 0.5;
healthBarRight = camXmid + healthBarWidth * 0.5;
healthBarBottom = camY + camH - 20;
healthBarTop = healthBarBottom - healthBarHeight;