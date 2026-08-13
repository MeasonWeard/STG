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
	
		while (!success and tries < 92) {
			
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
		
		while (!success and tries < 92) {
			
			tries++;
			
			map = scr_mapGen_createBlankMap(mapW, mapH);
			
			var halls = [stage_commHall1];
			var plazas = [stage_commArena1, stage_commArena2];
			var endStages = [stage_wasteBoss1];
			
			var cinemas = [
				stage_commCinema1,
				stage_commCinema2
			];
			
			var markets = [
				stage_commMarket1,
				stage_commMarket2
			];
			
			var clothing = [
				stage_commClothing1,
				stage_commClothing2
			];
			
			
			// -------------------------------------------------
			// Ring settings
			// -------------------------------------------------
			
			var ringW = 5;
			var ringH = 5;
			
			while (ringW == 5 and ringH == 5) {
				ringW = irandom_range(5, 7);
				ringH = irandom_range(5, 7);
			}
			
			var cells = ringW * 2 + (ringH - 2) * 2;

			var plazaAmount = round(cells * random_range(0.4, 0.6));
			var sideRoomAmount = max(3, round(cells * random_range(0.3, 0.5)));
			
			
			// -------------------------------------------------
			// Side room amounts
			// -------------------------------------------------
			
			// Roughly:
			// 50% markets
			// 40% clothing
			// 20% cinemas
			
			var marketAmount = max(1, round(sideRoomAmount * 0.5));
			var clothingAmount = max(1, round(sideRoomAmount * 0.4));
			var cinemaAmount = max(1, sideRoomAmount - marketAmount - clothingAmount);
			
			if (cinemaAmount == 1 and scr_random_chance(20)) cinemaAmount = 2; 
			
			// Correct for rounding if total went over
			while (
				marketAmount
				+ clothingAmount
				+ cinemaAmount
				> sideRoomAmount
			) {
				
				if (marketAmount > clothingAmount and marketAmount > 1) {
					
					marketAmount--;
					
				} else if (clothingAmount > cinemaAmount and clothingAmount > 1) {
					
					clothingAmount--;
					
				} else if (cinemaAmount > 1) {
					
					cinemaAmount--;
					
				}
				
			}
			
			
			// -------------------------------------------------
			// Build side room set
			// -------------------------------------------------
			
			var sideRooms = [];
			
			repeat (marketAmount) {
				
				array_push(
					sideRooms,
					markets[irandom(array_length(markets) - 1)]
				);
				
			}
			
			repeat (clothingAmount) {
				
				array_push(
					sideRooms,
					clothing[irandom(array_length(clothing) - 1)]
				);
				
			}
			
			repeat (cinemaAmount) {
				
				array_push(
					sideRooms,
					cinemas[irandom(array_length(cinemas) - 1)]
				);
				
			}
			
			sideRooms = array_shuffle(sideRooms);
			
			
			// -------------------------------------------------
			// Starting position
			// -------------------------------------------------
			
			// Need to start on an edge
			startPos = scr_mapGen_randomStartingLocation(
				mapW,
				mapH,
				3,
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
			
			var sideResult = scr_mapGen_addRingSideRoomsSet(
				map,
				sideRooms,
				result.ringCells
			);

			if (sideResult.cellCount < array_length(sideRooms)) continue;
			
			
			// -------------------------------------------------
			// End
			// -------------------------------------------------
			
			scr_mapGen_makeFurthestEndCellEmpty(
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
	
		while (!success and tries < 92) {
			
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