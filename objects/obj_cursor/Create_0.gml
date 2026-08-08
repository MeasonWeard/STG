//setup
player = noone;
playerExists = false;
depth = layers.cursor;

sc = noone;
enemy = noone;
enemyPad = 16;

//settings
settingsVersion = 0;

var ammoSetting = scr_data_getSetting("showAmmo", 1);
showAmmo = ammoSetting == 0 or ammoSetting == 2 ? true : false;

showReload = scr_data_getSetting("showReloadOnCursor", true);
alwaysShowName = scr_data_getSetting("alwaysShowWeaponName", false);

//formatting
meleeBarWidth = 48;
meleeBarHeight = 8;
meleeBarCol = c_yellow;
meleeNumX = x;
meleeNumY = y;
meleeBarLeft = x;
meleeBarRight = x;
meleeBarTop = y;
meleeBarBottom = y;

ammoNumX = 0;
ammoNumY = 0;

reloadBarCol = c_white;
reloadBarWidth = 64;
reloadBarHeight = 8;
reloadBarLeft = 0;
reloadBarRight = 0;
reloadBarTop = 0;
reloadBarBottom = 0;

gunNameX = x;
gunNameY = y;

gunNameTick = 0;
prevWeapon = undefined;

if (variable_global_exists("player")) {

	if (instance_exists(global.player)) player = global.player;

}

mode = "aim";

hoverTxt = undefined;
hoverTxtCount = 0;
hoverFont = fnt_normal;

enemyCheckTick = 0;