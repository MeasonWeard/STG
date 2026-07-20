function scr_genMelee_cleaver(level, rarity) {

	var melee = new melee_cleaver(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(melee.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 3) {
		
		
		var damTypes = [];
		
		array_push(damTypes, ["kin", 100]);
		array_push(damTypes, ["fire", 50]);
		array_push(damTypes, ["chem", 70]);
		array_push(damTypes, ["elec", 50]);
		array_push(damTypes, ["rad", 20]);
		
		damType = scr_random_weightedPick(damTypes);

		
	}
		
	scr_loot_addDamage(melee, damType, bonusDam);
		
	return melee;

}

function scr_genMelee_hammer(level, rarity) {

	var melee = new melee_hammer(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(melee.damage.kin, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "kin";
		
	if (level > 3) {
		
		var damTypes = [];
		
		array_push(damTypes, ["kin", 100]);
		array_push(damTypes, ["fire", 40]);
		array_push(damTypes, ["chem", 20]);
		array_push(damTypes, ["elec", 40]);
		array_push(damTypes, ["rad", 20]);
		
		damType = scr_random_weightedPick(damTypes);
		
	}
		
	scr_loot_addDamage(melee, damType, bonusDam);
		
	return melee;

}

function scr_genMelee_prod(level, rarity) {

	var melee = new melee_prod(level, rarity);

	var damRange = scr_guns_calculateBonusDamage(melee.damage.elec, level);
	var bonusDam = irandom_range(damRange.low, damRange.high);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	var damType = "elec";
		
	if (level > 3) {
		
		var damTypes = [];
		
		array_push(damTypes, ["fire", 75]);
		array_push(damTypes, ["elec", 100]);
		array_push(damTypes, ["rad", 50]);
		
		damType = scr_random_weightedPick(damTypes);
		
	}
		
	scr_loot_addDamage(melee, damType, bonusDam);
		
	return melee;

}