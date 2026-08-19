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

function coatInst(level, rarity) : gearInst(level, rarity) constructor {

	type = itemTypes.coat;
	name = "Coat";
	spr = spr_coat;
	
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
	if (is_instanceof(gear, coatInst)) typeTxt = "Coat";
	
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

function scr_gear_getHighestResistanceType(gear, randomiseTies = true) {

	if (!is_struct(gear)) return undefined;
	if (!is_struct(gear.stats)) return undefined;

	var stats = gear.stats;
	var keys = ["kin", "fire", "chem", "elec", "rad"];

	var highest = -999999;
	var best = [];

	for (var i = 0; i < array_length(keys); i++) {

		var key = keys[i];
		var statKey = key + "Res";
		var val = stats[$ statKey];

		if (val > highest) {

			highest = val;
			best = [key];

		} else if (val == highest) {

			array_push(best, key);

		}

	}

	var key;

	if (randomiseTies) {
		key = best[irandom(array_length(best) - 1)];
	} else {
		key = best[0];
	}

	return {
		key: key,
		val: highest
	};

}

function scr_gear_getTop2ResistanceTypes(gear, randomiseTies = true) {

	if (!is_struct(gear)) return [];
	if (!is_struct(gear.stats)) return [];

	var stats = gear.stats;
	var keys = ["kin", "fire", "chem", "elec", "rad"];

	var entries = [];

	// Build list of positive resistance types
	for (var i = 0; i < array_length(keys); i++) {

		var key = keys[i];
		var val = stats[$ key + "Res"];

		if (val > 0) {
			array_push(entries, {
				key: key,
				val: val
			});
		}

	}

	if (array_length(entries) == 0) return [];

	var result = [];

	repeat (2) {

		if (array_length(entries) == 0) break;

		// Find highest value remaining
		var highest = -1;
		var best = [];

		for (var i = 0; i < array_length(entries); i++) {

			var entry = entries[i];

			if (entry.val > highest) {

				highest = entry.val;
				best = [entry];

			} else if (entry.val == highest) {

				array_push(best, entry);

			}

		}

		// Resolve ties
		var chosen;

		if (randomiseTies) {
			chosen = best[irandom(array_length(best) - 1)];
		} else {
			chosen = best[0];
		}

		array_push(result, chosen);

		// Remove chosen so next iteration finds the next type
		for (var i = 0; i < array_length(entries); i++) {

			if (entries[i].key == chosen.key) {
				array_delete(entries, i, 1);
				break;
			}

		}

	}

	return result;

}

function scr_gear_getHighestEffectiveResistanceType(gear, randomiseTies = true) {

	if (!is_struct(gear)) return undefined;
	if (!is_struct(gear.stats)) return undefined;

	var stats = gear.stats;
	var keys = ["kin", "fire", "chem", "elec", "rad"];

	var highest = 0;
	var best = [];

	for (var i = 0; i < array_length(keys); i++) {

		var key = keys[i];
		var resKey = key + "Res";
		var percKey = key + "ResPerc";

		var res = variable_struct_exists(stats, resKey) ? stats[$ resKey] : 0;
		var perc = variable_struct_exists(stats, percKey) ? stats[$ percKey] : 0;

		var val = res * (1 + perc * 0.01);

		if (val > highest) {

			highest = val;
			best = [key];

		} else if (val == highest and val > 0) {

			array_push(best, key);

		}

	}

	if (array_length(best) == 0) return undefined;

	var key;

	if (randomiseTies) {
		key = best[irandom(array_length(best) - 1)];
	} else {
		key = best[0];
	}

	return {
		key: key,
		val: highest
	};

}