#region//GENERIC
function scr_genTies_physics(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Physicist's Tie";
	var stats = tie.stats;
	
	var keys = ["kinDamPerc","radDamPerc","maxEnergyPerc","energyRegen","energyRegenPerc","shieldRegen","shieldRegenDelay"];
	keys = array_concat(keys, keys);
	
	var low = 2 * level;
	var high = 8 * level;
	
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 10 * level;
	high = 20 * level;
	
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "kinDamPerc" or key == "radDamPerc") {
			
			low = level * 2;
			high = low + 10;
			
		}
		
		if (key == "maxEnergyPerc") {
			
			low = level * 4;
			high = low + 10;
			
		}
		
		if (key == "energyRegen") {
			
			low = level * 0.1;
			high = low + .2;
			integer = false;
			
		}
		
		if (key == "energyRegenPerc") {
			
			low = level * 4;
			high = low + 8;
			
		}
		
		if (key == "shieldRegen") {
			
			low = level * 0.05;
			high = low + .1;
			integer = false;
			
		}
		
		if (key == "shieldRegenDelay") {
			
			low = level * -0.015;
			high = low - .1;
			integer = false;
			
		}
	
	
		if (integer) {
			amount = irandom_range_biased(low, high, LOOT_BIAS, true);
		} else {
			amount = random_range_biased(low, high, LOOT_BIAS, true, 3);
		}
	
		if (amount > 0) scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_chemistry(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Chemist's Tie";
	var stats = tie.stats;
	
	var keys = ["chemDamPerc","fireDamPerc","energyRegen","maxHp","maxHpPerc","stimPackRegen"];
	keys = array_concat(keys, keys);
	
	var low = 12 * level;
	var high = 15 * level;

	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 5 * level;
	high = 10 * level;
	
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "chemDamPerc" or key == "fireDamPerc") {
			
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
		
		if (key == "maxHp") {
			
			low = level * 4;
			high = low + 10;
			
		}
		
		if (key == "maxHpPerc") {
			
			low = level * 2;
			high = low + 8;
			
		}
		
		if (key == "stimPackRegen") {
			
			low = level * 0.01;
			high = low + 0.05;
			integer = false;
			
		}
	
	
		if (integer) {
			amount = irandom_range_biased(low, high, LOOT_BIAS, true);
		} else {
			amount = random_range_biased(low, high, LOOT_BIAS, true, 3);
		}
	
		if (amount > 0) scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_biology(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Biologist's Tie";
	var stats = tie.stats;
	
	var keys = ["maxHp","maxHpPerc","hpRegen","hpRegenPerc","healingPerc","meleeDamPerc","da"];
	keys = array_concat(keys, keys);
	
	var low = 10 * level;
	var high = 15 * level;
	
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 2 * level;
	high = 8 * level;
	
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "maxHp") {
			
			low = level * 5;
			high = low + 10;
			
		}
		
		if (key == "maxHpPerc") {
			
			low = level * 4;
			high = low + 10;
			
		}
		
		if (key == "hpRegen") {
			
			low = level * 0.1;
			high = low + .2;
			integer = false;
			
		}
		
		if (key == "hpRegenPerc") {
			
			low = level * 4;
			high = low + 8;
			
		}
		
		if (key == "healingPerc") {
			
			low = level * 4;
			high = low + 8;
			
		}
		
		if (key == "meleeDamPerc") {
			
			low = level * 2;
			high = low + 8;
			
		}
		
		if (key == "da") {
			
			low = 2 + level * 3;
			high = low + 10;
			
		}
	
		if (integer) {
			amount = irandom_range_biased(low, high, LOOT_BIAS, true);
		} else {
			amount = random_range_biased(low, high, LOOT_BIAS, true, 3);
		}
	
		if (amount > 0) scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_engineering(level, rarity) {

	var tie = new tieInst(level, rarity);
	var stats = tie.stats;
	tie.name = "Engineer's Tie";
	
	var keys = ["elecDamPerc","kinDamPerc","energyRegenPerc","energyPackRegen","gunDamPerc","oa"];
	
	keys = array_concat(keys, keys);
	
	//only one copy of speed
	array_push(keys, "spd");
	
	var low = 5 * level;
	var high = 10 * level;
	
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 12 * level;
	high = 15 * level;
	
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "elecDamPerc") {
			
			low = level * 2;
			high = low + 12;
			
		}
		
		if (key == "kinDamPerc") {
			
			low = level * 2;
			high = low + 8;
			
		}
		
		if (key == "energyRegenPerc") {
			
			low = level * 4;
			high = low + 8;
			
		}
		
		if (key == "energyPackRegen") {
			
			low = level * 0.01;
			high = low + 0.05;
			integer = false;
			
		}
		
		if (key == "gunDamPerc") {
			
			low = level * 2;
			high = low + 8;
			
		}
		
		if (key == "oa") {
			
			low = 2 + level * 3;
			high = low + 10;
			
		}
		
		if (key == "spd") {
			
			low = 0.1;
			high = min(1.1, low + 0.05 * level);
			integer = false;
			
		}
	
		if (integer) {
			amount = irandom_range_biased(low, high, LOOT_BIAS, true);
		} else {
			amount = random_range_biased(low, high, LOOT_BIAS, true, 3);
		}
	
		if (amount > 0) scr_loot_addStat(tie, key, amount);
	
	}
		
	return tie;
	
}
#endregion

#region//SPECIAL
function scr_genTies_defenderTie(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Defender's Tie";
	
	var stats = tie.stats;
	
	var keys = ["maxHp","maxHpPerc","maxHpPerc","meleeDamPerc","meleeDamPerc","da","da"];
	keys = array_concat(keys, keys);
	
	var low = 11 * level;
	var high = 16 * level;
	
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 2 * level;
	high = 6 * level;
	
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = level * 2;
	high = low + 8;
	
	stats.meleeDamPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 2 + level * 3;
	high = low + 10;
			
	stats.da = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "maxHp") {
			
			low = level * 5;
			high = low + 10;
			
		}
		
		if (key == "maxHpPerc") {
			
			low = level * 4;
			high = low + 10;
			
		}
		
		if (key == "hpRegen") {
			
			low = level * 0.1;
			high = low + .2;
			integer = false;
			
		}
		
		if (key == "hpRegenPerc") {
			
			low = level * 4;
			high = low + 8;
			
		}
		
		if (key == "healingPerc") {
			
			low = level * 4;
			high = low + 8;
			
		}
		
		if (key == "meleeDamPerc") {
			
			low = level * 2;
			high = low + 8;
			
		}
		
		if (key == "da") {
			
			low = 2 + level * 3;
			high = low + 10;
			
		}
	
		if (integer) {
			amount = irandom_range_biased(low, high, LOOT_BIAS, true);
		} else {
			amount = random_range_biased(low, high, LOOT_BIAS, true, 3);
		}
	
		if (amount > 0) scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}


#endregion