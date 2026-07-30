function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	var baseDam = gun.damage.kin;
	var baseClipSize = gun.clipSize;

	var damRange = scr_weapons_calculateBonusDamage(baseDam, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		scr_loot_addDamage(gun, damType, bonusDam);
	
		var keys = ["dam", "dam", "clipSize", "clipSize", "fireRate", "reloadTime", "stability"];

		repeat(rarity - 1) {
	
			var key = scr_randomElementRemove(keys);
			
			var levelDec = level * 0.1;
			var low = 1;
			var high = 2;
			var amount = 0;
			var integer = true;
		
			if (key == "dam") {

				high = 1 + ceil(levelDec * baseDam);
				low = max(1, floor(high * 0.5));
			
				amount = irandom_range(low, high);
			
				scr_loot_addDamageToExisting(weapon, amount);
			
			}
			
			if (key == "clipSize") {
				
				high = ceil(levelDec * (baseClipSize * 0.5));
				low = max(1, floor(high * 0.25));
				
			}
	
			//add stat
			if (key != "dam") {
				
				if (integer) {
					amount = irandom_range_biased(low, high, LOOT_BIAS, true);
				} else {
					amount = random_range_biased(low, high, LOOT_BIAS, true, 3);
				}
	
				if (amount > 0) scr_loot_addStat(gun, key, amount);
			
			}
	
		}
	
	}
	
		
	return gun;

}

function scr_genGuns_pistol(level, rarity) {

	var gun = new gun_pistol(level, rarity);

	var damRange = scr_weapons_calculateBonusDamage(gun.damage.kin, level);
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

	var damRange = scr_weapons_calculateBonusDamage(gun.damage.kin, level);
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

	var damRange = scr_weapons_calculateBonusDamage(gun.damage.kin, level);
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

	var damRange = scr_weapons_calculateBonusDamage(gun.damage.kin, level);
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

	var damRange = scr_weapons_calculateBonusDamage(gun.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}