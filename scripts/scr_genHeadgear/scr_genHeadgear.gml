//GENERIC
function scr_genHeadgear_hardHat(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level * 2 + 1
	var high = level * 2 + 5;
	
	stats.kinRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
	
		low = factor * 3;
		high = factor * 4;
	
		stats.kinRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}
	

	headgear.name = "Hard Hat";
	
	return headgear;
	
}

function scr_genHeadgear_weldingMask(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level * 2 + 1
	var high = level * 2 + 5;
	
	stats.fireRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		

		low = factor * 3;
		high = factor * 4;
	
		stats.fireRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}

	headgear.name = "Welding Mask";
	
	return headgear;
	
}

function scr_genHeadgear_safetyMask(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level * 2 + 1
	var high = level * 2 + 5;
	
	stats.chemRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 3;
		high = factor * 4;
	
		stats.chemRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}

	headgear.name = "Safety Mask";
	
	return headgear;
	
}

function scr_genHeadgear_arcFlashHood(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level * 2 + 1
	var high = level * 2 + 5;
	
	stats.elecRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 3;
		high = factor * 4;
	
		stats.elecRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}

	headgear.name = "Arc Flash Hood";
	
	return headgear;
	
}

function scr_genHeadgear_leadHood(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level * 2 + 1
	var high = level * 2 + 5;
	
	stats.radRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 3;
		high = factor * 4;
	
		stats.radRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}

	headgear.name = "Lead Hood";
	
	return headgear;
	
}

function scr_genHeadgear_respirator(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level;
	var high = level + 4;
	
	stats.chemRes = irandom_range(low, high);
	stats.radRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 2;
		high = factor * 3;
	
		stats.chemRes += irandom_range_biased(low, high, LOOT_BIAS);
		stats.radRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}
	
	headgear.name = "Respirator";
	
	return headgear;
	
}

function scr_genHeadgear_safetyGoggles(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level;
	var high = level + 4;
	
	stats.chemRes = irandom_range(low, high);
	stats.fireRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 2;
		high = factor * 3;
	
		stats.chemRes += irandom_range_biased(low, high, LOOT_BIAS);
		stats.fireRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}
	
	headgear.name = "Safety Goggles";
	
	return headgear;
	
}

function scr_genHeadgear_blastHelmet(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level;
	var high = level + 4;
	
	stats.kinRes = irandom_range(low, high);
	stats.fireRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 2;
		high = factor * 3;
	
		stats.kinRes += irandom_range_biased(low, high, LOOT_BIAS);
		stats.fireRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}
	
	headgear.name = "Blast Helmet";
	
	return headgear;
	
}

function scr_genHeadgear_insulatedHood(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level;
	var high = level + 4;
	
	stats.elecRes = irandom_range(low, high);
	stats.fireRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 2;
		high = factor * 3;
	
		stats.elecRes += irandom_range_biased(low, high, LOOT_BIAS);
		stats.fireRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}
	
	headgear.name = "Insulated Hood";
	
	return headgear;
	
}

function scr_genHeadgear_radiationVisor(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level;
	var high = level + 4;
	
	stats.elecRes = irandom_range(low, high);
	stats.radRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 2;
		high = factor * 3;
	
		stats.elecRes += irandom_range_biased(low, high, LOOT_BIAS);
		stats.radRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}

	headgear.name = "Radiation Visor";
	
	return headgear;
	
}

function scr_genHeadgear_dielectricHelmet(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level;
	var high = level + 4;
	
	stats.kinRes = irandom_range(low, high);
	stats.elecRes = irandom_range(low, high);
	
	var factor = rarity - 1;
	
	if (rarity > 1) {
		
		low = factor * 2;
		high = factor * 3;
	
		stats.kinRes += irandom_range_biased(low, high, LOOT_BIAS);
		stats.elecRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}
	
	headgear.name = "Dielectric Helmet";
	
	return headgear;
	
}

//SPECIAL
function scr_genHeadgear_tacticalVisor(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	headgear.name = "Tactical Visor";
	
	var stats = headgear.stats;
	
	var keys = [
		"oa",
		"da",
		"gunDamPerc",
		"kinRes",
		"elecRes",
		"spd"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.oa = scr_statRolls_combatAbility(level, 1.5);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "oa" or key == "da") {
			amount = scr_statRolls_combatAbility(level);
		}
		
		if (key == "gunDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "kinRes" or key == "elecRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "spd") {
			amount = scr_statRolls_speed(level);
		}
		
		if (amount != 0) {
			scr_loot_addStat(headgear, key, amount);
		}
		
	}
	
	return headgear;
	
}

function scr_genHeadgear_traumaHelmet(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	headgear.name = "Trauma Helmet";
	
	var stats = headgear.stats;
	
	var keys = [
		"maxHp",
		"maxHpPerc",
		"hpRegen",
		"hpRegenPerc",
		"healingPerc",
		"kinRes",
		"da"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.maxHpPerc = scr_statRolls_maxHpPerc(level, 1.5);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level);
		}
		
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "healingPerc") {
			amount = scr_statRolls_healingPerc(level);
		}
		
		if (key == "kinRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "da") {
			amount = scr_statRolls_combatAbility(level);
		}
		
		if (amount != 0) {
			scr_loot_addStat(headgear, key, amount);
		}
		
	}
	
	return headgear;
	
}

function scr_genHeadgear_neuralInterface(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	headgear.name = "Neural Interface";
	
	var stats = headgear.stats;
	
	var keys = [
		"maxEnergy",
		"maxEnergyPerc",
		"energyRegen",
		"energyRegenPerc",
		"oa",
		"da",
		"gunDamPerc",
		"spd"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.energyRegenPerc = scr_statRolls_regenPerc(level, 1.5);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxEnergy") {
			amount = scr_statRolls_maxEnergy(level);
		}
		
		if (key == "maxEnergyPerc") {
			amount = scr_statRolls_maxEnergyPerc(level);
		}
		
		if (key == "energyRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "energyRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "oa" or key == "da") {
			amount = scr_statRolls_combatAbility(level);
		}
		
		if (key == "gunDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "spd") {
			amount = scr_statRolls_speed(level);
		}
		
		if (amount != 0) {
			scr_loot_addStat(headgear, key, amount);
		}
		
	}
	
	return headgear;
	
}

function scr_genHeadgear_faradayCrown(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	headgear.name = "Faraday Crown";
	
	var stats = headgear.stats;
	
	var keys = [
		"elecRes",
		"elecResPerc",
		"radRes",
		"radResPerc",
		"shieldRegen",
		"shieldRegenPerc",
		"shieldRegenDelay",
		"energyPackRegen"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.elecRes = scr_statRolls_resistance(level, 1.5);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "elecRes" or key == "radRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "elecResPerc" or key == "radResPerc") {
			amount = scr_statRolls_resistancePerc(level);
		}
		
		if (key == "shieldRegen") {
			amount = scr_statRolls_shieldRegen(level);
		}
		
		if (key == "shieldRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "shieldRegenDelay") {
			amount = scr_statRolls_shieldRegenDelay(level);
		}
		
		if (key == "energyPackRegen") {
			amount = scr_statRolls_packRegen(level);
		}
		
		if (amount != 0) {
			scr_loot_addStat(headgear, key, amount);
		}
		
	}
	
	return headgear;
	
}

function scr_genHeadgear_emergencyResponseHelmet(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	headgear.name = "Emergency Response Helmet";
	
	var stats = headgear.stats;
	
	var keys = [
		"maxHp",
		"maxHpPerc",
		"hpRegen",
		"hpRegenPerc",
		"healingPerc",
		"stimPackRegen",
		"fireRes",
		"chemRes"
	];
	
	keys = array_concat(keys, keys);
	
	//guaranteed effect
	stats.stimPackRegen = scr_statRolls_packRegen(level, 0.75);
	
	//extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level);
		}
		
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "healingPerc") {
			amount = scr_statRolls_healingPerc(level);
		}
		
		if (key == "stimPackRegen") {
			amount = scr_statRolls_packRegen(level);
		}
		
		if (key == "fireRes" or key == "chemRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (amount != 0) {
			scr_loot_addStat(headgear, key, amount);
		}
		
	}
	
	return headgear;
	
}

function scr_genHeadgear_hazmatHood(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	headgear.name = "Hazmat Hood";
	
	var stats = headgear.stats;
	
	var keys = [
		"radRes",
		"radResPerc",
		"chemRes",
		"chemResPerc",
		"maxHpPerc",
		"hpRegenPerc",
		"healingPerc",
		"stimPackRegen"
	];
	
	keys = array_concat(keys, keys);
	
	// guaranteed effect
	stats.radRes = scr_statRolls_resistance(level, 1.5);
	
	// extra stats
	repeat(rarity - 1) {
		
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "radRes" or key == "chemRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "radResPerc" or key == "chemResPerc") {
			amount = scr_statRolls_resistancePerc(level);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level);
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "healingPerc") {
			amount = scr_statRolls_healingPerc(level);
		}
		
		if (key == "stimPackRegen") {
			amount = scr_statRolls_packRegen(level);
		}
		
		if (amount != 0) {
			scr_loot_addStat(headgear, key, amount);
		}
		
	}
	
	return headgear;
	
}