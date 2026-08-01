#region //HELPER FUNCTIONS
function scr_genMelee_applyGenericBonuses(melee, level, rarity, config, bonusChanceMod = 1) {

	if (rarity <= 1) {
		return melee;
	}

	// Store original values before modifying anything
	var baseStats = {
		attackRate: melee.attackRate,
		maxCharges: melee.maxCharges,
		rechargeTime: melee.rechargeTime,
		killThreshold: melee.killThreshold
	};

	// Initial damage bonus
	var baseDamType = scr_weapons_getHighestDamageType(melee);
	var baseDamTypeKey = baseDamType.key;
	var baseDamage = melee.damage[$ baseDamTypeKey];
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);

	if (level == 1) {
		bonusDamage = choose(0, bonusDamage);
	}

	var damType = baseDamTypeKey;

	if (rarity > 1) {
		damType = scr_randomElement(config.damTypes);
	}

	scr_loot_addDamage(melee, damType, bonusDamage);

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

			low = 1 + level div 5;
			high = 2 + ceil(level / 4);

			amount = irandom_range_biased(low, high, LOOT_BIAS);
			scr_loot_addDamageToExisting(melee, amount);

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

		case "killThreshold":
		
			var inc = ceil(baseStats.killThreshold / 5);
			amount = scr_stats_rollSteppedBonus(inc, baseStats.killThreshold * 10, level);

		break;

	}

	if (key != "dam" and amount != 0) {
		melee[$ key] += amount;
	}

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

	}

}
#endregion

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

		damTypes: damTypes

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

		damTypes: damTypes

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

		damTypes: damTypes

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