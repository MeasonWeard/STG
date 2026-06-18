global.hud = self;
player = global.player;
rc = global.runController;
depth = layers.ui;
firstStep = true;

instructions = "";
instructionsTick = 0;
instructionsFlash = 0;

miniMap = scr_mapGen_createMiniMap(rc.map, true);

//formatting
cam = view_camera[0];
camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camH = camera_get_view_height(cam)
camW = camera_get_view_width(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

mapX = camX + 32;
mapY = camY + 32;

healthBarX = camXmid;
healthBarY = camY + camH - 20;

//info
hp = 0;
maxHp = 0;
shield = 0;
maxShield = 0;
dashes = 0;
maxDashes = 0;
dashCool = 0;
dashCoolTime = 0;

//bars
healthBar = instance_create_layer(x, y, "Instances", obj_statusBar);
healthBar.width = camW * 0.3;
healthBar.height = 20;
healthBar.depth = depth - 1;