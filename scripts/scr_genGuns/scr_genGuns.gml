#region //HELPER FUNCTIONS
function scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes) {
	
	if (rarity < 1) {
		return gun;
	}
	
	var baseDamage = gun.baseDamage;
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	var baseDamTypeKey = scr_weapons_getHighestDamageType(gun);

	if (level == 1) {
		bonusDamage = choose(0, bonusDamage);
	}

	var damType = baseDamTypeKey;

	if (rarity > 1) {
		damType = scr_randomElement(damTypes);
	}

	scr_weapons_addDamage(gun, damType, bonusDamage);
	
	return gun;
	
}

function scr_genGuns_applyGenericBonuses(gun, level, rarity, config, bonusChanceMod = 1) {

	if (rarity < 1) {
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
		blastSpread: gun.blastSpread,
		baseDamage: gun.baseDamage
		
	};

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
			//IMPORTANT currently uses base damage AFTER applying leveled damage
			var baseDamage = baseStats.baseDamage;
			var bonusInt = baseDamage * 0.15;
			var bonusMax = baseDamage;
			
			amount = ceil(scr_stats_rollSteppedBonus(bonusInt, baseDamage * 2, level));
			
			scr_weapons_addDamageToExisting(gun, amount);

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
	
	//limit stats
	gun.reloadTime = max(gun.reloadTime, baseStats.reloadTime * 0.25);
	gun.range = min(gun.range, baseStats.range * 2);
	gun.minAimOff = max(gun.minAimOff, 0.1);
	gun.maxAimOff = max(gun.maxAimOff, 0.2);
	gun.recoil = max(gun.recoil, 0);
	gun.blastSpread = max(gun.blastSpread, 0.25);
	gun.fireRate = clamp(gun.fireRate, 0.1, 60);

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

#region //GENERIC
function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);

	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "recoil", "range"],

		bonusStats: ["oa", "elemental"],
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "fireRate");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_pistol(level, rarity) {

	var gun = new gun_pistol(level, rarity);
	
	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	var config = {
		
		standardStats: ["clipSize", "reloadTime", "recoil", "range", "maxAimOff"],

		bonusStats: ["oa", "elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "maxAimOff");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_smg(level, rarity) {

	var gun = new gun_smg(level, rarity);
	
	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	var config = {
		
		standardStats: ["clipSize", "clipSize", "reloadTime", "fireRate", "fireRate", "maxAimOff"],

		bonusStats: ["elemental", "moveSpeed"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "recoil");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_pulseRifle(level, rarity) {

	var gun = new gun_pulseRifle(level, rarity);
	
	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	var config = {
		
		standardStats: ["clipSize", "reloadTime", "dam", "maxAimOff", "minAimOff", "recoil"],

		bonusStats: ["oa", "oa"]
		
	};
	
	if (scr_random_chance(50)) array_push(config.bonusStats, "elemental");
	
	if (rarity > 2) array_push(config.standardStats, "range");
	if (rarity > 3) array_push(config.standardStats, "maxAimOff");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config, 2);

}

function scr_genGuns_shotgun(level, rarity) {

	var gun = new gun_shotgun(level, rarity);

	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "blastProjectiles", "blastSpread", "range"],

		bonusStats: ["da","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

function scr_genGuns_autoShotgun(level, rarity) {

	var gun = new gun_autoShotgun(level, rarity);
	
	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "blastProjectiles", "blastSpread", "range"],

		bonusStats: ["da","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}
#endregion
	
#region//SPECIAL BLASTERS

function scr_genGuns_plasmaBlaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);
	gun.name = "Plasma Blaster";

	var baseDamage = gun.baseDamage;
	var halfBaseDamage = ceil(baseDamage * 0.5);
	
	gun.damage.fire = halfBaseDamage;
	gun.damage.rad = halfBaseDamage;
	gun.damage.kin = 0;
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	
	scr_weapons_addDamageToExistingSpread(gun, bonusDamage);
	
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "recoil", "range"],

		bonusStats: ["oa", "elemental"],
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "fireRate");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

function scr_genGuns_ionBlaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);
	gun.name = "Ion Blaster";

	var baseDamage = gun.baseDamage;
	var halfBaseDamage = ceil(baseDamage * 0.5);
	
	gun.damage.elec = halfBaseDamage;
	gun.damage.rad = halfBaseDamage;
	gun.damage.kin = 0;
	gun.spd = 24;
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	
	scr_weapons_addDamageToExistingSpread(gun, bonusDamage);
	
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "recoil", "range"],

		bonusStats: ["oa", "elemental"],
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "fireRate");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}


#endregion

#region //SPECIAL PISTOLS

function scr_genGuns_autoPistol(level, rarity) {
	
	var gun = new gun_pistol(level, rarity);
	gun.name = "";
	
	var dt = choose("normal", "oneType");
	
	if (dt == "normal") {
		var damTypes = ["fire","chem","elec","rad"];
		gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	}
	
	if (dt == "oneType") {
	
		var baseDamage = gun.baseDamage + 1;
		var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
		var bonusDamage = irandom_range(damageRange.low, damageRange.high);
		
		var damType = choose("kin","fire","chem","elec","rad");

		gun.damage.kin = 0;
		gun.damage[$ damType] = baseDamage + bonusDamage;
		
		var prefix = "";
		
		switch(damType) {
		
			case "kin": prefix = "Strong "; break;
			case "fire": prefix = "Hot "; break;
			case "chem": prefix = "Caustic "; break;
			case "elec": prefix = "Charged "; break;
			case "rad": prefix = "Fissile "; break;
		
		}
		
		gun.name += prefix;
	
	}
	
	//
	gun.auto = true;
	gun.clipSize = 6;
	gun.fireRate = 9;
	
	gun.name += "Auto-Pistol";
	
	var extraDam = level div 4;
	repeat(extraDam) {
		
		var t = scr_weapons_pickFromTop2DamageTypes(gun);
		scr_weapons_addDamage(gun, t, 1);
		
	}
	
	//
	var config = {
		
		standardStats: ["clipSize", "clipSize", "reloadTime", "recoil", "range", "maxAimOff"],

		bonusStats: ["elemental","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "maxAimOff", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

function scr_genGuns_bigPistol(level, rarity) {
	
	var gun = new gun_pistol(level, rarity);
	var prefix = "";
	gun.name = "";

	var dt = choose("normal", "oneType");
	
	if (dt == "normal") {
		var damTypes = ["fire","chem","elec","rad"];
		gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	}
	
	if (dt == "oneType") {
	
		var baseDamage = gun.baseDamage + 1;
		var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
		var bonusDamage = irandom_range(damageRange.low, damageRange.high);
		
		var damType = choose("kin","fire","chem","elec","rad");

		gun.damage.kin = 0;
		gun.damage[$ damType] = baseDamage + bonusDamage;
		
		switch(damType) {
		
			case "kin": prefix = "Strong "; break;
			case "fire": prefix = "Hot "; break;
			case "chem": prefix = "Caustic "; break;
			case "elec": prefix = "Charged "; break;
			case "rad": prefix = "Fissile "; break;
		
		}
		
	}
	
	//
	gun.clipSize = 8;
	gun.fireRate = 3;
	gun.reloadTime += 0.4;
	gun.recoil += 1;
	gun.stability -= 0.02;
	gun.spd = 20;
	
	gun.name += "BIG " + prefix + "Pistol";
	
	var extraDam = level;
	repeat(extraDam) {
		
		var t = scr_weapons_pickFromTop2DamageTypes(gun);
		scr_weapons_addDamage(gun, t, 1);
		
	}
	
	//
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "recoil", "range", "maxAimOff"],

		bonusStats: ["elemental","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "maxAimOff", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

#endregion

#region //SPECIAL SMG

function scr_genGuns_slagSmg(level, rarity) {

	var gun = new gun_smg(level, rarity);
	gun.name = "Slag SMG";

	var baseDamage = gun.baseDamage;
	var halfBaseDamage = ceil(baseDamage * 0.5);
	
	gun.damage.fire = halfBaseDamage;
	gun.damage.chem = halfBaseDamage;
	gun.damage.kin = 0;
	gun.spd = 20;
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	
	scr_weapons_addDamageToExistingSpread(gun, bonusDamage);
	
	var config = {
		
		standardStats: ["clipSize", "clipSize", "reloadTime", "fireRate", "fireRate", "maxAimOff"],

		bonusStats: ["elemental", "moveSpeed"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "fireRate");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

function scr_genGuns_galvanicSmg(level, rarity) {

	var gun = new gun_smg(level, rarity);
	gun.name = "Galvanic SMG";

	var baseDamage = gun.baseDamage;
	var halfBaseDamage = ceil(baseDamage * 0.5);
	
	gun.damage.elec = halfBaseDamage;
	gun.damage.chem = halfBaseDamage;
	gun.damage.kin = 0;
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	
	scr_weapons_addDamageToExistingSpread(gun, bonusDamage);
	
	var config = {
		
		standardStats: ["clipSize", "clipSize", "reloadTime", "fireRate", "fireRate", "maxAimOff"],

		bonusStats: ["elemental", "moveSpeed"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "fireRate");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}
	
function scr_genGuns_notSoSubSmg(level, rarity) {

	var gun = new gun_smg(level, rarity);
	gun.name = "Not-So-Sub SMG";
	
	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	//
	gun.clipSize = 45;
	gun.fireRate = 13;
	gun.reloadTime = 2.2;
	gun.bonusStats.spd = -0.8;
	
	var config = {
		
		standardStats: ["clipSize", "clipSize", "reloadTime", "fireRate", "fireRate", "maxAimOff"],

		bonusStats: ["elemental", "da"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "recoil");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);

}

#endregion

#region //SPECIAL PULSE RIFLES

function scr_genGuns_arcPulseRifle(level, rarity) {

	var gun = new gun_pulseRifle(level, rarity);
	gun.name = "Arc Pulse Rifle";

	var baseDamage = gun.baseDamage;
	var halfBaseDamage = ceil(baseDamage * 0.5);
	
	gun.damage.fire = halfBaseDamage;
	gun.damage.elec = halfBaseDamage;
	gun.damage.kin = 0;
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	
	scr_weapons_addDamageToExistingSpread(gun, bonusDamage);
	
	var config = {
		
		standardStats: ["clipSize", "reloadTime", "dam", "maxAimOff", "minAimOff", "recoil"],

		bonusStats: ["oa", "oa"]
		
	};
	
	if (scr_random_chance(50)) array_push(config.bonusStats, "elemental");
	
	if (rarity > 2) array_push(config.standardStats, "range");
	if (rarity > 3) array_push(config.standardStats, "maxAimOff");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config, 2);
	
}

function scr_genGuns_sniperPulseRifle(level, rarity) {

	var gun = new gun_pulseRifle(level, rarity);
	gun.name = "Sniper Pulse Rifle";

	var damTypes = ["kin","kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);

	//
	gun.clipSize = 1;
	gun.reloadTime = 1.8;
	gun.shootSounds = global.data.soundProfiles.sniper;
	
	if (level > 0) {
		
		var minOa = max(1, floor(level * 0.5));
		var maxOa = level;
		gun.bonusStats.oa += irandom_range(minOa, maxOa);
		
	}
	
	if (level > 0) {
		
		var minDam = max(1, ceil(level * 0.5));
		var maxDam = level + 1;
		var bonusDam = irandom_range_biased(1, minDam, maxDam);
	
		repeat(bonusDam) {
	
			var t = scr_weapons_pickFromTop2DamageTypes(gun);
			scr_weapons_addDamage(gun, t, 1);
	
		}
	
	}
	
	//
	
	var config = {
		
		standardStats: ["reloadTime", "dam", "range", "minAimOff"],

		bonusStats: ["oa", "oa"]
		
	};
	
	if (scr_random_chance(50)) array_push(config.bonusStats, "elemental");
	
	if (rarity > 2) array_push(config.standardStats, "dam", "dam", "range", "reloadTime");
	if (rarity > 3) array_push(config.standardStats, "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config, 2);
	
}

#endregion

#region //SPECIAL SHOTGUNS

function scr_genGuns_sprayShotgun(level, rarity) {

	var gun = new gun_shotgun(level, rarity);
	gun.name = "";

	//damage
	gun.baseDamage -= 1;
	var baseDamage = gun.baseDamage;

	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	
	var damType = choose("fire", "chem");
	gun.damage.kin = 0;
	gun.damage[$ damType] = baseDamage + bonusDamage;
	
	//base stats
	gun.spd = 10;
	gun.blastSpread = 14;
	gun.blastProjectiles = 12;
	gun.projSprite = spr_bulletLarge;
	gun.range = 950;
	gun.shootSounds = global.data.soundProfiles.sprayGun;
	
	//name
	var prefix = "";
	
	switch(damType) {
		case "fire": prefix = "Flame "; break;
		case "chem": prefix = "Chemical "; break;
	}
	
	gun.name = prefix + " Spray Shotgun";

	//extra stats
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "blastProjectiles", "blastSpread", "range"],

		bonusStats: ["da","elemental","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

function scr_genGuns_doubleBarreledShotgun(level, rarity) {

	var gun = new gun_shotgun(level, rarity);
	gun.name = "Double-Barreled Shotgun";

	var damTypes = ["kin","kin","fire","chem","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	//base stats
	gun.auto = true;
	gun.fireRate = 20;
	gun.clipSize = 2;
	gun.reloadTime = 2.4;
	gun.blastSpread = 9;

	var extraDam = level div 3;
	repeat(extraDam) {
		
		var t = scr_weapons_pickFromTop2DamageTypes(gun);
		scr_weapons_addDamage(gun, t, 1);
		
	}

	//extra stats
	var config = {
		
		standardStats: ["reloadTime", "reloadTime", "blastProjectiles", "blastSpread", "range"],

		bonusStats: ["da","elemental","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam", "blastProjectiles");
	if (rarity > 3) array_push(config.standardStats, "dam", "blastProjectiles");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

#endregion

#region //SPECIAL AUTO-SHOTGUNS

function scr_genGuns_poloniumAutoShotgun(level, rarity) {

	var gun = new gun_autoShotgun(level, rarity);
	gun.name = "Polonium Auto-Shotgun";

	var baseDamage = gun.baseDamage;
	var halfBaseDamage = ceil(baseDamage * 0.5);
	
	gun.damage.chem = halfBaseDamage;
	gun.damage.rad = halfBaseDamage;
	gun.damage.kin = 0;
	
	var damageRange = scr_weapons_calculateBonusDamage(baseDamage, level);
	var bonusDamage = irandom_range(damageRange.low, damageRange.high);
	
	scr_weapons_addDamageToExistingSpread(gun, bonusDamage);
	
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "blastProjectiles", "blastSpread", "range"],

		bonusStats: ["da","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

function scr_genGuns_assassinatorAutoShotgun(level, rarity) {

	var gun = new gun_autoShotgun(level, rarity);
	gun.name = "Assassinator Auto-Shotgun";

	var damTypes = ["kin","kin","fire","chem","elec","elec","rad"];
	gun = scr_genGuns_applyGenericDamage(gun, level, rarity, damTypes);
	
	var extraDam = level div 4;
	repeat(extraDam) {
		
		var t = scr_weapons_pickFromTop2DamageTypes(gun);
		scr_weapons_addDamage(gun, t, 1);
		
	}
	
	//
	gun.fireRate = 2.3;
	gun.clipSize = 6;
	gun.blastProjectiles = 4;
	gun.blastSpread = 3.5;
	gun.range = 850;
	gun.spd = 24;
	gun.recoil = 2.2;
	
	//
	
	var config = {
		
		standardStats: ["clipSize", "fireRate", "reloadTime", "blastProjectiles", "range", "range"],

		bonusStats: ["oa","elemental"]
		
	};
	
	if (rarity > 2) array_push(config.standardStats, "dam");
	if (rarity > 3) array_push(config.standardStats, "dam", "clipSize", "reloadTime");
	
	return scr_genGuns_applyGenericBonuses(gun, level, rarity, config);
	
}

#endregion