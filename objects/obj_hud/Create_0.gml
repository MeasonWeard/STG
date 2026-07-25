global.hud = self;
player = global.player;
sc = global.stageController;
rc = scr_data_getRunController();

hub = sc.hub;

depth = layers.ui;
firstStep = true;

instructions = "";
instructionsTick = 0;
instructionsFlash = 0;

miniMap = instance_exists(rc) ? scr_mapGen_createMiniMap(rc.map, false) : undefined;

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

healthBarX = 0;
healthBarY = 0;

energyBarX = 0;
energyBarY = 0;

dashX = 0;
dashY = 0;

skillsX = 0;
skillsY = 0;
skillsPad = 16;
skillIconW = sprite_get_width(spr_icon_blank);

shieldX = 0;
shieldY = 0;

stimPackX = 0;
energyPackX = 0;

//info
posX = 0;
posY = 0;

hp = 0;
maxHp = 0;
shield = 0;
maxShield = 0;
energy = 0;
maxEnergy = 0;
dashes = 0;
maxDashes = 0;
dashCool = 0;
dashCoolTime = 0;
stimPacks = 0;
energyPacks = 0;
stimPackCool = 0;
energyPackCool = 0;

shieldRecharge = false;

prevHp = 0;
prevShield = 0;
flashAlpha = 0;
flashCol = c_white;
fullFlashAlpha = 0;
fullFlashCol = c_white;

skill1 = undefined;
skill2 = undefined;
skill3 = undefined;
skill4 = undefined;

skills = [skill1, skill2, skill3, skill4];

//bars
healthBar = instance_create_layer(x, y, "Instances", obj_statusBar);
healthBar.width = 400;
healthBar.height = 20;
healthBar.depth = depth - 1;
healthBar.txtCol = c_yellow;

energyBar = instance_create_layer(x, y, "Instances", obj_statusBar);
energyBar.width = 400;
energyBar.height = 20;
energyBar.depth = depth - 1;
energyBar.fillCol = c_aqua;
energyBar.leftToRight = false;
energyBar.txtCol = c_white;