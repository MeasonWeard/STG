function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	if (rarity == 1) {
	
		var bonusDam = irandom_range(1, 4);
		if (level == 1) bonusDam = choose(0, bonusDam);
		
		if (level > 1) {
		
			bonusDam += irandom_range(level - 1, ceil(level * 1.5));
		
		}
		
		var damType = "kin";
		
		if (level > 2) {
		
			damType = choose("kin","kin","fire","chem","elec","rad");
		
		}
		
		scr_loot_addDamage(gun, damType, bonusDam);
		
	}
	
	return gun;

}