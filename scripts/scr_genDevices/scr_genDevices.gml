//GENERIC
function scr_genDevices_laserPointer(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	//base oa
	var baseHigh = ceil(level + 10);
	var baseLow = max(1, baseHigh - 5);
	
	stats.oa = irandom_range_biased(baseLow * rarityMod, baseHigh * rarityMod, LOOT_BIAS);
	
	var bonusType = choose("oa", "da");
	var damType = choose("fireDam", "elecDam", "radDam");
	
	var adj = bonusType == "oa" ? "Precise" : "Bright";
	
	device.name = adj + " Laser Pointer";
	
	//gauranteed
	var amount = 0;

	var high = max(2, baseHigh * 0.75);
	var low = max(1, high - 5);

	amount = irandom_range_biased(
		low,
		high,
		LOOT_BIAS
	);

	scr_loot_addStat(device, bonusType, amount);

	//extra
	repeat(rarity - 1) {
		
		amount = 0;
		var stat = choose(bonusType, damType);
	
		//precise / bright
		if (stat == "oa" or stat == "da") {
		
			high = max(2, baseHigh * 0.75);
			low = max(1, high - 5);
			
			amount = irandom_range_biased(low, high, LOOT_BIAS);

		}
		
		if (stat == "fireDam" or stat == "radDam" or stat == "elecDam") {
		
			high = max(1, level * 0.5);
			low = max(0, high - 5);

			amount = irandom_range_biased(low, high, LOOT_BIAS);
			
		}
		
		scr_loot_addStat(device, stat, amount);
	
	}
		
	return device;

}

function scr_genDevices_watch(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	//base regen
	var low = (0.1 + level * 0.1);
	var high = (0.2 + level * 0.4);

	//digital / analog
	var regenType = choose("energyRegen", "hpRegen");
	
	stats[$ regenType] = random_range_biased(low * rarityMod, high * rarityMod, LOOT_BIAS);
	
	var stat = choose("spd", "dashRegen");
	
	var adj1 = regenType == "energyRegen" ? "Digital" : "Analog";
	var adj2 = stat == "spd" ? "Oxymetric" : "Electroscopic";
	
	device.name = adj1 + " " + adj2 + " Watch";
	
	//guaranteed
	var amount = 0;

	if (stat == "spd") {

		//oxymetric
		amount = scr_stats_rollSteppedBonus(
			0.05,
			0.25,
			level
		);

	}

	if (stat == "dashRegen") {

		//electroscopic
		amount = scr_stats_rollSteppedBonus(
			0.03,
			0.3,
			level
		);

	}

	scr_loot_addStat(device, stat, amount);
	
	//rarity
	repeat(rarity - 1) {
		
		amount = 0;
		
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
	device.name = "Power Bank";
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var baseLow = (0.1 + level * 0.1) * rarityMod;
	var baseHigh = (0.2 + level * 0.4) * rarityMod;
	
	stats.energyRegen = random_range_biased(baseLow, baseHigh, LOOT_BIAS);
	
	var maxEnergyRolls = 0;
	var energyRegenRolls = 0;
	var energyPackRolls = 0;
	
	repeat(rarity - 1) {
	
		var amount = 0;
		var stat = choose("maxEnergy", "energyRegen", "energyPackRegen");
	
		if (stat == "maxEnergy") {
			//high capacity
			var low = floor(5 * (level * 0.8));
			var high = low + 10;
			
			amount = irandom_range_biased(low * rarityMod, high * rarityMod, LOOT_BIAS);
			maxEnergyRolls ++;
			
		}
		
		if (stat == "energyRegen") {
			//fast
			var high = max(0.2, baseHigh * 0.5);
			var low = max(0.1, baseLow * 0.5);
			
			amount = random_range_biased(low, high, LOOT_BIAS);
			energyRegenRolls ++;
		
		}
		
		if (stat == "energyPackRegen") {
			//dual-cell
			var low = 0.01 * level;
			var high = 0.03 * level;
			
			amount = random_range_biased(low, high, LOOT_BIAS);
			energyPackRolls++;
			
		}
	
		scr_loot_addStat(device, stat, amount);
	
	}
	
	var highestRolls = max(
		maxEnergyRolls,
		energyRegenRolls,
		energyPackRolls
	);
	
	var adj;
	
	if (maxEnergyRolls == highestRolls) adj = "High Capacity";
	if (energyRegenRolls == highestRolls) adj = "Fast";
	if (energyPackRolls == highestRolls) adj = "Dual-Cell";
	
	device.name = adj + " Power Bank";
	
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
	
	//guaranteed
	var amount = 0;

	if (typeStat == "da") {

		var high = max(2, round(baseHigh * 0.75));
		var low = max(1, high - 5);

		amount = irandom_range_biased(
			low,
			high,
			LOOT_BIAS,
			true
		);

	}

	if (typeStat == "kinDam" or typeStat == "gunDamPerc") {

		var high = max(2, level * 0.5 + 1);
		var low = max(1, high * 0.5);

		amount = irandom_range_biased(
			low,
			high,
			LOOT_BIAS,
			true
		);

	}

	scr_loot_addStat(device, typeStat, amount);

	//rarity
	repeat (rarity - 1) {
		
		var stat = choose("da", typeStat);
		amount = 0;
		
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
	var baseLow = max(5, floor(5 * (level * 0.8)));
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
	
	//guaranteed thermos subtype bonus
	var amount = 0;

	if (typeStat == "maxHp") {

		var high = max(2, round(baseHigh * 0.75));
		var low = max(1, high - 10);

		amount = irandom_range_biased(
			low,
			high,
			LOOT_BIAS,
			true
		);

	}

	if (typeStat == "hpRegen") {

		var low = level * 0.05;
		var high = level * 0.15;

		amount = random_range_biased(
			low,
			high,
			LOOT_BIAS,
			true,
			1
		);

	}

	if (typeStat == "meleeDamPerc") {

		var high = max(2, ceil(level * 0.25));
		var low = max(1, high - 5);

		amount = irandom_range_biased(
			low,
			high,
			LOOT_BIAS,
			true
		);

	}

	scr_loot_addStat(device, typeStat, amount);
	
	//rarity
	repeat (rarity - 1) {
		
		var stat = choose("maxHp", typeStat);
		amount = 0;
		
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
			
			var high = max(2, ceil(level * 0.25));
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

function scr_genDevices_vaporizer(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	//base regen
	var baseLow = 0.1 + level * 0.1;
	var baseHigh = 0.18 + level * 0.35;
	
	var regenType = choose("hpRegen", "stimPackRegen");
	
	stats[$ regenType] = random_range_biased(baseLow * rarityMod, baseHigh * rarityMod, LOOT_BIAS);
	
	var adj = regenType == "hpRegen" ? "Bioactive" : "Reagent";
	
	device.name = adj + " Vaporizer";

	//extra
	repeat(rarity - 1) {
		
		var amount = 0;
		var stat = choose(regenType, "chemDam");
		
		if (stat == "chemDam") {
		
			var high = max(1, level * 0.5);
			var low = max(0, high - 5);

			amount = irandom_range_biased(low, high, LOOT_BIAS);
			
		} else {
		
			amount = random_range_biased(baseLow, baseHigh, LOOT_BIAS);
		
		}
		
		scr_loot_addStat(device, stat, amount);
	
	}
		
	return device;

}

//SPECIAL