global.hud = self;
player = global.player;
sc = global.stageController;
rc = scr_data_getRunController();
cursor = global.cursor;

//settings
settingsVersion = 0;
var ammoSetting = scr_data_getSetting("showAmmo", 1);
showAmmo = ammoSetting == 0 or ammoSetting == 1 ? true : false;

hub = sc.hub;

depth = layers.ui;
firstStep = true;

instructions = "";
instructionsTick = 0;
instructionsFlash = 0;

miniMap = instance_exists(rc) ? scr_mapGen_createMiniMap(rc.map, false) : undefined;
bigMap = false;

var spent = scr_progression_countSpentSkillPoints()
var totalPoints = scr_progression_getTotalSkillPoints();
var points = max(0, totalPoints - spent);
unspentPoints = points > 0;

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
bigMapY = mapY + 220;

healthBarX = 0;
healthBarY = 0;

energyBarX = 0;
energyBarY = 0;

xpBarX = 0;
xpBarY = 0;

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

lvlTxtX = 0;
lvlTxtY = 0;

ammoX = 0;
ammoY = 0;
reload = 0;
reloadTime = 0;
ammoCol = c_white;
weaponName = "";

ammo = 0;
maxAmmo = 0;

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
dashRecharge = 0;
stimPacks = 0;
energyPacks = 0;
stimPackCool = 0;
energyPackCool = 0;

xp = 0;
xpReq = 0;
lvl = 0;

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

xpBar = instance_create_layer(x, y, "Instances", obj_statusBar);
xpBar.width = 800;
xpBar.height = 10
xpBar.depth = depth - 1;
xpBar.fillCol = #77e3da;

enemyHpBar = instance_create_layer(x, y, "Instances", obj_statusBar);
enemyHpBar.width = 400;
enemyHpBar.height = 16;
enemyHpBar.depth = depth -1;
enemyHpBar.visible = false;
enemyHpBar.txtCol = c_white;

enemyEnergyBar = instance_create_layer(x, y, "Instances", obj_statusBar);
enemyEnergyBar.width = 320;
enemyEnergyBar.height = 14;
enemyEnergyBar.depth = depth -1;
enemyEnergyBar.visible = false;
enemyEnergyBar.fillCol = c_aqua;