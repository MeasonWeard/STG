function scr_genCoats_generic(level, rarity) {

	var coat = new coatInst(level, rarity);
	var stats = coat.stats;
	
	//basic resistance
	var points = 3 + level;
	
	var elements = ["kinRes","fireRes","chemRes","elecRes","radRes"];
	
	var whole = points div 5;
	var remainder = points mod 5;

	if (whole > 0) {
		stats.kinRes = whole;
		stats.fireRes = whole;
		stats.chemRes = whole;
		stats.elecRes = whole;
		stats.radRes = whole;
	}
	
	repeat(whole) {
		
		var el = scr_randomElement(elements);
		
		scr_loot_addStat(coat, el, 1);
		
	}
	
	elements = array_shuffle(elements);
	
	for (var i = 0; i < remainder; i ++) {
	
		var el = elements[i];
		
		scr_loot_addStat(coat, el, 1);
	
	}
	
	//rarity improvements
	var common = ["maxHp","maxEnergy"];
	var lessCommon = ["kinRes","fireRes","chemRes","elecRes","radRes","da"];
	var rare = ["maxHpPerc","maxEnergyPerc","kinResPerc","fireResPerc","chemResPerc","elecResPerc","radResPerc"];
	
	var commonChance = 60;
	var lessCommonChance = 70;
	
	repeat(rarity - 1) {
	
		var key = undefined;
		var amount = 0;
	
		//pick a key
		if (array_length(common) > 0 and scr_random_chance(commonChance)) {

			key = scr_randomElementRemove(common);
			
		} else if (array_length(lessCommon) > 0 and scr_random_chance(lessCommonChance)) {

			key = scr_randomElementRemove(lessCommon);

		} else {
		
			if (array_length(rare) > 0) {

				key = scr_randomElementRemove(rare);

			}
		
		}
		
		//set amount
		if (key == "maxHp" or key == "maxEnergy") {
			var low = max(4, level * 4);
			var high = low + 15;
			amount = irandom_range_biased(low, high, LOOT_BIAS_MILD);
		}
		
		if (key == "kinRes" or key == "fireRes" or key == "chemRes" or key == "elecRes" or key == "radRes") {
			var low = max(1, ceil(level * 0.25));
			var high = low + 4;
			amount = irandom_range_biased(low, high, LOOT_BIAS);
		}
		
		if (key == "da") {
			var low = level + 1;
			var high = low + 4;
			amount = irandom_range_biased(low, high, LOOT_BIAS_MILD);
		}
		
		if (key == "maxHpPerc" or key == "maxEnergyPerc" or key == "kinResPerc" or key == "fireResPerc"
			or key == "chemResPerc" or key == "elecResPerc" or key == "radResPerc") {
			var low = max(1, floor(level * 0.45));
			var high = low + 4;
			amount = irandom_range_biased(low, high, LOOT_BIAS);
		}
		
		//set stats
		if (key != undefined and amount != 0) {
			scr_loot_addStat(coat, key, amount);
		}
		
		if (level > 4) {
			
			var spr = spr_coat;
			var adj = "";
			
			var el = scr_gear_getHighestEffectiveResistanceType(coat, true);
			var elKey = el.key;
			
			switch(elKey) {
			
				case "kinRes": spr = spr_coatKin; adj = "Padded " ; break;
				case "fireRes": spr = spr_coatFire; adj = "Fire-retardant "; break;
				case "chemRes": spr = spr_coatChem; adj = "Fluoropolymer "; break;
				case "elecRes": spr = spr_coatElec; adj = "Insulated "; break;
				case "radRes": spr = spr_coatRad; adj = "Lead-lined "; break;
			
			}
			
			coat.spr = spr;
			coat.name = adj + "Coat";
		
		}

	}
	
	return coat;

}