#region //HELPER FUNCTIONS
function scr_genGuns_applyGenericBonuses(gun, level, rarity, config, bonusChanceMod = 1) {

	if (rarity <= 1) {
		return gun;
	}

	// Store original values before modifying anything
	var baseStats = {
		clipSize: gun.clipSize,
		fireRate: gun.fireRate,
		reloadTime: gun.reloadTime,
		recoil: gun.recoil,
		stability: gun.stability,
		minAimOff: gun.minAimOff,
		maxAimOff: gun.maxAimOff,
		range: gun.range,
		blastProjectiles: gun.blastProjectiles,
		blastSpread: gun.blastSpread
	};

	// Initial damage bonus
	var baseDamType = scr_weapons_getHighestDamageType(gun);
	var baseDamTypeKey = baseDamType.key;
	var baseDamage = gun.damage[$ baseDamTypeKey];
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);

	if (level == 1) {
		bonusDamage = choose(0, bonusDamage);
	}

	var damType = baseDamTypeKey;

	if (rarity > 1) {
		damType = scr_randomElement(config.damTypes);
	}

	scr_loot_addDamage(gun, damType, bonusDamage);

	var standardKeys = [];
	array_copy(standardKeys, 0, config.standardStats, 0, array_length(config.standardStats));

	var bonusKeys = [];
	array_copy(bonusKeys, 0, config.bonusStats, 0, array_length(config.bonusStats));

	repeat (rarity - 1) {

		var bonusChance = max(0, ((rarity - 2) * 5) * bonusChanceMod);
		var useBonusStat = rarity > 2 and array_length(bonusKeys) > 0 and scr_random_chance(bonusChance);

		if (useBonusStat) {

			var key = scr_randomElementRemove(bonusKeys);
			scr_genGuns_applyBonusStat(gun, key, level);

		} else {

			if (array_length(standardKeys) <= 0) continue;

			var key = scr_randomElementRemove(standardKeys);
			scr_genGuns_applyStandardStat(gun, key, level, baseStats);

		}

	}

	return gun;

}

function scr_genGuns_applyStandardStat(gun, key, level, baseStats) {

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
			scr_loot_addDamageToExisting(gun, amount);

		break;

		case "clipSize":

			range = scr_stats_calculateBonusStatInteger(baseStats.clipSize, level);

			amount = irandom_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, 1, baseStats.clipSize);

		break;

		case "range":

			range = scr_stats_calculateBonusStatInteger(baseStats.range, level);

			amount = irandom_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, 1, baseStats.range);

		break;
		
		case "blastProjectiles" :
		
			range = scr_stats_calculateBonusStatInteger(baseStats.blastProjectiles, level);

			amount = irandom_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, 1, baseStats.blastProjectiles);
		
		break;

		case "fireRate":

			range = scr_stats_calculateBonusStatFloat(baseStats.fireRate, level);

			amount = random_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, 0.1, baseStats.fireRate);

		break;
		
		case "minAimOff":

			range = scr_stats_calculateBonusStatFloat(baseStats.minAimOff, level);

			amount = -random_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, -baseStats.minAimOff * 0.5, -0.01);

		break;
		
		case "maxAimOff":

			range = scr_stats_calculateBonusStatFloat(baseStats.maxAimOff, level);

			amount = -random_range_biased(range.low, range.high, LOOT_BIAS);
			amount = clamp(amount, -baseStats.maxAimOff * 0.5, -0.01);

		break;
		
		case "blastSpread":

			//range = scr_stats_calculateBonusStatFloat(baseStats.blastSpread, level);
			
			low = baseStats.blastSpread * 0.01;
			high = baseStats.blastSpread * 0.125;
			
			amount = random_range_biased(low, high, LOOT_BIAS);

			if (scr_random_chance(50)) {
				amount = -amount;
			}

			amount = clamp(
				amount,
				-baseStats.blastSpread * 0.75,
				baseStats.blastSpread * 0.75
			);

		break;

		case "reloadTime":

			amount = -scr_stats_rollSteppedBonus(0.05, baseStats.reloadTime * 0.5, level);

		break;

		case "recoil":

			amount = -scr_stats_rollSteppedBonus(0.02, baseStats.recoil * 0.5, level);

		break;

	}

	if (key != "dam" and amount != 0) {
		gun[$ key] += amount;
	}

}

function scr_genGuns_applyBonusStat(gun, key, level) {

	var amount = 0;
	var statKey = "";
	
	switch (key) {

		case "oa":

			amount = scr_stats_rollSteppedBonus(5, 50, level);
			scr_loot_addBonusStat(gun, "oa", amount);

		break;
		
		case "da":

			amount = scr_stats_rollSteppedBonus(5, 50, level);
			scr_loot_addBonusStat(gun, "da", amount);

		break;
		
		case "moveSpeed":

			amount = scr_stats_rollSteppedBonus(0.1, 2, level);
			scr_loot_addBonusStat(gun, "spd", amount);

		break;

		case "elemental":

			var result = scr_weapons_pickFromTop2DamageTypes(gun);

			if (is_undefined(result)) break;

			statKey = result.key + "DamPerc";
			amount = scr_stats_rollSteppedBonus(5, 50, level);

			scr_loot_addBonusStat(gun, statKey, amount);

		break;

	}

}
#endregion

//GUNS
function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "recoil", "range"],

		bonusStats: ["oa", "elemental"],
		
		damTypes: ["kin","kin","fire","chem","elec","rad"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "fireRate");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_pistol(level, rarity) {

	var gun = new gun_pistol(level, rarity);

	var config = {
		
		standardStats: ["clipSize", "reloadTime", "recoil", "range", "maxAimOff"],

		bonusStats: ["oa", "elemental"],
		
		damTypes: ["kin","kin","fire","chem","elec","rad"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "maxAimOff");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_smg(level, rarity) {

	var gun = new gun_smg(level, rarity);

	var config = {
		
		standardStats: ["clipSize", "clipSize", "reloadTime", "fireRate", "fireRate", "maxAimOff"],

		bonusStats: ["elemental", "moveSpeed"],
		
		damTypes: ["kin","kin","fire","chem","elec","rad"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "fireRate");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_pulseRifle(level, rarity) {

	var gun = new gun_pulseRifle(level, rarity);

	var config = {
		
		standardStats: ["clipSize", "reloadTime", "dam", "maxAimOff", "minAimOff", "recoil"],

		bonusStats: ["oa", "oa"],
		
		damTypes: ["kin","kin","fire","chem","elec","rad"]
		
	};
	
	if (scr_random_chance(50)) array_push(config.bonusStats, "elemental");
	
	if (rarity > 2) array_push(config.standardStats, "range");
	if (rarity > 3) array_push(config.standardStats, "maxAimOff");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config, 2);

}

function scr_genGuns_shotgun(level, rarity) {

	var gun = new gun_shotgun(level, rarity);

	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "blastProjectiles", "blastSpread", "range"],

		bonusStats: ["da","elemental"],
		
		damTypes: ["kin","kin","fire","chem","elec","rad"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_autoShotgun(level, rarity) {

	var gun = new gun_autoShotgun(level, rarity);

	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "blastProjectiles", "blastSpread", "range"],

		bonusStats: ["da","elemental"],
		
		damTypes: ["kin","kin","fire","chem","elec","rad"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}