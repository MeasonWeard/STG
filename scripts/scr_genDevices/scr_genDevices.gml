//GENERIC
function scr_genDevices_laserPointer(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
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
	high = ceil((level * rarityMod) + rarityMod);
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
	var rarityMod = 1 + rarityFactor * 0.2;

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
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var type = choose("high capacity", "fast", "dual-cell");
	
	var low = (0.1 + level * 0.1) * rarityMod;
	var high = (0.2 + level * 0.4) * rarityMod;
	var regen = random_range_biased(low, high, LOOT_BIAS, true, 1);
	
	if (type = "high capacity") {
	
		low = floor(5 * (level * 0.8) * rarityMod);
		high = low + 15;
		
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

function scr_genDevices_calculator(level, rarity) {
	
	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var type = choose("old", "sci", "prog");
	var adj = "";
	
	//base da
	var high = ceil((level + 10) * rarityMod) + rarityFactor;
	var low = high - 5;
	
	stats.da = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	if (type == "old") {
		
		adj = "Old-School";
		
		high = max(2, round(high * 0.75));
		low = max(1, high - 5);
	
		stats.da += irandom_range_biased(low, high, LOOT_BIAS, true);
	
	}
	
	if (type == "sci") {
		
		adj = "Scientific";
		
		high = ceil((level * rarityMod) + rarityMod);
		low = max(1, floor(level * 0.5) * rarityMod);

		stats.kinDam = irandom_range_biased(low, high, LOOT_BIAS, true);
		
	}
	
	
	if (type == "prog") {
		
		adj = "Programmable";
		
		adj = "Scientific";
		
		high = ceil((level * rarityMod) + rarityMod);
		low = max(1, floor(level * 0.5) * rarityMod);

		stats.gunDamPerc = irandom_range_biased(low, high, LOOT_BIAS, true);
		
	}
	
	//name
	device.name = adj + " Calculator";
	
	return device;
	
}

function scr_genDevices_thermos(level, rarity) {
	
	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var type = choose("choc", "coffee", "protein");
	var adj = "";
	
	//base max hp
	var low = floor(5 * (level * 0.8) * rarityMod);
	var high = low + 15;
		
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS, true);

	if (type == "choc") {
		
		adj = "Hot Chocolate";
		
		high = max(2, round(high * 0.75));
		low = max(1, high - 10);
	
		stats.maxHp += irandom_range_biased(low, high, LOOT_BIAS, true);
	
	}
	
	if (type == "coffee") {
		
		adj = "Coffee";
		
		low = (0.1 + level * 0.1) * rarityMod;
		high = (0.2 + level * 0.4) * rarityMod;

		stats.hpRegen = random_range_biased(low, high, LOOT_BIAS, true, 1);
		
	}
	
	
	if (type == "protein") {
		
		adj = "Protein Milk";
		
		high = ceil((level * rarityMod) + rarityMod);
		low = max(1, floor(level * 0.5) * rarityMod);

		stats.meleeDamPerc = irandom_range_biased(low, high, LOOT_BIAS, true);
		
	}
	
	//name
	device.name = adj + " Thermos";
	
	return device;
	
}