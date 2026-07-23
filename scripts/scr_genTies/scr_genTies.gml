function scr_genTies_physics(level, rarity) {

	var tie = new tieInst(level, rarity);
	var stats = tie.stats;
	
	var keys = ["kinDamPerc","radDamPerc","maxEnergy","energyRegen","shieldRegen","shieldRegenDelay"];
	keys = array_concat(keys, keys);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		var low = 1;
		var high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "kinDamPerc" or key == "radDamPerc") {
			
			low = level * 2;
			high = low + 10;
			
		}
		
		if (key == "maxEnergy") {
			
			low = level * 5;
			high = low + 10;
			
		}
		
		if (key == "energyRegen") {
			
			low = level * 0.1;
			high = low + .2;
			integer = false;
			
		}
		
		if (key == "shieldRegen") {
			
			low = level * 0.05;
			high = low + .1;
			integer = false;
			
		}
		
		if (key == "shieldRegenDelay") {
			
			low = level * -0.015;
			high = low + .1;
			integer = false;
			
		}
	
	
		if (integer) {
			amount = irandom_range_biased(low, high, LOOT_BIAS, true);
		} else {
			amount = random_range_biased(low, high, LOOT_BIAS, true, 3);
		}
	
		if (amount > 0) scr_loot_addStat(tie, key, amount);
	
	}
	
	tie.name = "Physicist Tie";
	
	return tie;
	
}