function scr_genDevices_laserPointer(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;

	var type1 = choose("precise", "bright");
	var type2 = choose("hot", "ionizing", "malfunctioning", "", "", "")
	
	//type1
	var low = 2 + level * 2;
	var high = 4 + level * 3;

	stats.oa = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	low = 2 + level;
	high = 4 + level * 2;
	
	var statChange = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	if (type1 == "precise") scr_loot_addStat(device, "oa", statChange);
	if (type2 == "bright") stats.da = statChange;
	
	//type2
	low = round(level + level * 1.5);
	high = round(level + 1 + level * 2.5);
		
	var dam = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	if (type2 == "hot") stats.fireDam = dam;
	if (type2 == "ionizing") stats.radDam = dam;
	if (type2 == "malfunctioning") stats.elecDam = dam;
	
	var name = "";
	
	name = append_string(name, type1, 2);
	name = append_string(name, type2, 2);
	name = append_string(name, "laser pointer", 2);
	
	device.name = name;
	
	return device;
	
}

function scr_genDevices_watch(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;

	//to do: some don't have regen type

	var type = choose("digital", "analog");
	var regenType = choose("", "", "oximetric", "electroscopic");
	
	if (type == "digital") {
	
		var low = 0.1 * level + 0.1;
		var list = [low, low + 0.1, low + 0.2, low + 0.3, low + 0.4];
		var len = array_length(list);
		var index = irandom_range_biased(0, len - 1, LOOT_BIAS, true);
		var num = list[index];
		
		stats.spd = num;
		
	}
	
	if (type == "analog") {
	
		var low = 0.02 * level + 0.04;
		var list = [low, low + 0.02, low + 0.03, low + 0.04, low + 0.05, low + 0.06, low + 0.7];
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
	
	var name = "";
	
	name = append_string(name, type, 2);
	name = append_string(name, regenType, 2);
	name = append_string(name, "watch", 2);
	
	device.name = name;
	
	return device;
	
}

function scr_genDevices_powerBank(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var type = choose("high capacity", "fast", "dual-cell");
	
	var low = 0.1 + level * 0.1;
	var high = 0.2 + level * 0.4;
	var regen = random_range_biased(low, high, LOOT_BIAS, true, 1);
	
	if (type = "high capacity") {
	
		low = 10 * level;
		high = 15 + 15 * level;
		
		stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	}
	
	if (type == "fast") {
	
		low = 0.1 * level;
		high = 0.4 * level;
		regen += random_range_biased(low, high, LOOT_BIAS, true, 2);
	
	}
	
	if (type == "dual-cell") {
	
		low = 0.05 * level;
		high = 0.2 * level;
		stats.energyPackRegen = random_range_biased(low, high, LOOT_BIAS, true, 2);

	}
	
	stats.energyRegen = regen;
	
	var name = "";
	
	name = append_string(name, type, 2);
	name = append_string(name, "power bank", 2);
	
	device.name = name;
	
	return device;
	
}