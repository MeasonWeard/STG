function classInst() constructor {
	
	name = "";
	
	id = -1;
	
	majorBonuses = undefined;
	minorBonuses = undefined;

	unlockedSkills = [];

}

function class_physics(): classInst() constructor {

	name = "Physics";
	id = classes.physics;
	
	majorBonuses = {
		radDamPerc: 10
	}
	
	minorBonuses = {
		kinDamPerc: 10
	}
	
}

function class_chemistry(): classInst() constructor {

	name = "Chemistry";
	id = classes.chemistry;
	
	majorBonuses = {
		chemDamPerc: 10
	}
	
	minorBonuses = {
		fireDamPerc: 10
	}
	
}

function class_biology(): classInst() constructor {

	name = "Biology";
	id = classes.biology;
	
	majorBonuses = {
		hpRegenPerc: 15
	}
	
	minorBonuses = {
		maxHpPerc: 10
	}
	
}

function class_engineering(): classInst() constructor {

	name = "Engineering";
	id = classes.engineering;
	
	majorBonuses = {
		elecDamPerc: 10
	}
	
	minorBonuses = {
		energyRegenPerc: 15
	}
	
}

function scr_class_applyMajorStats(class, stats) {

	if (!is_struct(stats)) exit;
	if (!is_struct(class)) exit;
	
	if (!variable_struct_exists(class, "majorBonuses")) exit;
	
	var bonuses = class[$ "majorBonuses"];
	
	var keys = variable_struct_get_names(bonuses);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
	
		var key = keys[i];
		var val = bonuses[$ key];
		
		scr_stats_alterStat(stats, key, val);
	
	}
	
}

function scr_class_applyMinorStats(class, stats) {

	if (!is_struct(stats)) exit;
	if (!is_struct(class)) exit;
	
	if (!variable_struct_exists(class, "minorBonuses")) exit;
	
	var bonuses = class[$ "minorBonuses"];
	
	var keys = variable_struct_get_names(bonuses);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
	
		var key = keys[i];
		var val = bonuses[$ key];
		
		scr_stats_alterStat(stats, key, val);
	
	}
	
	return stats;
	
}

function scr_class_formatClassBonuses(class) {

	if (!is_instanceof(class, classInst)) exit;
	
	var majorBonuses = class.majorBonuses;
	var minorBonuses = class.minorBonuses;
	
	var keys = variable_struct_get_names(majorBonuses);
	var len = array_length(keys);
	
	var majorTxt = "MAJOR BONUSES\n";
	
	for (var i = 0; i < len; i ++) {
	
		var stat = keys[i];

		majorTxt = scr_stats_formatStat(majorTxt, majorBonuses, stat);
	
	}
	
	keys = variable_struct_get_names(minorBonuses);
	len = array_length(keys);
	
	var minorTxt = "MINOR BONUSES\n";
	
	for (var i = 0; i < len; i ++) {
	
		var stat = keys[i];

		minorTxt = scr_stats_formatStat(minorTxt, minorBonuses, stat);
	
	}
	
	return {
		major: majorTxt,
		minor: minorTxt
	};
	
}