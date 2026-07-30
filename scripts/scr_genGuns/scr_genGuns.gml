function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	//base stats
	var baseDam = gun.damage.kin;
	var baseClipSize = gun.clipSize;
	var baseFireRate = gun.fireRate;
	var baseReloadTime = gun.reloadTime;
	var baseRecoil = gun.recoil;
	var baseRange = gun.range;
	
	//damage
	var damRange = scr_weapons_calculateBonusDamage(baseDam, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);
	var damType = "kin";
	
	if (level == 1) bonusDam = choose(0, bonusDam);

	if (rarity > 1) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
	
	scr_loot_addDamage(gun, damType, bonusDam);
	
	//other bonuses

	if (rarity > 1) {
		
		var keys = ["clipSize", "fireRate", "reloadTime", "recoil", "range"];
		var bonusKeys = ["oa", "elemental"];

		if (rarity > 2) array_push(keys, "dam");
		if (rarity > 3) array_push(keys, "dam", "clipSize","fireRate");

		repeat(rarity - 1) {
	
			var type = "standardStats";
			var bonusChance = (rarity - 2) * 5;
			
			if (rarity > 2 and array_length(bonusKeys) > 0 and scr_random_chance(bonusChance)) type = "bonusStats";

			//STANDARD STATS
			if (type == "standardStats") {
	
				var key = scr_randomElementRemove(keys);
				var amount = 0;
			
				if (key == "dam") {

					var low = 1 + level div 5;
					var high = 2 + ceil(level / 4);
					amount = irandom_range_biased(low, high, LOOT_BIAS);
			
					scr_loot_addDamageToExisting(gun, amount);
			
				}
			
				if (key == "clipSize") {
				
					var range = scr_stats_calculateBonusStatInteger(baseClipSize, level);
					var low = range.low;
					var high = range.high;
					amount = irandom_range_biased(low, high, LOOT_BIAS);
					amount = clamp(amount, 1, baseClipSize);
				
				}
			
				if (key == "range") {
				
					var range = scr_stats_calculateBonusStatInteger(baseRange, level);
					var low = range.low;
					var high = range.high;
					amount = irandom_range_biased(low, high, LOOT_BIAS);
					amount = clamp(amount, 1, baseRange);
				
				}
			
				if (key == "fireRate") {
				
					var range = scr_stats_calculateBonusStatFloat(baseFireRate, level);
					var low = range.low;
					var high = range.high;
					amount = random_range_biased(low, high, LOOT_BIAS);
					amount = clamp(amount, 0.1, baseFireRate);
				
				}
			
				if (key == "reloadTime") {
				
					amount = -scr_stats_rollSteppedBonus(0.1, baseReloadTime * 0.5, level);

				}
			
				if (key == "recoil") {
				
					amount = -scr_stats_rollSteppedBonus(0.02, baseRecoil * 0.5, level);
				
				}
	
				//add stat
				if (key != "dam") {
				
					if (amount != 0) gun[$ key] += amount;
			
				}
			
			} else {
			//BONUS STATS
			
				var key = scr_randomElementRemove(bonusKeys);
				var amount = 0;
			
				if (key == "oa") {
				
					amount = scr_stats_rollSteppedBonus(5, 50, level);
					scr_loot_addBonusStat(gun, "oa", amount);
					
				}
				
				if (key == "elemental") {
				
					var highest = scr_weapon_pickFromTop2DamageTypes(gun);
					var elem = highest.key;
					if (!is_string(elem)) continue;
					
					var newKey = elem + "DamPerc";
					
					amount = scr_stats_rollSteppedBonus(5, 50, level);
					
					scr_loot_addBonusStat(gun, newKey, amount);
					
				}
			
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