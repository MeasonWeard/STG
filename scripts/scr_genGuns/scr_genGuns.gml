function scr_genGuns_blaster(level, rarity) {

	var gun = new gun_blaster(level, rarity);

	if (rarity == 1) {
	
		var bonusDam = irandom_range(1, 4);
		if (level == 1) bonusDam = choose(0, bonusDam);
		
		if (level > 1) {
		
			bonusDam += irandom_range(level - 1, level);
		
		}
		
		var damType = "kinDam";
		
		if (level > 2) {
		
			damType = choose("kinDam","fireDam","chemDam","elecDam","radDam");
		
		}
		
		scr_loot_addStat(gun, key, bonusDam);
		
	}

}