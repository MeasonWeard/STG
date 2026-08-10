function scr_zones_startZone(zoneConstructor, extraLevel, destroyPlayer = true) {

	if (instance_exists(global.player)) instance_destroy(global.player);
	
	global.runController = scr_obj_createExclusive(obj_runController, 0, 0);
	var rc = global.runController;
	
	rc.zoneConstructor = zoneConstructor;
	rc.extraLevel = extraLevel;
	
	//room_goto(room_startRun);
	
}

function zone() constructor {

	name = "none";
	portrait = spr_missing;

	baseLevel = 1;
	level = 1;

	mapW = 12;
	mapH = 12;
	
	map = undefined;
	startPos = {
		xx: 0,
		yy: 0
	}
	
	static setup = undefined;

	static generateMap = function() {
		

		map = scr_mapGen_createBlankMap(mapW, mapH);
		
		return map;
		
	}

}

function zone_waste() : zone() constructor {

	name = "Waste Disposal B";
	portrait = spr_toxicCrate;

	mapW = 12;
	mapH = 12;
	
	baseLevel = 3;
	
	static generateMap = function() {
	
		var tries = 0;
		var success = false;
		var map;
	
		while (!success and tries < 12) {
			
			tries ++;
			
			map = scr_mapGen_createBlankMap(mapW, mapH);
			startPos = scr_mapGen_randomStartingLocation(mapW, mapH, 2, true);
		
			//var stages = ["wasteArena1","wasteArenaLava1","wasteArenaAcid1"];
			var halls = [stage_wasteHall1, stage_wasteHall2];//[stage_wasteArena1, stage_wasteArenaAcid1, stage_wasteArenaLava1];
			var sideRooms = [stage_wasteArena1, stage_wasteArenaAcid1, stage_wasteArenaAcid2, stage_wasteArenaLava1];
			var endStages = [stage_wasteBoss1];

			var startX = startPos.xx;
			var startY = startPos.yy;

			var mainLength = irandom_range(8, 12);
			var sideHallAmount = irandom_range(3, 6);
			var sideRoomsAmount = irandom_range(6, 8);
			var replaceRoomsAmount = irandom_range(6, 8);
			
			var result = scr_mapGen_generateHallways(map, halls, startX, startY, mainLength, sideHallAmount, 2, 5);
			var cellCount = result.cellCount;
			
			result = scr_mapGen_addSideRooms(map, sideRooms, sideRoomsAmount);
			cellCount += result.cellCount;
			
			result = scr_mapGen_replaceRooms(map, sideRooms, replaceRoomsAmount, stageTypes.hall);

			success = cellCount > 20;
			if (!success) continue;

			scr_mapGen_makeFurthestEndCell(map, startX, startY, endStages);
		
		}

		return map;
	
	}
	
}

//function zone_commercial() : zone() constructor {

//	name = "Commercial";
//	portrait = spr_poster1;

//	mapW = 12;
//	mapH = 12;
	
//	baseLevel = 1;
	
//	static generateMap = function() {
	
//		var tries = 0;
//		var success = false;
//		var map;
	
//		while (!success and tries < 12) {
			
//			tries ++;
			
//			map = scr_mapGen_createBlankMap(mapW, mapH);
//			startPos = scr_mapGen_randomStartingLocation(mapW, mapH, 2, true);
		
//			//var stages = ["wasteArena1","wasteArenaLava1","wasteArenaAcid1"];
//			var halls = [stage_commHall1];//[stage_wasteArena1, stage_wasteArenaAcid1, stage_wasteArenaLava1];
//			var plazas = [stage_commArena1];
//			var sideRooms = [stage_commCinema];
//			var endStages = [stage_wasteBoss1];

//			var startX = startPos.xx;
//			var startY = startPos.yy;

//			var mainLength = irandom_range(8, 12);
//			var sideHallAmount = irandom_range(3, 6);
//			var sideRoomsAmount = irandom_range(6, 8);
//			var replaceRoomsAmount = irandom_range(6, 8);
			
//			var result = scr_mapGen_generateHallways(map, halls, startX, startY, mainLength, sideHallAmount, 2, 5);
//			var cellCount = result.cellCount;
			
//			result = scr_mapGen_addSideRooms(map, sideRooms, sideRoomsAmount);
//			cellCount += result.cellCount;
			
//			result = scr_mapGen_replaceRooms(map, sideRooms, replaceRoomsAmount, stageTypes.hall);

//			success = cellCount > 20;
//			if (!success) continue;

//			scr_mapGen_makeFurthestEndCell(map, startX, startY, endStages);
		
//		}

//		return map;
	
//	}
	
//}

function zone_commercial() : zone() constructor {

	name = "Commercial";
	portrait = spr_poster1;

	mapW = 12;
	mapH = 12;
	
	baseLevel = 1;
	
	static generateMap = function() {
	
		var tries = 0;
		var success = false;
		var map;
		
		while (!success and tries < 24) {
			
			tries++;
			
			map = scr_mapGen_createBlankMap(mapW, mapH);
			
			var halls = [stage_commHall1];
			var plazas = [stage_commArena1];
			var sideRooms = [stage_commCinema1, stage_commCinema2, stage_commMarket1, stage_commMarket1];
			var endStages = [stage_wasteBoss1];
			
			
			// -------------------------------------------------
			// Ring settings
			// -------------------------------------------------
			
			var ringW = irandom_range(5, 7);
			var ringH = irandom_range(5, 7);
			
			var cells = ringW * 2 + (ringH - 2) * 2;
			
			var high = ceil(cells * 0.5);
			var plazaLow = max(2, high - 2);
			var sideLow = max(2, high - 4);
			
			var plazaAmount = irandom_range(plazaLow, high);
			var sideRoomAmount = irandom_range(sideLow, high);
			
			
			
			// Need to start on an edge
			startPos = scr_mapGen_randomStartingLocation(
				mapW,
				mapH,
				2,
				true
			);
			
			
			// -------------------------------------------------
			// Generate ring
			// -------------------------------------------------
			
			var result = scr_mapGen_generateRing(
				map,
				halls,
				startPos,
				ringW,
				ringH
			);
			
			if (!result.success) continue;
				

			
			// -------------------------------------------------
			// Replace some ring halls with plazas
			// -------------------------------------------------
			
			scr_mapGen_replaceRooms(
				map,
				plazas,
				plazaAmount,
				stageTypes.hall
			);
			
			
			// -------------------------------------------------
			// Add shops/side rooms inside + outside ring
			// -------------------------------------------------
			
			scr_mapGen_addRingSideRooms(
				map,
				sideRooms,
				result.ringCells,
				sideRoomAmount
			);
			
			
			// -------------------------------------------------
			// End
			// -------------------------------------------------
			
			scr_mapGen_makeFurthestEndCell(
				map,
				startPos.xx,
				startPos.yy,
				endStages
			);
			
			success = true;
			
		}

		return map;
	
	}
	
}

function zone_wasteTest() : zone() constructor {

	name = "Waste Disposal A";
	portrait = spr_toxicCrate;

	mapW = 12;
	mapH = 12;
	
	baseLevel = 1;
	
	static generateMap = function() {
	
		var tries = 0;
		var success = false;
		var map;
	
		while (!success and tries < 12) {
			
			tries ++;
			
			map = scr_mapGen_createBlankMap(mapW, mapH);
			startPos = scr_mapGen_randomStartingLocation(mapW, mapH, 2, true);
		
			//var stages = ["wasteArena1","wasteArenaLava1","wasteArenaAcid1"];
			var halls = [stage_wasteHall1, stage_wasteHall2];//[stage_wasteArena1, stage_wasteArenaAcid1, stage_wasteArenaLava1];
			var sideRooms = [stage_wasteArena1, stage_wasteArenaAcid1, stage_wasteArenaAcid2, stage_wasteArenaLava1];
			var endStages = [stage_wasteBoss1];

			var startX = startPos.xx;
			var startY = startPos.yy;

			var mainLength = irandom_range(8, 12);
			var sideHallAmount = irandom_range(3, 6);
			var sideRoomsAmount = irandom_range(6, 8);
			var replaceRoomsAmount = irandom_range(6, 8);
			
			var result = scr_mapGen_generateHallways(map, halls, startX, startY, mainLength, sideHallAmount, 2, 5);
			var cellCount = result.cellCount;
			
			result = scr_mapGen_addSideRooms(map, sideRooms, sideRoomsAmount);
			cellCount += result.cellCount;
			
			result = scr_mapGen_replaceRooms(map, sideRooms, replaceRoomsAmount, stageTypes.hall);

			success = cellCount > 20;
			if (!success) continue;

			scr_mapGen_makeFurthestEndCell(map, startX, startY, endStages);
		
		}

		return map;
	
	}
	
}