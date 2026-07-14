data = global.data;
gameData = global.gameData;
rc = global.runController;

resources = rc.resources;

tabs = ["resources", "xp", "loot"];
tabIndex = 0;
tab = tabs[tabIndex];

keyPressDelay = 12;

//formatting
scr_misc_resetTextAlignment();
draw_set_font(fnt_normal);
draw_set_colour(c_lime);

xMid = room_width * 0.5;
yMid = room_height * 0.5;

titleX = xMid;
titleY = yMid - 260;

iconGap = 98;
rowGap = 160;

lootOrbGap = 82;
lootOrbX = xMid - 128;
lootOrbY = yMid - 120

lootOrbTextX = lootOrbX + lootOrbGap;

lx = lootOrbX;
lxb1 = lx + 200;
lxb2 = lxb1 + 180;
ly1 = lootOrbY;
ly2 = lootOrbY + lootOrbGap;
ly3 = lootOrbY + lootOrbGap * 2;
ly4 = lootOrbY + lootOrbGap * 3;
ly5 = lootOrbY + lootOrbGap * 4;
ly6 = lootOrbY + lootOrbGap * 5;

//FORMAT RESOURCES
resTick = 15;
resRevealed = 0;

resKeys = variable_struct_get_names(resources);
resKeys = scr_data_arrayOrdered(resKeys, data.resourceOrder);
resKeysLen = array_length(resKeys);

var iconsPerRow = 6;
var rows = ceil(resKeysLen / iconsPerRow);

for (var i = 0; i < resKeysLen; i++) {

	var key = resKeys[i];
	var res = resources[$ key];

	var row = i div iconsPerRow;
	var col = i mod iconsPerRow;

	var rowStartIndex = row * iconsPerRow;
	var iconsThisRow = min(iconsPerRow, resKeysLen - rowStartIndex);

	var rowWidth = (iconsThisRow - 1) * iconGap;

	var xx = xMid - rowWidth * 0.5 + col * iconGap;
	var yy = yMid - 128 - (rows - 1) * rowGap * 0.5 + row * rowGap;

	var splitName = string_split(res.name, " ");
	var splitLen = array_length(splitName);
	
	var txt = string(res.val) + "\n\n";
	
	for (var j = 0; j < splitLen; j ++) {
		if (j > 0) txt += "\n";
		txt += splitName[j];
	}

	res.xx = xx;
	res.yy = yy;
	res.txt = txt;	

}

//XP
xpDisplay = gameData.playerData.xp;
level = gameData.playerData.level;

dataCollected = variable_struct_exists(resources, "data") ? resources[$ "data"].val : 0;
newXp = dataCollected;

xpNeeded = scr_progression_xpRequired(level);

xpFinished = false;

xpBar = instance_create_layer(xMid, yMid, "Instances", obj_statusBar);
xpBar.visible = false;
xpBar.width = 800;
xpBar.height = 25;
xpBar.fillCol = #77e3da;

//LOOT
loot = rc.loot;

alpha = variable_struct_exists(loot, "alpha") ? loot[$ "alpha"] : 0;
beta = variable_struct_exists(loot, "beta") ? loot[$ "beta"] : 0;
gamma = variable_struct_exists(loot, "gamma") ? loot[$ "gamma"] : 0;
delta = variable_struct_exists(loot, "delta") ? loot[$ "delta"] : 0;
sigma = variable_struct_exists(loot, "sigma") ? loot[$ "sigma"] : 0;
omega = variable_struct_exists(loot, "omega") ? loot[$ "omega"] : 0;

lootButtons = [];

alphaReveal = instance_create_layer(lxb1, ly1, "Instances", obj_buttonRectangle);
alphaScrap = instance_create_layer(lxb2, ly1, "Instances", obj_buttonRectangle);
alphaReveal.active = false;
alphaScrap.active = false;
alphaReveal.txt = "Reveal";
alphaScrap.txt = "Scrap";

betaReveal = instance_create_layer(lxb1, ly2, "Instances", obj_buttonRectangle);
betaScrap = instance_create_layer(lxb2, ly2, "Instances", obj_buttonRectangle);
betaReveal.active = false;
betaScrap.active = false;
betaReveal.txt = "Reveal";
betaScrap.txt = "Scrap";

gammaReveal = instance_create_layer(lxb1, ly3, "Instances", obj_buttonRectangle);
gammaScrap = instance_create_layer(lxb2, ly3, "Instances", obj_buttonRectangle);
gammaReveal.txt = "Reveal";
gammaScrap.txt = "Scrap";

deltaReveal = instance_create_layer(lxb1, ly4, "Instances", obj_buttonRectangle);
deltaScrap = instance_create_layer(lxb2, ly4, "Instances", obj_buttonRectangle);

deltaReveal.txt = "Reveal";
deltaScrap.txt = "Scrap";

sigmaReveal = instance_create_layer(lxb1, ly5, "Instances", obj_buttonRectangle);
sigmaScrap = instance_create_layer(lxb2, ly5, "Instances", obj_buttonRectangle);
sigmaReveal.txt = "Reveal";
sigmaScrap.txt = "Scrap";

omegaReveal = instance_create_layer(lxb1, ly6, "Instances", obj_buttonRectangle);
omegaScrap = instance_create_layer(lxb2, ly6, "Instances", obj_buttonRectangle);
omegaReveal.txt = "Reveal";
omegaScrap.txt = "Scrap";

array_push(lootButtons, alphaReveal, alphaScrap, betaReveal, betaScrap, gammaReveal, gammaScrap,
deltaReveal, deltaScrap, sigmaReveal, sigmaScrap, omegaReveal, omegaScrap);

var lootButtonsLen = array_length(lootButtons);
for (var i = 0; i < lootButtonsLen; i ++) {

	var button = lootButtons[i];
	button.active = false;
	button.visibleWhenInactive = false;
	
}