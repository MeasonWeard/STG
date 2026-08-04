//GENERIC
function scr_genDevices_laserPointer(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	device.name = "Laser Pointer";
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	//base oa
	var baseHigh = ceil(level + 10);
	var baseLow = max(1, baseHigh - 5);
	
	stats.oa = irandom_range_biased(baseLow * rarityMod, baseHigh * rarityMod, LOOT_BIAS);
	
	repeat(rarity) {
		
		var amount = 0;
		var stat = choose("oa", "da", "fireDam", "radDam", "elecDam");
	
		//precise / bright
		if (stat == "oa" or stat == "da") {
		
			var high = max(2, baseHigh * 0.75);
			var low = max(1, high - 5);
			
			amount = irandom_range_biased(low, high, LOOT_BIAS);

		}
		
		if (stat == "fireDam" or stat == "radDam" or stat == "elecDam") {
		
			var high = (level * 0.5);
			var low = max(1, high - 5);

			amount = irandom_range_biased(low, high, LOOT_BIAS);
			
		}
		
		scr_loot_addStat(device, stat, amount);
	
	}
	
	return device;

}

function scr_genDevices_watch(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	device.name = "Watch";
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	//base regen
	var low = (0.1 + level * 0.1);
	var high = (0.2 + level * 0.4);

	//digital / analog
	var regenType = choose("energyRegen", "hpRegen");
	
	stats[$ regenType] = irandom_range_biased(low * rarityMod, high * rarityMod, LOOT_BIAS);
	
	var stat = choose("spd", "dashRegen");
	
	repeat(rarity) {
		
		var amount = 0;
		
		if (stat == "spd") {
			//oximetric
			amount = scr_stats_rollSteppedBonus(0.05, 0.25, level);
		
		}
		
		if (stat == "dashRegen") {
			//electroscopic
			amount = scr_stats_rollSteppedBonus(0.03, 0.3, level);
	
		}
		
		scr_loot_addStat(device, stat, amount);
		
	}
	
	return device;
	
}

function scr_genDevices_powerBank(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var type = choose("high capacity", "fast", "dual-cell");
	
	var baseLow = (0.1 + level * 0.1) * rarityMod;
	var baseHigh = (0.2 + level * 0.4) * rarityMod;
	
	stats.energyRegen = irandom_range_biased(baseHigh, baseLow, LOOT_BIAS);
	
	repeat(rarity) {
	
		var amount = 0;
		var stat = choose("maxEnergy", "energyRegen", "energyPackRegen");
	
		if (stat == "maxEnergy") {
			//high capacity
			var low = floor(5 * (level * 0.8));
			var high = low + 10;
			
			amount = irandom_range_biased(low * rarityMod, high * rarityMod, LOOT_BIAS);
		
		}
		
		if (stat == "energyRegen") {
			//fast
			var high = max(0.2, baseHigh * 0.5);
			var low = max(0.1, baseLow * 0.5);
			
			amount = irandom_range_biased(low, high, LOOT_BIAS);
		
		}
		
		if (stat == "energyPackRegen") {
			//dual-cell
			var low = 0.01 * level;
			var high = 0.03 * level;
			
			amount = irandom_range_biased(low, high, LOOT_BIAS);
			
		}
	
		scr_loot_addStat(device, stat, amount);
	
	}
	
	return device;
	
}

function scr_genDevices_calculator(level, rarity) {
	
	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var type = choose("old", "sci", "prog");
	var adj = "";
	var typeStat = "";
	
	//base DA
	var baseHigh = ceil((level + 10));
	var baseLow = max(1, baseHigh - 5);
	
	stats.da = irandom_range_biased(
		baseLow * rarityMod,
		baseHigh * rarityMod,
		LOOT_BIAS,
		true
	);
	
	switch (type) {
		
		case "old":
			adj = "Old-School";
			typeStat = "da";
			break;
			
		case "sci":
			adj = "Scientific";
			typeStat = "kinDam";
			break;
			
		case "prog":
			adj = "Programmable";
			typeStat = "gunDamPerc";
			break;
		
	}
	
	repeat (rarity) {
		
		var stat = choose("da", typeStat);
		var amount = 0;
		
		if (stat == "da") {
			
			var high = max(2, round(baseHigh * 0.75));
			var low = max(1, high - 5);
			
			amount = irandom_range_biased(
				low,
				high,
				LOOT_BIAS,
				true
			);
			
		}
		
		if (stat == "kinDam" or stat == "gunDamPerc") {
			
			var high = max(2, level * 0.5 + 1);
			var low = max(1, high * 0.5);
			
			amount = irandom_range_biased(
				low,
				high,
				LOOT_BIAS,
				true
			);
			
		}
		
		scr_loot_addStat(device, stat, amount);
		
	}
	
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
	var typeStat = "";
	
	//base maximum HP
	var baseLow = floor(5 * (level * 0.8));
	var baseHigh = baseLow + 15;
	
	stats.maxHp = irandom_range_biased(
		baseLow * rarityMod,
		baseHigh * rarityMod,
		LOOT_BIAS,
		true
	);
	
	switch (type) {
		
		case "choc":
			adj = "Hot Chocolate";
			typeStat = "maxHp";
			break;
			
		case "coffee":
			adj = "Coffee";
			typeStat = "hpRegen";
			break;
			
		case "protein":
			adj = "Protein Milk";
			typeStat = "meleeDamPerc";
			break;
		
	}
	
	repeat (rarity) {
		
		var stat = choose("maxHp", typeStat);
		var amount = 0;
		
		if (stat == "maxHp") {
			
			var high = max(2, round(baseHigh * 0.75));
			var low = max(1, high - 10);
			
			amount = irandom_range_biased(
				low,
				high,
				LOOT_BIAS,
				true
			);
			
		}
		
		if (stat == "hpRegen") {
			
			var low = (level * 0.05);
			var high = (level * 0.15);
			
			amount = random_range_biased(
				low,
				high,
				LOOT_BIAS,
				true,
				1
			);
			
		}
		
		if (stat == "meleeDamPerc") {
			
			var high = max(2, ceil(level * 0.25))
			var low = max(1, high - 5);
			
			amount = irandom_range_biased(
				low,
				high,
				LOOT_BIAS,
				true
			);
			
		}
		
		scr_loot_addStat(device, stat, amount);
		
	}
	
	device.name = adj + " Thermos";
	return device;
	
}

//function scr_genDevices_calculator(level, rarity) {
	
//	var device = new deviceInst(level, rarity);
//	var stats = device.stats;
	
//	var rarityFactor = max(0, rarity - 1);
//	var rarityMod = 1 + rarityFactor * 0.2;
	
//	var type = choose("old", "sci", "prog");
//	var adj = "";
	
//	//base da
//	var high = ceil((level + 10) * rarityMod) + rarityFactor;
//	var low = high - 5;
	
//	stats.da = irandom_range_biased(low, high, LOOT_BIAS, true);
	
//	if (type == "old") {
		
//		adj = "Old-School";
		
//		high = max(2, round(high * 0.75));
//		low = max(1, high - 5);
	
//		stats.da += irandom_range_biased(low, high, LOOT_BIAS, true);
	
//	}
	
//	if (type == "sci") {
		
//		adj = "Scientific";
		
//		high = ceil((level * rarityMod) + rarityMod);
//		low = max(1, floor(level * 0.5) * rarityMod);

//		stats.kinDam = irandom_range_biased(low, high, LOOT_BIAS, true);
		
//	}
	
	
//	if (type == "prog") {
		
//		adj = "Programmable";
		
//		adj = "Scientific";
		
//		high = ceil((level * rarityMod) + rarityMod);
//		low = max(1, floor(level * 0.5) * rarityMod);

//		stats.gunDamPerc = irandom_range_biased(low, high, LOOT_BIAS, true);
		
//	}
	
//	//name
//	device.name = adj + " Calculator";
	
//	return device;
	
//}

//function scr_genDevices_thermos(level, rarity) {
	
//	var device = new deviceInst(level, rarity);
//	var stats = device.stats;
	
//	var rarityFactor = max(0, rarity - 1);
//	var rarityMod = 1 + rarityFactor * 0.2;
	
//	var type = choose("choc", "coffee", "protein");
//	var adj = "";
	
//	//base max hp
//	var low = floor(5 * (level * 0.8) * rarityMod);
//	var high = low + 15;
		
//	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS, true);

//	if (type == "choc") {
		
//		adj = "Hot Chocolate";
		
//		high = max(2, round(high * 0.75));
//		low = max(1, high - 10);
	
//		stats.maxHp += irandom_range_biased(low, high, LOOT_BIAS, true);
	
//	}
	
//	if (type == "coffee") {
		
//		adj = "Coffee";
		
//		low = (0.1 + level * 0.1) * rarityMod;
//		high = (0.2 + level * 0.4) * rarityMod;

//		stats.hpRegen = random_range_biased(low, high, LOOT_BIAS, true, 1);
		
//	}
	
	
//	if (type == "protein") {
		
//		adj = "Protein Milk";
		
//		high = ceil((level * rarityMod) + rarityMod);
//		low = max(1, floor(level * 0.5) * rarityMod);

//		stats.meleeDamPerc = irandom_range_biased(low, high, LOOT_BIAS, true);
		
//	}
	
//	//name
//	device.name = adj + " Thermos";
	
//	return device;
	
//}