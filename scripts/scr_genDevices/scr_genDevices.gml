function scr_genDevices_laserPointer(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.1;
	
	var type1 = choose("precise", "bright");
	var type2 = choose("hot", "ionizing", "malfunctioning", "", "", "")
	
	//base oa
	var high = ceil((level + 10) * rarityMod) + rarityFactor;
	var low = high - 5;
	
	stats.oa = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	//type1
	high = max(2, round(high * 0.75));
	low = max(1, high - 5);
	
	var statChange = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	if (type1 == "precise") scr_loot_addStat(device, "oa", statChange);
	if (type1 == "bright") scr_loot_addStat(device, "da", statChange);
	
	//type2
	high = ceil((level * rarityMod) + 1 * rarityMod);
	low = max(1, floor(level * 0.5) * rarityMod);

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

	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.1;

	var type = choose("digital", "analog");
	var regenType = choose("oximetric", "electroscopic");
	
	if (type == "digital") {
		
		var int = 0.1 * rarityMod;
		var num = scr_stats_rollSteppedBonus(int, 3 * rarityMod, level);
		
		stats.spd = num;
		
	}
	
	if (type == "analog") {
	
		var int = 0.01 * rarityMod;
		var num = scr_stats_rollSteppedBonus(int, 3 * rarityMod, level);

		stats.dashRegen = num;
		
	}
	
	if (regenType == "oximetric") {
	
		var low = (0.1 + level * 0.1) * rarityMod;
		var high = (0.2 + level * 0.4) * rarityMod;
		var regen = random_range_biased(low, high, LOOT_BIAS, true, 1);
		
		stats.hpRegen = regen;
	
	}
	
	if (regenType == "electroscopic") {
	
		var low = (0.1 + level * 0.1) * rarityMod;
		var high = (0.2 + level * 0.4) * rarityMod;
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
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.1;
	
	var type = choose("high capacity", "fast", "dual-cell");
	
	var low = (0.1 + level * 0.1) * rarityMod;
	var high = (0.2 + level * 0.4) * rarityMod;
	var regen = random_range_biased(low, high, LOOT_BIAS, true, 1);
	
	if (type = "high capacity") {
	
		low = floor(10 * level * rarityMod);
		high = ceil(15 + 15 * level * rarityMod);
		
		stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	}
	
	if (type == "fast") {
	
		//already affected by rarityMod
		low = 0.1 * level;
		high = 0.4 * level;
		regen += random_range_biased(low, high, LOOT_BIAS, true, 2);
	
	}
	
	if (type == "dual-cell") {
	
		low = 0.01 * level * rarityMod;
		high = 0.03 * level * rarityMod;
		stats.energyPackRegen = random_range_biased(low, high, LOOT_BIAS, true, 2);

	}
	
	stats.energyRegen = regen;
	
	var name = "";
	
	name = append_string(name, type, 2);
	name = append_string(name, "power bank", 2);
	
	device.name = name;
	
	return device;
	
}

//to do: device that increases stim pack and health regeneration