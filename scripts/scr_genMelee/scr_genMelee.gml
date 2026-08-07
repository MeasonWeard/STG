#region //HELPER FUNCTIONS
function scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes) {
	
	if (rarity < 1) {
		return melee;
	}
	
	var baseDamage = melee.baseDamage;
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	var baseDamType = scr_weapons_getHighestDamageType(melee);

	if (level == 1) {
		bonusDamage = choose(0, bonusDamage);
	}

	var newDamType = baseDamType;

	if (rarity > 1) {
		newDamType = scr_randomElement(damTypes);
	}

	scr_weapons_addDamageToTypesSpread(melee, bonusDamage, [baseDamType, newDamType]);
	//scr_weapons_addDamage(melee, damType, bonusDamage);
	
	return melee;
	
}

function scr_genMelee_applyGenericBonuses(melee, level, rarity, config, bonusChanceMod = 1) {

	if (rarity <= 1) {
		return melee;
	}

	var baseDamage = scr_weapons_getBaseDamage(melee);

	// Store original values before modifying anything
	var baseStats = {
		attackRate: melee.attackRate,
		maxCharges: melee.maxCharges,
		rechargeTime: melee.rechargeTime,
		killThreshold: melee.killThreshold,
		baseDamage: baseDamage
	};

	var standardKeys = [];
	array_copy(standardKeys, 0, config.standardStats, 0, array_length(config.standardStats));

	var bonusKeys = [];
	array_copy(bonusKeys, 0, config.bonusStats, 0, array_length(config.bonusStats));

	repeat (rarity - 1) {

		var bonusChance = max(0, ((rarity - 1) * 10) * bonusChanceMod);
		var useBonusStat = rarity > 2 and array_length(bonusKeys) > 0 and scr_random_chance(bonusChance);

		if (useBonusStat) {

			var key = scr_randomElementRemove(bonusKeys);
			scr_genMelee_applyBonusStat(melee, key, level);

		} else {

			if (array_length(standardKeys) <= 0) continue;

			var key = scr_randomElementRemove(standardKeys);
			scr_genMelee_applyStandardStat(melee, key, level, baseStats);

		}

	}

	return melee;

}

function scr_genMelee_applyStandardStat(melee, key, level, baseStats) {

	var amount = 0;

	var low = 1;
	var high = 2;
	var range = {
					low: 1,
					high: 2
				}

	switch (key) {

		case "dam":

			var baseDamage = baseStats.baseDamage;
			var bonusInt = baseDamage * 0.15;
			var bonusMax = baseDamage;
			
			amount = ceil(scr_stats_rollSteppedBonus(bonusInt, baseDamage * 2, level));
			
			scr_weapons_addDamageToExisting(melee, amount);

		break;
		
		case "attackRate":

			range = scr_stats_calculateBonusStatFloat(baseStats.attackRate, level);

			amount = random_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, 0.1, baseStats.attackRate);

		break;

		case "maxCharges":

			range = scr_stats_calculateBonusStatInteger(baseStats.maxCharges, level);

			amount = irandom_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, 1, baseStats.maxCharges);

		break;
		
		case "rechargeTime":

			amount = -scr_stats_rollSteppedBonus(0.05, baseStats.rechargeTime * 0.5, level);

		break;
		
		case "size":

			amount = scr_stats_rollSteppedBonus(0.05, 2, level);

		break;

		case "killThreshold":
		
			var inc = ceil(baseStats.killThreshold * 0.1);
			amount = scr_stats_rollSteppedBonus(inc, baseStats.killThreshold * 4, level);

		break;

	}

	if (key != "dam" and amount != 0) {
		melee[$ key] += amount;
	}
	
	//limit stats
	melee.rechargeTime = max(melee.rechargeTime, baseStats.rechargeTime * 0.25);
	melee.attackRate = clamp(melee.attackRate, 0.1, 30);
	melee.killThreshold = max(melee.killThreshold, baseStats.baseDamage * 0.5);
	melee.size = clamp(melee.size, 0.1, 4);

}

function scr_genMelee_applyBonusStat(melee, key, level) {

	var amount = 0;
	var statKey = "";
	
	switch (key) {

		case "oa":

			amount = scr_stats_rollSteppedBonus(5, 50, level);
			scr_loot_addBonusStat(melee, "oa", amount);

		break;
		
		case "da":

			amount = scr_stats_rollSteppedBonus(5, 50, level);
			scr_loot_addBonusStat(melee, "da", amount);

		break;
		
		case "moveSpeed":

			amount = scr_stats_rollSteppedBonus(0.1, 2, level);
			scr_loot_addBonusStat(melee, "spd", amount);

		break;

		case "elemental":

			var result = scr_weapons_pickFromTop2DamageTypes(melee);

			if (is_undefined(result)) break;

			statKey = result.key + "DamPerc";
			amount = scr_stats_rollSteppedBonus(5, 50, level);

			scr_loot_addBonusStat(melee, statKey, amount);
		
		break;
		
		case "lifeSteal":
		
			amount = scr_stats_rollSteppedBonus(1, 20, level);
			scr_loot_addBonusStat(melee, "meleeLifeSteal", amount);

		break;

	}

}
#endregion

#region //GENERIC
function scr_genMelee_cleaver(level, rarity) {

	var melee = new melee_cleaver(level, rarity);

	var damTypes = ["kin"];

	if (level > 3) {

		damTypes = [];

		repeat(4) { array_push(damTypes, "kin"); }
		repeat(2) { array_push(damTypes, "fire"); }
		repeat(3) { array_push(damTypes, "chem"); }
		repeat(2) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold"
		],

		bonusStats: [
			"da",
			"moveSpeed",
			"elemental",
			"lifeSteal"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"rechargeTime"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}

function scr_genMelee_hammer(level, rarity) {

	var melee = new melee_hammer(level, rarity);

	var damTypes = ["kin"];

	if (level > 3) {

		damTypes = [];

		repeat(3) { array_push(damTypes, "kin"); }
		repeat(2) { array_push(damTypes, "fire"); }
		repeat(1) { array_push(damTypes, "chem"); }
		repeat(1) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold",
			"killThreshold"
		],

		bonusStats: [
			"da",
			"da",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}

function scr_genMelee_prod(level, rarity) {

	var melee = new melee_prod(level, rarity);

	var damTypes = ["elec"];

	if (level > 3) {

		damTypes = [];

		repeat(1) { array_push(damTypes, "kin"); }
		repeat(3) { array_push(damTypes, "fire"); }
		//repeat(3) { array_push(damTypes, "chem"); }
		repeat(4) { array_push(damTypes, "elec"); }
		repeat(2) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"maxCharges",
			"rechargeTime",
			"killThreshold"
		],

		bonusStats: [
			"oa",
			"da",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges",
			"attackRate"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}
	
function scr_genMelee_shieldAndBaton(level, rarity) {

	var melee = new melee_shieldAndBaton(level, rarity);

	//defense and resistance
	var minDa = 10 + rarity + ceil(level * 0.5);
	var maxDa = minDa + 10;
	
	melee.bonusStats.da = irandom_range_biased(minDa, maxDa, LOOT_BIAS_MILD);
	
	var resMin = max(0, level - 5) + rarity;
	var resMax = 2 + level + rarity * 2;
	var res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
	
	if (res > 0) melee.bonusStats.kinRes = res;

	if (rarity > 2) {
		
		var resPool = ["fireRes","chemRes","elecRes","radRes"];
		var resTypes = [];
		var typeAmount = irandom_range_biased(1, 4, LOOT_BIAS_MILD);
		
		repeat(typeAmount) {
			var t = scr_randomElementRemove(resPool);
			array_push(resTypes, t);
		}
		
		res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
		
		if (res > 0) {
			
			scr_weapons_addResistanceToTypesSpread(melee, res, resTypes);
			
		}
	
	}

	//damage
	var damTypes = ["kin"];
	
	if (level > 3) {

		damTypes = [];

		repeat(4) { array_push(damTypes, "kin"); }
		repeat(1) { array_push(damTypes, "fire"); }
		repeat(1) { array_push(damTypes, "chem"); }
		repeat(2) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"attackRate",
			"maxCharges",
			"rechargeTime",
		],

		bonusStats: [
			"da",
			"da",
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}	

#endregion

#region //SPECIAL

#region//cleavers
function scr_genMelee_sanguivorousCleaver(level, rarity) {

	var melee = new melee_cleaver(level, rarity);
	melee.name = "Sanguivorous Cleaver";
	melee.spr = spr_sanguivorousCleaver;
	
	//
	var minLs = 1 + floor(level * 0.25);
	var maxLs = 1 + ceil(level * 0.75);
	
	var rarExtra = rarity > 2 ? 1 : 0;
	var extraChance = rarity * 10;
	
	repeat(4) {
		
		if (scr_random_chance(extraChance)) rarExtra ++;
		extraChance *= 0.5;
		
	}
	
	scr_weapons_setBaseDamage(melee, 20, "kin");
	
	melee.bonusStats.meleeLifeSteal = irandom_range_biased(minLs, maxLs, LOOT_BIAS_MILD);
	melee.bonusStats.meleeLifeSteal += rarExtra;

	melee.attackRate = 2.2;
	//
	
	var damTypes = ["kin"];

	if (level > 3) {

		damTypes = [];

		repeat(4) { array_push(damTypes, "kin"); }
		repeat(2) { array_push(damTypes, "fire"); }
		repeat(3) { array_push(damTypes, "chem"); }
		repeat(2) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold"
		],

		bonusStats: [
			"da",
			"moveSpeed",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"rechargeTime"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

	
}

function scr_genMelee_bigCleaver(level, rarity) {

	var melee = new melee_cleaver(level, rarity);
	melee.name = "Big Cleaver";
	melee.spr = spr_bigCleaver;
	
	scr_weapons_setBaseDamage(melee, 30, "kin");

	melee.attackRate = 2.2;
	melee.size = 1.5;
	melee.maxCharges = 5;
	melee.rechargeTime = 1.9;
	melee.killThreshold = 15;

	var damTypes = ["kin"];

	if (level > 3) {

		damTypes = [];

		repeat(4) { array_push(damTypes, "kin"); }
		repeat(2) { array_push(damTypes, "fire"); }
		repeat(3) { array_push(damTypes, "chem"); }
		repeat(2) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold",
			"size"
		],

		bonusStats: [
			"da",
			"moveSpeed",
			"elemental",
			"lifeSteal"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"rechargeTime"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);
	
}
	
function scr_genMelee_toxicCleaver(level, rarity) {

	var melee = new melee_cleaver(level, rarity);
	melee.name = "Toxic Cleaver";
	melee.spr = spr_toxicCleaver;

	var baseDamage = melee.baseDamage;
	var halfDam = ceil(baseDamage * 0.5);
	
	melee.damage.kin = halfDam - 2;
	melee.damage.chem = halfDam + 2;

	var bonusRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDam = irandom_range_biased(bonusRange.low, bonusRange.high, LOOT_BIAS);
	
	scr_weapons_addDamageToTypesSpread(melee, bonusDam, ["kin","chem","chem"]);

	var config = {

		standardStats: [
			"attackRate",
			"dam",
			"maxCharges",
			"rechargeTime",
			"killThreshold"
		],

		bonusStats: [
			"da",
			"moveSpeed",
			"elemental",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"rechargeTime"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}


#endregion

#region// hammers

function scr_genMelee_heavyHammer(level, rarity) {

	var melee = new melee_hammer(level, rarity);
	melee.name = "Heavy Hammer";
	melee.spr = spr_heavyHammer;
	
	scr_weapons_setBaseDamage(melee, 55, "kin");
	
	melee.size = 1.25;
	melee.attackRate = 1;
	melee.bonusStats.spd = -0.9;
	
	var damTypes = ["kin"];

	if (level > 3) {

		damTypes = [];

		repeat(5) { array_push(damTypes, "kin"); }
		repeat(2) { array_push(damTypes, "fire"); }
		repeat(1) { array_push(damTypes, "chem"); }
		repeat(1) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold",
			"killThreshold",
			"size"
		],

		bonusStats: [
			"da",
			"da",
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"size",
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}

function scr_genMelee_littleHammer(level, rarity) {

	var melee = new melee_hammer(level, rarity);
	melee.name = "Little Hammer";
	melee.spr = spr_littleHammer;
	
	scr_weapons_setBaseDamage(melee, 40, "kin");
	melee.killThreshold = 15;
	melee.maxCharges = 4;
	melee.rechargeTime = 2;
	melee.attackRate = 1.3;
	melee.size = 0.7;
	
	var baseDamage = melee.baseDamage;
	var bonusDam = scr_weapons_calculateBonusDamage(baseDamage, level);
	
	var damTypes = ["kin"];

	if (level > 3) {

		damTypes = [];

		repeat(2) { array_push(damTypes, "kin"); }
		repeat(3) { array_push(damTypes, "fire"); }
		repeat(1) { array_push(damTypes, "chem"); }
		repeat(3) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	var type2 = scr_randomElement(damTypes);
	
	if (type2 != "kin") scr_weapons_applyBaseDamageAcrossTypes(melee, ["kin", type2], 2);
	
	var adjectives = "";
	
	switch(type2) {
		
			case "kin": adjectives = "Strong Little "; break;
			case "fire": adjectives = "Hot Little "; break;
			case "chem": adjectives = "Little Caustic "; break;
			case "elec": adjectives = "Little Charged "; break;
			case "rad": adjectives = "Little Fissile "; break;
		
		}
		
	melee.name = adjectives + " Hammer";

	var config = {

		standardStats: [
			"attackRate",
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold"
		],

		bonusStats: [
			"da",
			"da",
			"oa",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);
	
}
	
function scr_genMelee_flamingHammer(level, rarity) {

	var melee = new melee_hammer(level, rarity);
	melee.name = "Flaming Hammer";
	melee.spr = spr_flamingHammer;
	
	var baseDamage = melee.baseDamage;
	var halfDam = ceil(baseDamage * 0.5);
	
	melee.damage.kin = halfDam - 2;
	melee.damage.fire = halfDam + 2;

	var bonusRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDam = irandom_range_biased(bonusRange.low, bonusRange.high, LOOT_BIAS);
	
	scr_weapons_addDamageToTypesSpread(melee, bonusDam, ["kin","fire","fire"]);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold",
			"killThreshold",
		],

		bonusStats: [
			"da",
			"da",
			"elemental",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}	
	
function scr_genMelee_electricHammer(level, rarity) {

	var melee = new melee_hammer(level, rarity);
	melee.name = "Electric Hammer";
	melee.spr = spr_electricHammer;
	
	var baseDamage = melee.baseDamage;
	var halfDam = ceil(baseDamage * 0.5);
	
	melee.damage.kin = halfDam - 2;
	melee.damage.elec = halfDam + 2;

	var bonusRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDam = irandom_range_biased(bonusRange.low, bonusRange.high, LOOT_BIAS);
	
	scr_weapons_addDamageToTypesSpread(melee, bonusDam, ["kin","elec","elec"]);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"rechargeTime",
			"killThreshold",
			"killThreshold",
		],

		bonusStats: [
			"da",
			"da",
			"elemental",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}	

#endregion

#region//prods

function scr_genMelee_rapidProd(level, rarity) {
	
	var melee = new melee_prod(level, rarity);
	melee.name = "Rapid Prod";
	melee.spr = spr_rapidProd;
	
	scr_weapons_setBaseDamage(melee, 10, "elec");
	melee.attackRate = 12;
	melee.maxCharges = 4;
	melee.killThreshold = 4;
	melee.rechargeTime = 1.1;

	var damTypes = ["elec"];

	if (level > 3) {

		damTypes = [];

		repeat(1) { array_push(damTypes, "kin"); }
		repeat(3) { array_push(damTypes, "fire"); }
		repeat(4) { array_push(damTypes, "elec"); }
		repeat(2) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"maxCharges",
			"rechargeTime",
			"killThreshold"
		],

		bonusStats: [
			"oa",
			"da",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges",
			"attackRate"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);
	
}

function scr_genMelee_longProd(level, rarity) {
	
	var melee = new melee_prod(level, rarity);
	melee.name = "Lonnnggg Prod";
	melee.spr = spr_longProd;
	
	melee.attackRate = 2.5;
	melee.maxCharges = 6;
	melee.size = 1.25;

	var damTypes = ["elec"];

	if (level > 3) {

		damTypes = [];

		repeat(1) { array_push(damTypes, "kin"); }
		repeat(3) { array_push(damTypes, "fire"); }
		repeat(4) { array_push(damTypes, "elec"); }
		repeat(2) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"maxCharges",
			"rechargeTime",
			"killThreshold",
			"size"
		],

		bonusStats: [
			"oa",
			"da",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges",
			"attackRate"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);
	
}
	
function scr_genMelee_radioactiveProd(level, rarity) {

	var melee = new melee_prod(level, rarity);
	melee.name = "Radioactive Prod";
	melee.spr = spr_radioactiveProd;
	
	var baseDamage = melee.baseDamage;
	var halfDam = ceil(baseDamage * 0.5);
	
	melee.damage.elec = halfDam - 2;
	melee.damage.rad = halfDam + 2;

	var bonusRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDam = irandom_range_biased(bonusRange.low, bonusRange.high, LOOT_BIAS);
	
	scr_weapons_addDamageToTypesSpread(melee, bonusDam, ["elec","rad","rad"]);

	var config = {

		standardStats: [
			"attackRate",
			"maxCharges",
			"maxCharges",
			"rechargeTime",
			"killThreshold"
		],

		bonusStats: [
			"oa",
			"da",
			"elemental",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges",
			"attackRate"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}

#endregion

#region//batons

function scr_genMelee_aspisAndBaton(level, rarity) {

	var melee = new melee_shieldAndBaton(level, rarity);
	melee.name = "Aspis and Baton";
	melee.spr = spr_aspis;
	
	melee.bonusStats.spd = -1;
	melee.attackRate = 1.8;
	melee.rechargeTime = 1.6;
	
	//defense and resistance
	var minDa = 15 + rarity * 4 + ceil(level * 0.75);
	var maxDa = minDa + 15;
	
	melee.bonusStats.da = irandom_range_biased(minDa, maxDa, LOOT_BIAS_MILD);
	
	var resMin = 1 + max(0, level - 5);
	var resMax = 2 + max(1, level - 2) + rarity;
	var res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
	
	if (res > 0) melee.bonusStats.meleeRes = res;

	if (rarity > 2) {
		
		resMin = max(0, level - 5) + rarity;
		resMax = 2 + level + rarity * 2;
		res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
		
		var resPool = ["fireRes","chemRes","elecRes","radRes"];
		var resTypes = [];
		var typeAmount = irandom_range_biased(1, 4, LOOT_BIAS_MILD);
		
		repeat(typeAmount) {
			var t = scr_randomElementRemove(resPool);
			array_push(resTypes, t);
		}
		
		res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
		
		if (res > 0) {
			
			scr_weapons_addResistanceToTypesSpread(melee, res, resTypes);
			
		}
	
	}

	//damage
	var damTypes = ["kin"];
	
	if (level > 3) {

		damTypes = [];

		repeat(4) { array_push(damTypes, "kin"); }
		repeat(1) { array_push(damTypes, "fire"); }
		repeat(1) { array_push(damTypes, "chem"); }
		repeat(2) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"attackRate",
			"maxCharges",
			"rechargeTime",
		],

		bonusStats: [
			"da",
			"da",
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}

function scr_genMelee_towerShieldAndBaton(level, rarity) {

	var melee = new melee_shieldAndBaton(level, rarity);
	melee.name = "Tower Shield and Baton";
	melee.spr = spr_towerShield;
	
	melee.bonusStats.spd = -1;
	melee.attackRate = 1.8;
	melee.rechargeTime = 1.6;
	
	//defense and resistance
	var minDa = 15 + rarity * 4 + ceil(level * 0.75);
	var maxDa = minDa + 15;
	
	melee.bonusStats.da = irandom_range_biased(minDa, maxDa, LOOT_BIAS_MILD);
	
	var resMin = 1 + max(0, level - 5);
	var resMax = 2 + max(1, level - 2) + rarity;
	var res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
	
	if (res > 0) melee.bonusStats.projRes = res;

	if (rarity > 2) {
		
		resMin = max(0, level - 5) + rarity;
		resMax = 2 + level + rarity * 2;
		res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
		
		var resPool = ["fireRes","chemRes","elecRes","radRes"];
		var resTypes = [];
		var typeAmount = irandom_range_biased(1, 4, LOOT_BIAS_MILD);
		
		repeat(typeAmount) {
			var t = scr_randomElementRemove(resPool);
			array_push(resTypes, t);
		}
		
		res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
		
		if (res > 0) {
			
			scr_weapons_addResistanceToTypesSpread(melee, res, resTypes);
			
		}
	
	}

	//damage
	var damTypes = ["kin"];
	
	if (level > 3) {

		damTypes = [];

		repeat(4) { array_push(damTypes, "kin"); }
		repeat(1) { array_push(damTypes, "fire"); }
		repeat(1) { array_push(damTypes, "chem"); }
		repeat(2) { array_push(damTypes, "elec"); }
		repeat(1) { array_push(damTypes, "rad"); }
		
	}
	
	melee = scr_genMelee_applyGenericDamage(melee, level, rarity, damTypes);

	var config = {

		standardStats: [
			"attackRate",
			"attackRate",
			"maxCharges",
			"rechargeTime",
		],

		bonusStats: [
			"da",
			"da",
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}

function scr_genMelee_electrifiedBaton(level, rarity) {

	var melee = new melee_shieldAndBaton(level, rarity);
	melee.name = "Shield and Electrified Baton";
	melee.spr = spr_electrifiedBaton;
	
	melee.hitSounds = global.data.soundProfiles.prod; //[snd_zap];
	
	//defense and resistance
	var minDa = 10 + rarity + ceil(level * 0.5);
	var maxDa = minDa + 10;
	
	melee.bonusStats.da = irandom_range_biased(minDa, maxDa, LOOT_BIAS_MILD);
	
	var resMin = max(0, level - 5) + rarity;
	var resMax = 2 + level + rarity * 2;
	var res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
	
	if (res > 0) melee.bonusStats.kinRes = res;

	if (rarity > 2) {
		
		var resPool = ["fireRes","chemRes","elecRes","radRes"];
		var resTypes = [];
		var typeAmount = irandom_range_biased(1, 4, LOOT_BIAS_MILD);
		
		repeat(typeAmount) {
			var t = scr_randomElementRemove(resPool);
			array_push(resTypes, t);
		}
		
		res = irandom_range_biased(resMin, resMax, LOOT_BIAS);
		
		if (res > 0) {
			
			scr_weapons_addResistanceToTypesSpread(melee, res, resTypes);
			
		}
	
	}

	//damage
	melee.damage.elec = melee.damage.kin;
	melee.damage.kin = 4;
	
	repeat(rarity) {
		if (scr_random_chance(50)) melee.damage.kin += 2;
	}
	
	var damRange = scr_weapons_calculateBonusDamage(melee.baseDamage, level);
	var bonusDam = irandom_range_biased(damRange.low, damRange.high, LOOT_BIAS);
	scr_weapons_addDamage(melee, "elec", bonusDam);

	var config = {

		standardStats: [
			"attackRate",
			"attackRate",
			"maxCharges",
			"rechargeTime",
		],

		bonusStats: [
			"da",
			"da",
			"elemental"
		],

		//damTypes: damTypes

	};

	if (rarity > 2) {
		array_push(config.standardStats, "dam");
	}

	if (rarity > 3) {
		array_push(
			config.standardStats,
			"dam",
			"maxCharges"
		);
	}

	return scr_genMelee_applyGenericBonuses(
		melee,
		level,
		rarity,
		config
	);

}	

#endregion

#endregion