function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	var bonusDam = irandom_range(1, 4);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	if (level > 1) {
		
		bonusDam += irandom_range(level - 1, ceil(level * 2));
		
	}
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}

function scr_genGuns_pistol(level, rarity) {

	var gun = new gun_pistol(level, rarity);

	var bonusDam = irandom_range(2, 4);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	if (level > 1) {
		
		bonusDam += irandom_range(level, ceil(level * 3));
		
	}
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);

	return gun;

}

function scr_genGuns_smg(level, rarity) {

	var gun = new gun_smg(level, rarity);

	var bonusDam = irandom_range(1, 2);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	if (level > 1) {
		
		bonusDam += irandom_range(level - 1, ceil(level * 1.3));
		
	}
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	return gun;

}

function scr_genGuns_pulseRifle(level, rarity) {

	var gun = new gun_smg(level, rarity);

	var bonusDam = irandom_range(2, 6);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	if (level > 1) {
		
		bonusDam += irandom_range(level * 2, ceil(level * 5.2));
		
	}
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		

	
	return gun;

}

function scr_genGuns_shotgun(level, rarity) {

	var gun = new gun_shotgun(level, rarity);

	var bonusDam = irandom_range(1, 3);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	if (level > 1) {
		
		bonusDam += irandom_range(level - 1, ceil(level * 1.7));
		
	}
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		

	
	return gun;

}

function scr_genGuns_autoShotgun(level, rarity) {

	var gun = new gun_autoShotgun(level, rarity);

	var bonusDam = irandom_range(1, 2);

	if (level == 1) bonusDam = choose(0, bonusDam);
		
	if (level > 1) {
		
		bonusDam += irandom_range(level - 1, ceil(level * 1.5));
		
	}
		
	var damType = "kin";
		
	if (level > 2) {
		
		damType = choose("kin","kin","fire","chem","elec","rad");
		
	}
		
	scr_loot_addDamage(gun, damType, bonusDam);
		
	
	
	return gun;

}