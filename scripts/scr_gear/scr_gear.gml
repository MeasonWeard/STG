function gearInst() constructor {

	name = "none";
	sprite = undefined;
	stats = {};
	
	//levelUp(level) = function() {
	
	//	var keys = variable_struct_get_names(stats);
	//	var keysLen = array_length(keys);
	
	//	for (var i = 0; i < keysLen; i ++) {
		
	//		var key = keys[i];
	//		var val = stats[$ key];
		
	//		var newVal = ceil(val * (level * 1.2));
	//		stats[$ key] = newVal;
		
	//	}
	
	//}

}

function deviceInst() : gearInst() constructor {

	name = "Device";
	
}

function tieInst() : gearInst() constructor {
	
	name = "Tie";
	
}

function headgearInst() : gearInst() constructor {

	name = "Headgear";
	
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