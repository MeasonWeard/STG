function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(gun.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}

function scr_genGuns_pistol(level, rarity) {

	var gun = new gun_pistol(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(gun.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}

function scr_genGuns_smg(level, rarity) {

	var gun = new gun_smg(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(gun.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}

function scr_genGuns_pulseRifle(level, rarity) {

	var gun = new gun_smg(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(gun.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}

function scr_genGuns_shotgun(level, rarity) {

	var gun = new gun_shotgun(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(gun.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}

function scr_genGuns_autoShotgun(level, rarity) {

	var gun = new gun_autoShotgun(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(gun.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}