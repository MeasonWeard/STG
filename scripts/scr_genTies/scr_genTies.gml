#region//GENERIC
function scr_genTies_physics(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Physicist's Tie";
	var stats = tie.stats;
	
	var keys = ["kinDamPerc","radDamPerc","maxEnergyPerc","energyRegen","energyRegenPerc","shieldRegen","shieldRegenDelay"];
	keys = array_concat(keys, keys);
	
	var low = 2 * level;
	var high = 6 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 14 * level;
	high = 18 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "kinDamPerc" or key == "radDamPerc") {
			
			low = level;
			high = low + 8;
			
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
	
	var low = 6 * level;
	var high = 10 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 10 * level;
	high = 14 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "chemDamPerc" or key == "fireDamPerc") {
			
			low = level;
			high = low + 8;
			
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
	
	var low = 11 * level;
	var high = 15 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 5 * level;
	high = 9 * level;
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
			
			low = level + 2;
			high = low + 10;
			
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
	
	var low = 6 * level;
	var high = 10 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 10 * level;
	high = 14 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "elecDamPerc") {
			
			low = level;
			high = low + 8;
			
		}
		
		if (key == "kinDamPerc") {
			
			low = level;
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
			
			low = level + 2;
			high = low + 10;
			
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

function scr_genTies_defender(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Defender's Tie";
	
	var stats = tie.stats;
	
	var keys = ["maxHp","maxHpPerc","hpRegen","hpRegenPerc","meleeDamPerc","da"];
	keys = array_concat(keys, keys);
	
	var low = 14 * level;
	var high = 18 * level;
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
			
			low = max(1, level) * 5;
			high = low + 10;
			
		}
		
		if (key == "maxHpPerc") {
			
			low = max(1, level);
			high = low + 8;
			
		}
		
		if (key == "hpRegen") {
			
			low = max(1, level) * 0.1;
			high = low + .2;
			integer = false;
			
		}
		
		if (key == "hpRegenPerc") {
			
			low = max(1, level);
			high = low + 8;
			
		}
			
		if (key == "meleeDamPerc") {
			
			low = level;
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

function scr_genTies_marksman(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Marksman's Tie";
	
	var stats = tie.stats;
	
	var keys = ["kinRes","kinDam","kinDamPerc","gunDamPerc","oa"];
	keys = array_concat(keys, keys);
	
	var low = 7 * level;
	var high = 11 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 7 * level;
	high = 11 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = level * 2;
	high = low + 8;
	stats.gunDamPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 2 + level * 3;
	high = low + 10;	
	stats.oa = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "kinRes") {
			
			low = max(1, level * 0.6);
			high = low + 4;
			
		}
		
		if (key == "kinDam") {
			
			low = max(1, level * 0.4);
			high = low + 4;
			
		}
		
		if (key == "kinDamPerc") {
			
			low = max(1, level);
			high = low + 6;
			
		}
		
		if (key == "gunDamPerc") {
			
			low = level;
			high = low + 8;
			
		}
		
		if (key == "oa") {
			
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

function scr_genTies_doctor(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Doctor's Tie";
	
	var stats = tie.stats;
	
	var keys = ["maxHp","maxHpPerc","hpRegen","hpRegenPerc","healingPerc"];
	keys = array_concat(keys, keys);
	
	var low = 12 * level;
	var high = 16 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 4 * level;
	high = 8 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.maxStimPacks = 1;
	
	low = 2 + level;
	high = low + 4;
	stats.healingPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	var rollNum = 0;
	
	repeat(rarity - 1) {
			
		rollNum ++;
		
		if (rarity > 3 and rollNum == rarity - 1) {

			if (scr_random_chance(rarity - 1)) {
				stats.maxStimPacks++;
				break;
			}

		}
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "maxHp") {
			
			low = max(1, level) * 5;
			high = low + 10;
			
		}
		
		if (key == "maxHpPerc") {
			
			low = max(1, level);
			high = low + 8;
			
		}
		
		if (key == "hpRegen") {
			
			low = max(1, level) * 0.1;
			high = low + .2;
			integer = false;
			
		}
		
		if (key == "hpRegenPerc") {
			
			low = max(1, level);
			high = low + 8;
			
		}
		
		if (key == "healingPerc") {
			
			low = max(1, level * 0.5);
			high = low + 4;
			
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

function scr_genTies_athlete(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Athlete's Tie";
	
	var stats = tie.stats;
	
	var keys = ["maxHp","hpRegen","da","dashRegen","spd"];
	keys = array_concat(keys, keys);
	
	var low = 12 * level;
	var high = 18 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 2 * level;
	high = 6 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.maxDashes = 1;
	
	low = 0.4 + level * 0.01;
	high = low + .05;
	stats.spd = irandom_range_biased(low, high, LOOT_BIAS);
	
	var rollNum = 0;
	
	repeat(rarity - 1) {
			
		rollNum ++;
		
		if (rarity > 3 and rollNum == rarity - 1) {

			if (scr_random_chance(rarity - 1)) {
				stats.maxStimPacks++;
				break;
			}

		}
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "maxHp") {
			
			low = max(1, level) * 5;
			high = low + 10;
			
		}
			
		if (key == "hpRegen") {
			
			low = max(1, level) * 0.1;
			high = low + .2;
			integer = false;
			
		}
		
		if (key == "dashRegen") {
			
			low = level * 0.01;
			high = low + 0.05;
			integer = false;
			
		}
		
		if (key == "spd") {
			
			low = level * 0.01;
			high = low + 0.05;
			integer = false;
			
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

function scr_genTies_pyromaniac(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Pyromaniac's Tie";
	
	var stats = tie.stats;
	
	var keys = ["fireDam","fireDamPerc","fireRes","fireResPerc"];
	keys = array_concat(keys, keys);
	array_push(keys, "elecDamPerc", "radDamPerc");
	
	var low = 5 * level;
	var high = 9 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * level;
	high = 15 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = level * 2;
	high = low + 8;
	stats.fireDamPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = max(1, level * 0.3);
	high = low + 3;
	stats.fireDam = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "fireDam") {
			
			low = max(1, level * 0.3);
			high = low + 4;
			
		}
		
		if (key == "fireDamPerc" or key == "elecDamPerc" or key == "radDamPerc") {
			
			low = level;
			high = low + 8;
			
		}
		
		if (key == "fireRes") {
			
			low = max(1, level * 0.6);
			high = low + 4;
			
		}
		
		if (key == "fireResPerc") {
			
			low = level + 2;
			high = low + 8;
			
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

function scr_genTies_ballistician(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Ballistician's Tie";
	
	var stats = tie.stats;
	
	var keys = ["kinDam","kinDamPerc","kinRes","kinResPerc"];
	keys = array_concat(keys, keys);
	array_push(keys, "chemDamPerc", "fireDamPerc");
	
	var low = 5 * level;
	var high = 9 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * level;
	high = 15 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = level * 2;
	high = low + 8;
	stats.kinDamPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = max(1, level * 0.3);
	high = low + 3;
	stats.kinDam = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "kinDam") {
			
			low = max(1, level * 0.3);
			high = low + 4;
			
		}
		
		if (key == "kinDamPerc" or key == "chemDamPerc" or key == "fireDamPerc") {
			
			low = level;
			high = low + 8;
			
		}
		
		if (key == "kinRes") {
			
			low = max(1, level * 0.6);
			high = low + 4;
			
		}
		
		if (key == "kinResPerc") {
			
			low = level + 2;
			high = low + 8;
			
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

function scr_genTies_toxicologist(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Toxicologist's Tie";
	
	var stats = tie.stats;
	
	var keys = ["chemDam","chemDamPerc","chemRes","chemResPerc"];
	keys = array_concat(keys, keys);
	array_push(keys, "fireDamPerc", "elecDamPerc");
	
	var low = 5 * level;
	var high = 9 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * level;
	high = 15 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = level * 2;
	high = low + 8;
	stats.chemDamPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = max(1, level * 0.3);
	high = low + 3;
	stats.chemDam = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "chemDam") {
			
			low = max(1, level * 0.3);
			high = low + 4;
			
		}
		
		if (key == "chemDamPerc" or key == "fireDamPerc" or key == "elecDamPerc") {
			
			low = level;
			high = low + 8;
			
		}
		
		if (key == "chemRes") {
			
			low = max(1, level * 0.6);
			high = low + 4;
			
		}
		
		if (key == "chemResPerc") {
			
			low = level + 2;
			high = low + 8;
			
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

function scr_genTies_electromaniac(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Electromaniac's Tie";
	
	var stats = tie.stats;
	
	var keys = ["elecDam","elecDamPerc","elecRes","elecResPerc"];
	keys = array_concat(keys, keys);
	array_push(keys, "radDamPerc", "kinDamPerc");
	
	var low = 5 * level;
	var high = 9 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * level;
	high = 15 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = level * 2;
	high = low + 8;
	stats.elecDamPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = max(1, level * 0.3);
	high = low + 3;
	stats.elecDam = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "elecDam") {
			
			low = max(1, level * 0.3);
			high = low + 4;
			
		}
		
		if (key == "elecDamPerc" or key == "radDamPerc" or key == "kinDamPerc") {
			
			low = level;
			high = low + 8;
			
		}
		
		if (key == "elecRes") {
			
			low = max(1, level * 0.6);
			high = low + 4;
			
		}
		
		if (key == "elecResPerc") {
			
			low = level + 2;
			high = low + 8;
			
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

function scr_genTies_radiologist(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Radiologist's Tie";
	
	var stats = tie.stats;
	
	var keys = ["radDam","radDamPerc","radRes","radResPerc"];
	keys = array_concat(keys, keys);
	array_push(keys, "kinDamPerc", "chemDamPerc");
	
	var low = 5 * level;
	var high = 9 * level;
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * level;
	high = 15 * level;
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = level * 2;
	high = low + 8;
	stats.radDamPerc = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = max(1, level * 0.3);
	high = low + 3;
	stats.radDam = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		low = 1;
		high = 2;
		var amount = 0;
		var integer = true;
		
		if (key == "radDam") {
			
			low = max(1, level * 0.3);
			high = low + 4;
			
		}
		
		if (key == "radDamPerc" or key == "kinDamPerc" or key == "chemDamPerc") {
			
			low = level;
			high = low + 8;
			
		}
		
		if (key == "radRes") {
			
			low = max(1, level * 0.6);
			high = low + 4;
			
		}
		
		if (key == "radResPerc") {
			
			low = level + 2;
			high = low + 8;
			
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