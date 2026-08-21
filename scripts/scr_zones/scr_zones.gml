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
	textCol = c_black;

	baseLevel = 1;
	level = 1;

	mapW = 12;
	mapH = 12;
	
	map = undefined;
	startPos = {
		xx: 0,
		yy: 0
	}
	
	minorGroups = [];
	majorGroups = [];
	
	static setup = undefined;

	static generateMap = function() {
		

		map = scr_mapGen_createBlankMap(mapW, mapH);
		
		return map;
		
	}

}

function zone_waste() : zone() constructor {

	name = "Waste Disposal A";
	portrait = spr_wasteDisposalPortrait;
	textCol = c_green;

	mapW = 12;
	mapH = 12;
	
	baseLevel = 3;
	
	var groups = scr_spawns_testGroups();
	minorGroups = groups.minor;
	majorGroups = groups.major;

	static generateMap = function() {
	
		var tries = 0;
		var success = false;
		var map;
	
		while (!success and tries < 92) {
			
			tries ++;
			
			map = scr_mapGen_createBlankMap(mapW, mapH);
			startPos = scr_mapGen_randomStartingLocation(mapW, mapH, 2, true);
		
			var halls = [stage_wasteHall1, stage_wasteHall2];
			var arenas = [stage_wasteArena1, stage_wasteArena2, stage_wasteArenaAcid1, stage_wasteArenaAcid2, stage_wasteArenaLava1];
			var sideRooms = [stage_wasteIncinerator1, stage_wasteIncinerator2, stage_wasteAcidRiver];
			var endStages = [stage_wasteBoss1];

			var startX = startPos.xx;
			var startY = startPos.yy;

			var mainLength = irandom_range(8, 12);
			var sideHallAmount = irandom_range(3, 6);
			
			var result = scr_mapGen_generateHallways(map, halls, startX, startY, mainLength, sideHallAmount, 2, 5);
			var cellCount = result.cellCount;
			
			var arenasMin = ceil(cellCount * 0.1);
			var arenasMax = arenasMin + 2;
			
			var sideMin = ceil(cellCount * 0.3);
			var sideMax = arenasMin + 2;
			
			var arenasReplace = ceil(cellCount * 0.3);
			
			var sideRoomsAmount = irandom_range(sideMin, sideMax);
			var arenasAmount = irandom_range(arenasMin, arenasMax);
			
			result = scr_mapGen_addSideRooms(map, arenas, arenasAmount);
			cellCount += result.cellCount;
			
			result = scr_mapGen_addSideRooms(map, sideRooms, sideRoomsAmount);
			cellCount += result.cellCount;
			
			result = scr_mapGen_replaceRooms(map, arenas, arenasReplace, stageTypes.hall);

			success = cellCount > 20;
			if (!success) continue;

			scr_mapGen_makeFurthestEndCell(map, startX, startY, endStages);
		
		}

		return map;
	
	}
	
}

function zone_commercial() : zone() constructor {

	name = "Commercial Zone";
	portrait = spr_commercialPortrait;
	textCol = c_fuchsia;

	mapW = 12;
	mapH = 12;
	
	baseLevel = 1;
	
	var groups = scr_spawns_testGroups();
	minorGroups = groups.minor;
	majorGroups = groups.major;
	
	static generateMap = function() {
	
		var tries = 0;
		var success = false;
		var map;
		
		while (!success and tries < 92) {
			
			tries++;
			
			map = scr_mapGen_createBlankMap(mapW, mapH);
			
			var halls = [stage_commHall1, stage_commHall2];
			var plazas = [stage_commPlaza1, stage_commPlaza2, stage_commPlaza3, stage_commPlaza4, stage_commPlaza5];
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

function zone_hydro() : zone() constructor {

	name = "Hydroponics";
	portrait = spr_acidPit;
	textCol = c_navy;

	mapW = 12;
	mapH = 12;
	
	baseLevel = 5;
	
	var groups = scr_spawns_testGroups();
	minorGroups = groups.minor;
	majorGroups = groups.major;

	static generateMap = function() {
	
		var tries = 0;
		var success = false;
		var map;
	
		while (!success and tries < 92) {
			
			tries ++;
			
			map = scr_mapGen_createBlankMap(mapW, mapH);
			startPos = scr_mapGen_randomStartingLocation(mapW, mapH, 2, true);
		
			var halls = [stage_hydroHall1];
			var arenas = [stage_hydroLabs1];
			var sideRooms = [stage_hydroLabs1];
			var endStages = [stage_wasteBoss1];

			var startX = startPos.xx;
			var startY = startPos.yy;

			var mainLength = irandom_range(8, 12);
			var sideHallAmount = irandom_range(3, 6);
			
			var result = scr_mapGen_generateHallways(map, halls, startX, startY, mainLength, sideHallAmount, 2, 5);
			var cellCount = result.cellCount;
			
			var arenasMin = ceil(cellCount * 0.1);
			var arenasMax = arenasMin + 2;
			
			var sideMin = ceil(cellCount * 0.3);
			var sideMax = arenasMin + 2;
			
			var arenasReplace = ceil(cellCount * 0.3);
			
			var sideRoomsAmount = irandom_range(sideMin, sideMax);
			var arenasAmount = irandom_range(arenasMin, arenasMax);
			
			result = scr_mapGen_addSideRooms(map, arenas, arenasAmount);
			cellCount += result.cellCount;
			
			result = scr_mapGen_addSideRooms(map, sideRooms, sideRoomsAmount);
			cellCount += result.cellCount;
			
			result = scr_mapGen_replaceRooms(map, arenas, arenasReplace, stageTypes.hall);

			success = cellCount > 20;
			if (!success) continue;

			scr_mapGen_makeFurthestEndCell(map, startX, startY, endStages);
		
		}

		return map;
	
	}
	
}