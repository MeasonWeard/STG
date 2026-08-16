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
	
	runLevel = zoneInst.baseLevel + extraLevel;
	
	zoneInst.level = runLevel;
	
	if (is_callable(zoneInst.setup)) zoneInst.setup();
	
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

if (generateWeights) {

	generateWeights = false;

	var minLevel = max(0, runLevel - 5);
	var maxLevel = runLevel + 2;

	levelWeights = [];

	for (var newLevel = minLevel; newLevel <= maxLevel; newLevel++) {

		var offset = newLevel - runLevel;
		var weight = 0;

		switch (offset) {

			case -5: weight = 10;   break;
			case -4: weight = 20;  break;
			case -3: weight = 40;  break;
			case -2: weight = 60;  break;
			case -1: weight = 80;  break;
			case  0: weight = 100; break;
			case  1: weight = 20;  break;
			case  2: weight = 10;   break;

		}

		array_push(levelWeights, [newLevel, weight]);

	}
	
}

if (generateGroups) {

	generateGroups = false;
	
	if (is_struct(zoneInst)) {
	
		minorGroups = [];

		for (var i = 0; i < array_length(zoneInst.minorGroups); i++) {
			
			var group = zoneInst.minorGroups[i].calculate(runLevel);

			if (array_length(group) > 0) {
				array_push(minorGroups, group);
			}

		}
	
		majorGroups = [];

		for (var i = 0; i < array_length(zoneInst.majorGroups); i++) {

			var group = zoneInst.majorGroups[i].calculate(runLevel);

			if (array_length(group) > 0) {
				array_push(majorGroups, group);
			}

		}
	
	}
	
}