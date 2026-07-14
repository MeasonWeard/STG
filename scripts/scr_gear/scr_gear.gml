function gearInst(level, rarity) constructor {

	name = "none";
	spr = spr_stimPack;
	stats = {};
	description = undefined;
	lvl = level;
	rar = rarity;
	
}

function deviceInst(level, rarity) : gearInst(level, rarity) constructor {

	name = "Device";
	spr = spr_device;

}

function tieInst(level, rarity) : gearInst(level, rarity) constructor {
	
	name = "Tie";
	spr = spr_tie;
	
}

function headgearInst(level, rarity) : gearInst(level, rarity) constructor {

	name = "Headgear";
	spr = spr_headgear;
	
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
	
	var txt = gear.name;
	txt += "\n";
	
	var keys = variable_struct_get_names(stats);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
	
		var stat = keys[i];
		var val = stats[$ stat];
	
		var newText = scr_stats_getName(stat);
		newText += ": " + string(val);
		
		txt += "\n";

		txt += newText;
	
	}
	
	return txt;
	
}