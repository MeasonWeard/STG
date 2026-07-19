function scr_zones_startZone(zoneConstructor, extraLevel) {

	if (instance_exists(global.player)) instance_destroy(global.player);
	global.runController = scr_obj_createExclusive(obj_runController, 0, 0);
	var rc = global.runController;
	
	rc.zoneConstructor = zoneConstructor;
	rc.extraLevel = extraLevel;
	
	room_goto(room_startRun);
	
}

function zone() constructor {

	zoneLevel = 4;

	mapW = 12;
	mapH = 12;
	
	map = undefined;
	startPos = {
		xx: 0,
		yy: 0
	}

	static generateMap = function() {
		

		map = scr_mapGen_createBlankMap(mapW, mapH);
		
		return map;
		
	}

}

function zone_industrial() : zone() constructor {

	mapW = 12;
	mapH = 12;
	
	static generateMap = function() {
	
		map = scr_mapGen_createBlankMap(mapW, mapH);
		startPos = scr_mapGen_randomStartingLocation(mapW, mapH, 1);
		
		var stages = ["engHall3"];
		//var stages = ["engComputerRoom", "engHall1", "engHall2"];
		var endStages = ["engBoss1"];

		var startX = startPos.xx;
		var startY = startPos.yy;

		scr_mapGen_randomWalk(map, stages, startX, startY, 15);
		scr_mapGen_makeFurthestEndCell(map, startX, startY, endStages);

		return map;
	
	}
	
}