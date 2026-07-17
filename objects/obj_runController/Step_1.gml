if (variable_global_exists("stageController")) {

	if (instance_exists(global.stageController)) {
		sc = global.stageController;
	} else {
		sc = noone;
	}
	
}

if (generateMap) {

	randomise();

	generateMap = false;

	zoneInst = new zoneConstructor();
	
	runLevel = zoneInst.zoneLevel + extraLevel;
	
	map = zoneInst.generateMap();
	startPos = zoneInst.startPos;

	startX = startPos.xx;
	startY = startPos.yy;

	posX = startX;
	posY = startY;

	miniMap = scr_mapGen_createMiniMap(map, true);

	currentCell = map[posX][posY];
	currentCell.discovered = true;

	scr_stages_discoverAdjacentCells();

	resources = {};
	loot = {};
	
}