function scr_genHeadgear_hardHat(level, rarity) {

	var headgear = new headgearInst(level, rarity);
	var stats = headgear.stats;
	
	var low = level * 2 + 1
	var high = level * 2 + 5;
	
	stats.kinRes = irandom_range(low, high);
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = rarity - 1;
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
	
	if (rarity > 1) {
		
		var factor = 10;//rarity - 1;
		low = factor * 2;
		high = factor * 3;
	
		stats.kinRes += irandom_range_biased(low, high, LOOT_BIAS);
		stats.elecRes += irandom_range_biased(low, high, LOOT_BIAS);
		
	}
	
	headgear.name = "Dielectric Helmet";
	
	return headgear;
	
}