function scr_devices_laserPointer(level, rarity) {

	var device = new deviceInst();
	var stats = device.stats;

	var type1 = choose("precise", "bright");
	var type2 = choose("hot", "ionizing", "malfunctioning", "", "", "")
	
	//type1	
	var low = 15 + level * 2;
	var high = 25 + level * 3;
	
	var statChange = irandom_range_biased(low, high, LOOT_BIAS, true);
		
	if (type1 == "precise") stats.oa += statChange;
	if (type2 == "bright") stats.da += statChange;
	
	//type2
	low = level + level * 3;
	high = level * 2 + level * 4;
		
	var dam = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	if (type2 == "hot") stats.fireDam += dam;
	if (type2 == "ionizing") stats.radDam += dam;
	if (type2 == "malfunctioning") stats.elecDam += dam;
	
	var name;
	
	append_string(name, type1, true);
	append_string(name, type2, true);
	append_string(name, "laser pointer", true);
	
	device.name = name;
	
	return device;
	
}

function scr_devices_watch(level, rarity) {

	var device = new deviceInst();
	var stats = device.stats;

	//to do: some don't have regen type

	var type = choose("digital", "analog");
	var regenType = choose(undefined, undefined, "oximetric", "electroscopic");
	
	if (type == "digital") {
	
		var low = 0.1 * level + 0.1;
		var list = [low, low + 0.1, low + 0.2, low + 0.3, low + 0.4];
		var len = array_length(list);
		var index = irandom_range_biased(0, len - 1, LOOT_BIAS, true);
		var num = list[index];
		
		stats.spd = num;
		
	}
	
	if (type == "analog") {
	
		var low = 0.05 * level + 0.05;
		var list = [low, low + 0.05, low + 0.06, low + 0.07, low + 0.08, low + 0.09, low + 0.1];
		var len = array_length(list);
		var index = irandom_range_biased(0, len - 1, LOOT_BIAS, true);
		var num = list[index];
		
		stats.dashCoolTime = -num;
		
	}
	
	if (regenType == "oximetric") {
	
		var low = 0.1 + level * 0.1;
		var high = 0.2 + level * 0.4;
		var regen = random_range_biased(low, high, LOOT_BIAS, true, 1);
		
		stats.hpRegen = regen;
	
	}
	
	if (regenType == "electroscopic") {
	
		var low = 0.1 + level * 0.1;
		var high = 0.2 + level * 0.4;
		var regen = random_range_biased(low, high, LOOT_BIAS, true, 1);
		
		stats.energyRegen = regen;
	
	}
	
	var name;
	
	append_string(name, type, true);
	append_string(name, regenType, true);
	append_string(name, "watch", true);
	
	device.name = name;
	
	return device;
	
}

function scr_devices_powerBank(level, rarity) {

	var device = new deviceInst();
	var stats = device.stats;
	
	var type = choose("high capacity", "fast", "dual-cell");
	
	var low = 0.1 + level * 0.1;
	var high = 0.2 + level * 0.4;
	var regen = random_range_biased(low, high, LOOT_BIAS, true, 1);
	
	if (type = "high capacity") {
	
		low = 5 * level;
		high = 10 + 10 * level;
		
		stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	}
	
	if (type == "fast") {
	
		low = 0.05 * level;
		high = 0.2 * level;
		regen += random_range_biased(low, high, LOOT_BIAS, true, 2);
	
	}
	
	if (type == "dual-cell") {
	
		low = 0.05 * level;
		high = 0.2 * level;
		stats.energyPackRegen = random_range_biased(low, high, LOOT_BIAS, true, 2);
		
	}
	
	stats.regen = regen;
	
	var name;
	
	append_string(name, type, true);
	append_string(name, "power bank", true);
	
	device.name = name;
	
}