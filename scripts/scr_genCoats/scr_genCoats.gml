function scr_genCoats_addBasicStats(coat, level, rarity) {
	
	var stats = coat.stats;
	
	//basic resistance
	var points = 3 + level + (level div 3);
	
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
		
		scr_loot_addStat(coat, el, 2);
		
	}
	
	elements = array_shuffle(elements);
	
	for (var i = 0; i < remainder; i ++) {
	
		var el = elements[i];
		
		scr_loot_addStat(coat, el, 1);
	
	}
	
}

function scr_genCoats_addRarityBonuses(coat, level, rarity) {
	
	var stats = coat.stats;
	
	//rarity improvements
	var common = ["maxHp","maxEnergy"];
	var lessCommon = ["kinRes","fireRes","chemRes","elecRes","radRes","da"];
	var rare = ["maxHpPerc","maxEnergyPerc","kinResPerc","fireResPerc","chemResPerc","elecResPerc","radResPerc"];
	
	var commonChance = 60;
	var lessCommonChance = 70;
	
	var rarFactor = 1 + rarity * 0.1;
	
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
			low = round(low * rarFactor);
			var high = low + 15;
			amount = irandom_range_biased(low, high, LOOT_BIAS_MILD);
		}
		
		if (key == "kinRes" or key == "fireRes" or key == "chemRes" or key == "elecRes" or key == "radRes") {
			var low = max(1, ceil(level * 0.25));
			low = round(low * rarFactor);
			var high = low + 4;
			amount = irandom_range_biased(low, high, LOOT_BIAS);
		}
		
		if (key == "da") {
			var low = level + 1 + (rarity - 1);
			var high = low + 4;
			amount = irandom_range_biased(low, high, LOOT_BIAS_MILD);
		}
		
		if (key == "maxHpPerc" or key == "maxEnergyPerc" or key == "kinResPerc" or key == "fireResPerc"
			or key == "chemResPerc" or key == "elecResPerc" or key == "radResPerc") {
			var low = max(1, floor(level * 0.45));
			low = round(low * rarFactor);
			var high = low + 4;
			amount = irandom_range_biased(low, high, LOOT_BIAS);
		}
		
		//set stats
		if (key != undefined and amount != 0) {
			scr_loot_addStat(coat, key, amount);
		}
		
	}
	
}

function scr_genCoats_addSpecificElementResistance(coat, level, rarity) {
	
	var spr = spr_coat;
	var adj = "";
			
	var el = scr_gear_getHighestEffectiveResistanceType(coat, true);
	var elKey = el.key;
			
	var minBonus = floor(max(2, level * 0.5));
	var maxBonus = minBonus + 4;
	var bon = irandom_range(minBonus, maxBonus); // lol bon
			
	switch(elKey) {

		case "kin":
			spr = spr_coatKin;
			adj = "Padded ";
			scr_loot_addStat(coat, "kinRes", bon);
			break;

		case "fire":
			spr = spr_coatFire;
			adj = "Fire-retardant ";
			scr_loot_addStat(coat, "fireRes", bon);
			break;

		case "chem":
			spr = spr_coatChem;
			adj = "Fluoropolymer ";
			scr_loot_addStat(coat, "chemRes", bon);
			break;

		case "elec":
			spr = spr_coatElec;
			adj = "Insulated ";
			scr_loot_addStat(coat, "elecRes", bon);
			break;

		case "rad":
			spr = spr_coatRad;
			adj = "Lead-lined ";
			scr_loot_addStat(coat, "radRes", bon);
			break;

	}
			
	coat.spr = spr;
	coat.name = adj + "Coat";
		
	
	
}

function scr_genCoats_generic(level, rarity) {

	var coat = new coatInst(level, rarity);
	
	scr_genCoats_addBasicStats(coat, level, rarity);
	scr_genCoats_addRarityBonuses(coat, level, rarity);
	
	var chance = 5 + rarity * 5 + floor(level * 0.33);
	chance = min(chance, 55);
		
	if (level > 3 and scr_random_chance(chance)) scr_genCoats_addSpecificElementResistance(coat, level, rarity);
	
	return coat;

}

//SPECIAL
function scr_genCoats_exoskeleton(level, rarity) {

	var coat = new coatInst(level, rarity);
	var stats = coat.stats;
	
	coat.spr = spr_coatExo;
	coat.name = "Exoskeleton";
	
	stats.spd = -1;
	
	scr_genCoats_addBasicStats(coat, level, rarity);
	scr_genCoats_addRarityBonuses(coat, level, rarity);
	
	var rarBonus = min(rarity * rarity, level * 4);
	var minBonus = max(1, floor(level * 0.45)) + rarBonus;
	var maxBonus = minBonus + 6;
	
	stats.meleeRes = irandom_range_biased(minBonus, maxBonus, LOOT_BIAS);
	stats.projRes = irandom_range_biased(minBonus, maxBonus, LOOT_BIAS);
	
	return coat;
	
}

function scr_genCoats_reflexCoat(level, rarity) {
	
	var coat = new coatInst(level, rarity);
	var stats = coat.stats;
	
	coat.spr = spr_coatReflex;
	coat.name = "Reflex Coat";
	
	stats.spd = 0.5;
	
	scr_genCoats_addBasicStats(coat, level, rarity);
	scr_genCoats_addRarityBonuses(coat, level, rarity);

	var rarBonus = min(rarity * rarity, level * 4);
	var minBonus = max(1, floor(level * 0.6)) + rarBonus + 6;
	var maxBonus = minBonus + rarity + 8;
	
	var amount = irandom_range_biased(minBonus, maxBonus, LOOT_BIAS);
	
	scr_loot_addStat(coat, "da", amount);
	
	var chance = 0;
	if (rarity > 2) chance = level + rarity * 10;
	
	if (scr_random_chance(chance)) {
	
		var amounts = [0.03, 0.06, 0.09, 0.12, 0.15];
		amount = scr_randomElementProgressive(amounts, chance, 5);
		
		scr_loot_addStat(coat, "dashRegen", amount);

	}
	
	return coat;
	
}

function scr_genCoats_barrierCoat(level, rarity) {

	var coat = new coatInst(level, rarity);
	var stats = coat.stats;
	
	coat.spr = spr_coatBarrier;
	coat.name = "Barrier Coat";
	
	stats.maxShield = 1;
	
	scr_genCoats_addBasicStats(coat, level, rarity);
	
	if (rarity > 1) {

		var regen = 0;
		var delay = 0;
		
		repeat(rarity - 1) {
			
			var stat = choose("regen", "delay");
			
			if (stat == "regen") {
			
				regen += 0.05 * (rarity - 1);
			
			}
			
			if (stat == "delay") {
			
				delay -= 0.01 * (rarity - 1);
			
			}
	
		}
	
		if (regen != 0) scr_loot_addStat(coat, "shieldRegen", regen);
		if (delay != 0) scr_loot_addStat(coat, "shieldRegenDelay", delay);
		
	}
	
	if (rarity >= 4) {
	
		var chance = rarity * rarity * 3;
		
		if (scr_random_chance(chance)) {
			
			stats.maxShield ++;
		
			chance *= 0.4;
		
			if (scr_random_chance(chance)) stats.maxShield ++;
		
		}
		
	}
	
	return coat;
	
}

function scr_genCoats_batteryCoat(level, rarity) {

	var coat = new coatInst(level, rarity);
	var stats = coat.stats;
	
	coat.spr = spr_coatBattery;
	coat.name = "Capacitor Coat";
	
	stats.energyRegen = 0.5;
	
	scr_genCoats_addBasicStats(coat, level, rarity);
	scr_genCoats_addRarityBonuses(coat, level, rarity);
	
	if (level > 2) {
		
		var regen = 0;
		var packRegen = 0;

		repeat(rarity) {
		
			var stat = choose("regen", "packRegen");
		
			if (stat == "regen") {
		
				regen += 0.1 * (rarity);
		
			}
		
			if (stat == "packRegen") {
		
				packRegen += 0.01 * (rarity);
		
			}

		}

		if (regen != 0) scr_loot_addStat(coat, "energyRegen", regen);
		if (packRegen != 0) scr_loot_addStat(coat, "energyPackRegen", packRegen);
		
	}
	
	return coat;
	
}

function scr_genCoats_doctorsCoat(level, rarity) {

	var coat = new coatInst(level, rarity);
	var stats = coat.stats;
	
	coat.spr = spr_coatDoctor;
	coat.name = "Doctor's Coat";
	
	stats.hpRegen = 1;
	
	scr_genCoats_addBasicStats(coat, level, rarity);
	scr_genCoats_addRarityBonuses(coat, level, rarity);
	
	if (level > 2) {
		
		var regen = 0;
		var packRegen = 0;
	
		repeat(rarity) {
		
			var stat = choose("regen", "packRegen");
		
			if (stat == "regen") {
		
				regen += 0.2 * (rarity);
		
			}
		
			if (stat == "packRegen") {
		
				packRegen += 0.01 * (rarity);
		
			}

		}

		if (regen != 0) scr_loot_addStat(coat, "hpRegen", regen);
		if (packRegen != 0) scr_loot_addStat(coat, "stimPackRegen", packRegen);
		
	}
	
	return coat;
	
}