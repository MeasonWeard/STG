function gearInst(level, rarity) constructor {

	type = itemTypes.gear;

	name = "none";
	spr = spr_stimPack;
	stats = {};
	description = undefined;
	lvl = level;
	rar = rarity;
	
}

function deviceInst(level, rarity) : gearInst(level, rarity) constructor {

	type = itemTypes.device;
	name = "Device";
	spr = spr_powerRegulator;

}

function headgearInst(level, rarity) : gearInst(level, rarity) constructor {
	
	type = itemTypes.headgear;
	name = "Headgear";
	spr = spr_safetyGoggles;
	
}

function tieInst(level, rarity) : gearInst(level, rarity) constructor {
	
	type = itemTypes.tie;
	name = "Tie";
	spr = spr_tiePhysics;
	
}

function scr_gear_applyStatsToChar(char, gear) {

	if (!instance_exists(char)) exit;
	if (!is_instanceof(gear, gearInst)) exit;
	
	var keys = variable_struct_get_names(gear.stats);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
		
		var key = keys[i];
		var val = gear.stats[$ key];
		
		if (!variable_struct_exists(char.stats, key)) continue;
		
		char.stats[$ key] += val;
		
	}
	
}

function scr_gear_formatDescription(gear) {

	if (!is_instanceof(gear, gearInst)) return undefined;

	var stats = gear.stats;
	
	var typeTxt = "";
	
	if (is_instanceof(gear, deviceInst)) typeTxt = "Device";
	if (is_instanceof(gear, headgearInst)) typeTxt = "Headgear";
	if (is_instanceof(gear, tieInst)) typeTxt = "Tie";
	
	var txt = gear.name + "     " + "lvl " + string(gear.lvl);
	txt += "\n--" + typeTxt + "--\n";
	
	var keys = variable_struct_get_names(stats);
	
	keys = scr_stats_orderStatKeys(keys);
	
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
	
		var stat = keys[i];
		var val = stats[$ stat];
		
		if (val == 0) continue;
	
		var newText = scr_stats_getName(stat);
		newText += ": " + string(val);
		
		txt += "\n";

		txt += newText;
	
	}
	
	return txt;
	
}