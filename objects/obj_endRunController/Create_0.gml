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

//GENERATE LOOT
var lootOrbs 
loot = [];
