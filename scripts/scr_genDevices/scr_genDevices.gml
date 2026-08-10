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
	device.spr = adj == "Precise" ? spr_laserPointerPrecise : spr_laserPointerBright;
	
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
	device.spr = adj1 == "Digital" ? spr_digitalWatch : spr_analogWatch;
	
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
	device.spr = spr_powerBank;
	
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
	device.spr = spr_calculatorSci;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var type = choose("old", "sci", "prog");
	var adj = "";
	var typeStat = "";
	
	if (type == "old") device.spr = spr_calculatorOld;
	if (type == "sci") device.spr = spr_calculatorSci;
	if (type == "prog") device.spr = spr_calculatorProg;
	
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
	device.spr = spr_thermosCoffee;
	
	var rarityFactor = max(0, rarity - 1);
	var rarityMod = 1 + rarityFactor * 0.2;
	
	var type = choose("choc", "coffee", "protein");
	var adj = "";
	var typeStat = "";
	
	if (type == "choc") device.spr = spr_thermosHotChoc;
	if (type == "coffee") device.spr = spr_thermosCoffee;
	if (type == "protein") device.spr = spr_thermosProtein;
	
	//base maximum HP
	var baseLow = max(5, floor(5 * (level * 0.7)));
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

		var high = max(2, round(baseHigh * 0.5));
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
			
			var high = max(2, round(baseHigh * 0.5));
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
	device.spr = spr_vaporizer;
	
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
function scr_genDevices_shieldGenerator(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Shield Generator";
	device.spr = spr_shieldGenerator;
	
	var stats = device.stats;
	
	var keys = [
		"maxEnergy",
		"maxEnergyPerc",
		"energyRegen",
		"energyRegenPerc",
		"shieldRegen",
		"shieldRegenDelay"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.maxShield = 1;
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxEnergy") {
			amount = scr_statRolls_maxEnergy(level, 0.75);
		}
		
		if (key == "maxEnergyPerc") {
			amount = scr_statRolls_maxEnergyPerc(level, 0.75);
		}
		
		if (key == "energyRegen") {
			amount = scr_statRolls_regen(level, 0.75);
		}
		
		if (key == "energyRegenPerc") {
			amount = scr_statRolls_regenPerc(level, 0.75);
		}
		
		if (key == "shieldRegen") {
			amount = scr_statRolls_shieldRegen(level, 0.75);
		}
		
		if (key == "shieldRegenDelay") {
			amount = scr_statRolls_shieldRegenDelay(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_firstAidKit(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "First Aid Kit";
	device.spr = spr_firstAidKit;
	
	var stats = device.stats;
	
	var keys = [
		"maxHp",
		"maxHpPerc",
		"hpRegen",
		"hpRegenPerc",
		"healingPerc",
		"stimPackRegen"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.maxStimPacks = 1;
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level, 0.75);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level, 0.75);
		}
		
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level, 0.75);
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level, 0.75);
		}
		
		if (key == "healingPerc") {
			amount = scr_statRolls_healingPerc(level, 0.75);
		}
		
		if (key == "stimPackRegen") {
			amount = scr_statRolls_packRegen(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_resistanceModule(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;
	
	var elements = ["kin", "fire", "chem", "elec", "rad"];
	
	var el1 = scr_randomElementRemove(elements);
	var el2 = scr_randomElementRemove(elements);
	
	var res1 = el1 + "Res";
	var resPerc1 = el1 + "ResPerc";
	
	var res2 = el2 + "Res";
	var resPerc2 = el2 + "ResPerc";
	
	var keys = [
		res1,
		resPerc1,
		res2,
		resPerc2
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed paired resistances
	stats[$ res1] = scr_statRolls_resistance(level);
	stats[$ res2] = scr_statRolls_resistance(level);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == res1 or key == res2) {
			amount = scr_statRolls_resistance(level, 0.5);
		}
		
		if (key == resPerc1 or key == resPerc2) {
			amount = scr_statRolls_resistancePerc(level, 0.5);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	//name
	var names = {
		kin: "Kinetic",
		fire: "Thermal",
		chem: "Chemical",
		elec: "Electrical",
		rad: "Radiation"
	};
	
	var sprites = {
		kin: spr_resModKin,
		fire: spr_resModFire,
		chem: spr_resModChem,
		elec: spr_resModElec,
		rad: spr_resModRad
	};
	
	var val1 = scr_stats_calculateStat(stats[$ res1], stats[$ resPerc1]);
	var val2 = scr_stats_calculateStat(stats[$ res2], stats[$ resPerc2]);

	var dominant = val1 >= val2 ? el1 : el2;

	device.spr = sprites[$ dominant];
	
	device.name =
		names[$ el1]
		+ "-"
		+ names[$ el2]
		+ " Resistance Module";
	
	return device;
	
}

function scr_genDevices_regenerativeImplant(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Regenerative Implant";
	device.spr = spr_regenerativeImplant;
	
	var stats = device.stats;
	
	var keys = [
		"maxHp",
		"maxHpPerc",
		"hpRegen",
		"hpRegenPerc",
		"healingPerc"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.hpRegenPerc = scr_statRolls_regenPerc(level, 1.5);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level, 0.75);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level, 0.75);
		}
		
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level, 0.75);
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level, 0.75);
		}
		
		if (key == "healingPerc") {
			amount = scr_statRolls_healingPerc(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_powerRegulator(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Power Regulator";
	device.spr = spr_powerRegulator;
	
	var stats = device.stats;
	
	var keys = [
		"maxEnergy",
		"maxEnergyPerc",
		"energyRegen",
		"energyRegenPerc",
		"energyPackRegen"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.energyRegenPerc = scr_statRolls_regenPerc(level, 1.5);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxEnergy") {
			amount = scr_statRolls_maxEnergy(level, 0.75);
		}
		
		if (key == "maxEnergyPerc") {
			amount = scr_statRolls_maxEnergyPerc(level, 0.75);
		}
		
		if (key == "energyRegen") {
			amount = scr_statRolls_regen(level, 0.75);
		}
		
		if (key == "energyRegenPerc") {
			amount = scr_statRolls_regenPerc(level, 0.75);
		}
		
		if (key == "energyPackRegen") {
			amount = scr_statRolls_packRegen(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_petRock(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Pet Rock";
	device.spr = spr_petRock;
	
	var stats = device.stats;
	
	var keys = ["oa", "da", "kinDam", "kinRes"];
	keys = array_concat(keys, keys);
	//guaranteed effect
	stats.kinDamPerc = scr_statRolls_damagePerc(level, 1);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key;
		
		if (scr_random_chance(50)) {
			key = "kinDamPerc";
		} else {
			key = scr_randomElementRemove(keys);
		}
		
		var amount = 0;
		
		if (key == "kinDamPerc") {
			amount = choose(1,2);
		}
		
		if (key == "kinDam") {
			amount = scr_statRolls_damage(level, 0.75);
		}
		
		if (key == "kinRes") {
			amount = scr_statRolls_resistance(level, 0.75);
		}
		
		if (key == "oa" or key == "da") {
			amount = scr_statRolls_combatAbility(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_accelerant(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Accelerant";
	device.spr = spr_accelerant;
	
	var stats = device.stats;
	
	var keys = ["oa", "da", "fireDam", "fireRes"];
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.fireDamPerc = scr_statRolls_damagePerc(level, 1);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key;
		
		if (scr_random_chance(50)) {
			key = "fireDamPerc";
		} else {
			key = scr_randomElementRemove(keys);
		}
		
		var amount = 0;
		
		if (key == "fireDamPerc") {
			amount = choose(1,2);
		}
		
		if (key == "fireDam") {
			amount = scr_statRolls_damage(level, 0.75);
		}
		
		if (key == "fireRes") {
			amount = scr_statRolls_resistance(level, 0.75);
		}
		
		if (key == "oa" or key == "da") {
			amount = scr_statRolls_combatAbility(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_catalystCartridge(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Catalyst Cartridge";
	device.spr = spr_catalystCartridge;
	
	var stats = device.stats;
	
	var keys = ["oa", "da", "chemDam", "chemRes"];
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.chemDamPerc = scr_statRolls_damagePerc(level, 1);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key;
		
		if (scr_random_chance(50)) {
			key = "chemDamPerc";
		} else {
			key = scr_randomElementRemove(keys);
		}
		
		var amount = 0;
		
		if (key == "chemDamPerc") {
			amount = choose(1,2);
		}
		
		if (key == "chemDam") {
			amount = scr_statRolls_damage(level, 0.75);
		}
		
		if (key == "chemRes") {
			amount = scr_statRolls_resistance(level, 0.75);
		}
		
		if (key == "oa" or key == "da") {
			amount = scr_statRolls_combatAbility(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_amplifier(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Amplifier";
	device.spr = spr_amplifier;
	
	var stats = device.stats;
	
	var keys = ["oa", "da", "elecDam", "elecRes"];
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.elecDamPerc = scr_statRolls_damagePerc(level, 1);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key;
		
		if (scr_random_chance(50)) {
			key = "elecDamPerc";
		} else {
			key = scr_randomElementRemove(keys);
		}
		
		var amount = 0;
		
		if (key == "elecDamPerc") {
			amount = choose(1,2);
		}
		
		if (key == "elecDam") {
			amount = scr_statRolls_damage(level, 0.75);
		}
		
		if (key == "elecRes") {
			amount = scr_statRolls_resistance(level, 0.75);
		}
		
		if (key == "oa" or key == "da") {
			amount = scr_statRolls_combatAbility(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}

function scr_genDevices_magnetron(level, rarity) {

	var device = new deviceInst(level, rarity);
	device.name = "Magnetron";
	device.spr = spr_magnetron;
	
	var stats = device.stats;
	
	var keys = ["oa", "da", "radDam", "radRes"];
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.radDamPerc = scr_statRolls_damagePerc(level, 1);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key;
		
		if (scr_random_chance(50)) {
			key = "radDamPerc";
		} else {
			key = scr_randomElementRemove(keys);
		}
		
		var amount = 0;
		
		if (key == "radDamPerc") {
			amount = choose(1,2);
		}
		
		if (key == "radDam") {
			amount = scr_statRolls_damage(level, 0.75);
		}
		
		if (key == "radRes") {
			amount = scr_statRolls_resistance(level, 0.75);
		}
		
		if (key == "oa" or key == "da") {
			amount = scr_statRolls_combatAbility(level, 0.75);
		}
		
		if (amount != 0) {
			scr_loot_addStat(device, key, amount);
		}
		
	}
	
	return device;
	
}