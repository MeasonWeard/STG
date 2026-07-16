data = global.data;
gameData = global.gameData;
rc = global.runController;
global.endRunController = self;

resources = rc.resources;

tabs = ["resources", "xp", "loot","continue"];
tabIndex = 0;
tab = tabs[tabIndex];

keyPressDelay = 12;
returnToHubTick = 180;

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

lootTop = titleY + 100;
lootSlotSize = 128;
lootSlotGap = 16;
lootPage = 0;
lootColumns = 8;
lootRows = 4;

var rowLength = lootSlotSize * lootColumns + lootSlotGap * (lootColumns - 1);
var spareSpace = room_width - rowLength;

lootLeft = spareSpace * 0.5;

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
scrap = function(lootKey) {
	
	var ec = global.endRunController;
	
	variable_instance_set(ec.id, lootKey, 0);
	
	audio_play_sound(snd_recycle, 0, false);
	
}

reveal = function(lootKey) {
	
	var ec = global.endRunController;
	
	ec.revealKey = lootKey;
	ec.tab = "reveal";
	
}

scrapRevealed = function(index) {
	
	var ec = global.endRunController;
	
	ec.revealedLoot[index] = undefined;
	
	audio_play_sound(snd_recycle, 0, false);
	
}

scrapAll = function() {

	var ec = global.endRunController;
	
	//do something in a for loop
	
	revealedLoot = [];
	
	ec.tab = "loot";
	
	lootPage = 0;
	
	audio_play_sound(snd_recycle, 0, false);
		
}

takeAll = function() {

	var ec = global.endRunController;
	
	var revealedLen = array_length(revealedLoot);
	
	for (var i = 0; i < revealedLen; i++) {
		
		var entry = revealedLoot[i];
		
		if (!is_instanceof(entry, weaponInst) and !is_instanceof(entry, gearInst)) continue;
		
		array_push(takenLoot, entry);
		
	}
	
	revealedLoot = [];
	
	lootPage = 0;
	
	ec.tab = "loot";
		
}

finish = function () {

	scr_loot_saveToStash(takenLoot);
	
	scr_file_saveGame(global.saveFile, global.gameData);
	
	room_goto(stage_hub1);
	
	global.hubPosX = -1;
	global.hubPosY = -1;
	
}

prevPage = function() {

	lootPage --;
	if (lootPage < 0) lootPage = 0;

}

nextPage = function() {
	
	lootPage++;
	
}

loot = rc.loot;
revealKey = undefined;
revealedLoot = [];
takenLoot = [];

alpha = variable_struct_exists(loot, "alpha") ? loot[$ "alpha"] : 0;
beta = variable_struct_exists(loot, "beta") ? loot[$ "beta"] : 0;
gamma = variable_struct_exists(loot, "gamma") ? loot[$ "gamma"] : 0;
delta = variable_struct_exists(loot, "delta") ? loot[$ "delta"] : 0;
sigma = variable_struct_exists(loot, "sigma") ? loot[$ "sigma"] : 0;
omega = variable_struct_exists(loot, "omega") ? loot[$ "omega"] : 0;

//test data
//alpha = 99;
//beta = 99;
//gamma = 30;
//delta = 30;
//sigma = 30;
//omega = 30;
//

lootButtons = [];

//alpha
alphaReveal = instance_create_layer(lxb1, ly1, "Instances", obj_buttonRectangle);
alphaScrap = instance_create_layer(lxb2, ly1, "Instances", obj_buttonRectangle);

alphaReveal.txt = "Reveal";
alphaReveal.leftFunc = reveal;
alphaReveal.leftArgs = ["alpha"];

alphaScrap.txt = "Scrap";
alphaScrap.leftFunc = scrap;
alphaScrap.leftArgs = ["alpha"];

//beta
betaReveal = instance_create_layer(lxb1, ly2, "Instances", obj_buttonRectangle);
betaScrap = instance_create_layer(lxb2, ly2, "Instances", obj_buttonRectangle);

betaReveal.txt = "Reveal";
betaReveal.leftFunc = reveal;
betaReveal.leftArgs = ["beta"];

betaScrap.txt = "Scrap";
betaScrap.leftFunc = scrap;
betaScrap.leftArgs = ["beta"];

//gamma
gammaReveal = instance_create_layer(lxb1, ly3, "Instances", obj_buttonRectangle);
gammaScrap = instance_create_layer(lxb2, ly3, "Instances", obj_buttonRectangle);

gammaReveal.txt = "Reveal";
gammaReveal.leftFunc = reveal;
gammaReveal.leftArgs = ["gamma"];

gammaScrap.txt = "Scrap";
gammaScrap.leftFunc = scrap;
gammaScrap.leftArgs = ["gamma"];

//delta
deltaReveal = instance_create_layer(lxb1, ly4, "Instances", obj_buttonRectangle);
deltaScrap = instance_create_layer(lxb2, ly4, "Instances", obj_buttonRectangle);

deltaReveal.txt = "Reveal";
deltaReveal.leftFunc = reveal;
deltaReveal.leftArgs = ["delta"];

deltaScrap.txt = "Scrap";
deltaScrap.leftFunc = scrap;
deltaScrap.leftArgs = ["delta"];

//sigma
sigmaReveal = instance_create_layer(lxb1, ly5, "Instances", obj_buttonRectangle);
sigmaScrap = instance_create_layer(lxb2, ly5, "Instances", obj_buttonRectangle);

sigmaReveal.txt = "Reveal";
sigmaReveal.leftFunc = reveal;
sigmaReveal.leftArgs = ["sigma"];

sigmaScrap.txt = "Scrap";
sigmaScrap.leftFunc = scrap;
sigmaScrap.leftArgs = ["sigma"];

//omega
omegaReveal = instance_create_layer(lxb1, ly6, "Instances", obj_buttonRectangle);
omegaScrap = instance_create_layer(lxb2, ly6, "Instances", obj_buttonRectangle);

omegaReveal.txt = "Reveal";
omegaReveal.leftFunc = reveal;
omegaReveal.leftArgs = ["omega"];

omegaScrap.txt = "Scrap";
omegaScrap.leftFunc = scrap;
omegaScrap.leftArgs = ["omega"];

//reveal screen buttons
takeButton = instance_create_layer(xMid - 100, titleY + 30, "Instances", obj_buttonRectangle);
takeButton.txt = "Take All";
takeButton.leftFunc = takeAll;

scrapAllButton = instance_create_layer(xMid + 100, titleY + 30, "Instances", obj_buttonRectangle);
scrapAllButton.txt = "Scrap All";
scrapAllButton.leftFunc = scrapAll;

//page buttons
prevPageButton = instance_create_layer(xMid + 350, titleY + 30, "Instances", obj_buttonSquare);
prevPageButton.txt = "<";
prevPageButton.leftFunc = prevPage;

nextPageButton = instance_create_layer(xMid + 400, titleY + 30, "Instances", obj_buttonSquare);
nextPageButton.txt = ">";
nextPageButton.leftFunc = nextPage;

pageTextX = (prevPageButton.x + nextPageButton.x) * 0.5;

//deactivate all

array_push(lootButtons, alphaReveal, alphaScrap, betaReveal, betaScrap, gammaReveal, gammaScrap,
deltaReveal, deltaScrap, sigmaReveal, sigmaScrap, omegaReveal, omegaScrap, takeButton, scrapAllButton,
prevPageButton, nextPageButton);

var lootButtonsLen = array_length(lootButtons);
for (var i = 0; i < lootButtonsLen; i ++) {

	var button = lootButtons[i];
	button.active = false;
	button.visibleWhenInactive = false;
	
}