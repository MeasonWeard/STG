#region//GENERIC
function scr_genTies_physics(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Physicist's Tie";
	var stats = tie.stats;
	
	var keys = ["kinDamPerc","radDamPerc","maxEnergyPerc","energyRegen","energyRegenPerc","shieldRegen","shieldRegenDelay"];
	keys = array_concat(keys, keys);
	
	var low = 2 * max(0.5, level);
	var high = 6 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 14 * max(0.5, level);
	high = 18 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "kinDamPerc" or key == "radDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "maxEnergyPerc") {
			amount = scr_statRolls_maxEnergyPerc(level);
		}
		
		if (key == "energyRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "energyRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "shieldRegen") {
			amount = scr_statRolls_shieldRegen(level);
		}
		
		if (key == "shieldRegenDelay") {
			amount = scr_statRolls_shieldRegenDelay(level);	
		}
	
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_chemistry(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Chemist's Tie";
	var stats = tie.stats;
	
	var keys = ["chemDamPerc", "fireDamPerc", "energyRegen", "maxHp","maxHpPerc", "stimPackRegen", "chemRes"];
	keys = array_concat(keys, keys);
	
	var low = 6 * max(0.5, level);
	var high = 10 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 10 * max(0.5, level);
	high = 14 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "chemDamPerc" or key == "fireDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "chemRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "energyRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level);
		}
		
		if (key == "stimPackRegen") {
			amount = scr_statRolls_packRegen(level);
		}
	
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_biology(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Biologist's Tie";
	var stats = tie.stats;
	
	var keys = ["maxHp","maxHpPerc","hpRegen","hpRegenPerc","healingPerc","meleeDamPerc","da"];
	keys = array_concat(keys, keys);
	
	var low = 11 * max(0.5, level);
	var high = 15 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 5 * max(0.5, level);
	high = 9 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level);
		}
		
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "healingPerc") {
			amount = scr_statRolls_healingPerc(level);
		}
		
		if (key == "meleeDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "da") {
			amount = scr_statRolls_combatAbility(level);
		}
	
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
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
	
	var low = 6 * max(0.5, level);
	var high = 10 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 10 * max(0.5, level);
	high = 14 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "elecDamPerc" or key == "kinDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "energyRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "energyPackRegen") {
			amount = scr_statRolls_packRegen(level);
		}
		
		if (key == "gunDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "oa") {
			amount = scr_statRolls_combatAbility(level);
		}
		
		if (key == "spd") {
			amount = scr_statRolls_speed(level);
		}
	
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
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
	
	var low = 14 * max(0.5, level);
	var high = 18 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 2 * max(0.5, level);
	high = 6 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.meleeDamPerc = scr_statRolls_damagePerc(level, 1.5);
	
	stats.da = scr_statRolls_combatAbility(level, 1.5);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level);
		}
		
		if (key == "maxHpPerc") {
			amount = scr_statRolls_maxHpPerc(level);
		}
		
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
			
		if (key == "meleeDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "da") {
			amount = scr_statRolls_combatAbility(level);
		}
	
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_marksman(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Marksman's Tie";
	
	var stats = tie.stats;
	
	var keys = ["kinRes","kinDam","kinDamPerc","gunDamPerc","oa"];
	keys = array_concat(keys, keys);
	
	var low = 7 * max(0.5, level);
	var high = 11 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 7 * max(0.5, level);
	high = 11 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.gunDamPerc = scr_statRolls_damagePerc(level, 1.5);
	
	stats.oa = scr_statRolls_combatAbility(level, 1.5);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "kinRes") {
			amount = scr_statRolls_resistance(level);	
		}
		
		if (key == "kinDam") {
			amount = scr_statRolls_damage(level);
		}
		
		if (key == "kinDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "gunDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "oa") {
			amount = scr_statRolls_combatAbility(level);
		}
	
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_doctor(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Doctor's Tie";
	
	var stats = tie.stats;
	
	var keys = ["maxHp","maxHpPerc","hpRegen","hpRegenPerc","healingPerc"];
	keys = array_concat(keys, keys);
	
	var low = 12 * max(0.5, level);
	var high = 16 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 4 * max(0.5, level);
	high = 8 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.maxStimPacks = 1;
	
	stats.healingPerc = scr_statRolls_healingPerc(level, 1.5);
	
	var rollNum = 0;
	
	repeat(rarity - 1) {
			
		rollNum ++;
		
		if (rarity > 3 and rollNum == rarity) {

			if (scr_random_chance(rarity - 1)) {
				stats.maxStimPacks++;
				break;
			}

		}
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level);
		}
		
		if (key == "maxHpPerc") {	
			amount = scr_statRolls_maxHpPerc(level);	
		}
		
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level);	
		}
		
		if (key == "hpRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "healingPerc") {
			amount = scr_statRolls_healingPerc(level);
		}
			
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_athlete(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Athlete's Tie";
	
	var stats = tie.stats;
	
	var keys = ["maxHp","hpRegen","da","dashRegen","spd"];
	keys = array_concat(keys, keys);
	
	var low = 12 * max(0.5, level);
	var high = 18 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 2 * max(0.5, level);
	high = 6 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.maxDashes = 1;
	
	stats.spd = scr_statRolls_speed(level, 1.2);
	
	var rollNum = 0;
	
	repeat(rarity - 1) {
			
		rollNum ++;
		
		if (rarity > 3 and rollNum == rarity - 1) {

			if (scr_random_chance(rarity - 1)) {
				stats.maxDashes++;
				break;
			}

		}
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		if (key == "maxHp") {
			amount = scr_statRolls_maxHp(level);
		}
			
		if (key == "hpRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "dashRegen") {
			
			amount = scr_statRolls_dashRegen(level);
			
		}
		
		if (key == "spd") {
			amount = scr_statRolls_speed(level);
		}
		
		if (key == "da") {
			amount = scr_statRolls_combatAbility(level);
		}

		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}

function scr_genTies_inventor(level, rarity) {

	var tie = new tieInst(level, rarity);
	tie.name = "Inventor's Tie";
	var stats = tie.stats;
	
	var keys = ["maxEnergyPerc","energyRegen","energyRegenPerc","shieldRegen","shieldRegenDelay","gunDamPerc"];
	keys = array_concat(keys, keys);
	
	if (rarity > 2) array_push(keys, "maxShield");
	
	var low = 2 * max(0.5, level);
	var high = 6 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 14 * max(0.5, level);
	high = 18 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.maxEnergyPacks = 1;
	
	var rollNum = 0;
	
	repeat(rarity) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;
		
		rollNum ++;
		
		if (rarity > 3 and rollNum == rarity) {

			if (scr_random_chance(rarity - 1)) {
				stats.maxEnergyPacks++;
				break;
			}

		}

		if (key == "maxEnergyPerc") {
			amount = scr_statRolls_maxEnergyPerc(level);
		}
		
		if (key == "energyRegen") {
			amount = scr_statRolls_regen(level);
		}
		
		if (key == "energyRegenPerc") {
			amount = scr_statRolls_regenPerc(level);
		}
		
		if (key == "shieldRegen") {
			amount = scr_statRolls_shieldRegen(level);
		}
		
		if (key == "shieldRegenDelay") {
			amount = scr_statRolls_shieldRegenDelay(level);	
		}
		
		if (key == "gunDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "maxShield") {
			amount = 1;	
		}
	
		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
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
	
	var low = 5 * max(0.5, level);
	var high = 9 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * max(0.5, level);
	high = 15 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.fireDamPerc = scr_statRolls_damagePerc(level, 1.5);
	stats.fireDam =  scr_statRolls_damage(level, 1.5);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "fireDam") {
			amount = scr_statRolls_damage(level);
		}
		
		if (key == "fireDamPerc" or key == "elecDamPerc" or key == "radDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "fireRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "fireResPerc") {
			amount = scr_statRolls_resistancePerc(level);
		}

		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
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
	
	var low = 5 * max(0.5, level);
	var high = 9 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * max(0.5, level);
	high = 15 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.kinDamPerc = scr_statRolls_damagePerc(level, 1.5);
	stats.kinDam =  scr_statRolls_damage(level, 1.5);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "kinDam") {
			amount = scr_statRolls_damage(level);
		}
		
		if (key == "kinDamPerc" or key == "chemDamPerc" or key == "fireDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "kinRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "kinResPerc") {
			amount = scr_statRolls_resistancePerc(level);
		}

		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
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
	
	var low = 5 * max(0.5, level);
	var high = 9 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * max(0.5, level);
	high = 15 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.chemDamPerc = scr_statRolls_damagePerc(level, 1.5);
	stats.chemDam =  scr_statRolls_damage(level, 1.5);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "chemDam") {
			amount = scr_statRolls_damage(level);
		}
		
		if (key == "chemDamPerc" or key == "fireDamPerc" or key == "elecDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "chemRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "chemResPerc") {
			amount = scr_statRolls_resistancePerc(level);
		}

		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
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
	
	var low = 5 * max(0.5, level);
	var high = 9 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * max(0.5, level);
	high = 15 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.elecDamPerc = scr_statRolls_damagePerc(level, 1.5);
	stats.elecDam =  scr_statRolls_damage(level, 1.5);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "elecDam") {
			amount = scr_statRolls_damage(level);
		}
		
		if (key == "elecDamPerc" or key == "radDamPerc" or key == "kinDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "elecRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "elecResPerc") {
			amount = scr_statRolls_resistancePerc(level);
		}

		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
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
	
	var low = 5 * max(0.5, level);
	var high = 9 * max(0.5, level);
	stats.maxHp = irandom_range_biased(low, high, LOOT_BIAS);
	
	low = 11 * max(0.5, level);
	high = 15 * max(0.5, level);
	stats.maxEnergy = irandom_range_biased(low, high, LOOT_BIAS);
	
	stats.radDamPerc = scr_statRolls_damagePerc(level, 1.5);
	stats.radDam =  scr_statRolls_damage(level, 1.5);
	
	repeat(rarity - 1) {
	
		var key = scr_randomElementRemove(keys);
		var amount = 0;

		if (key == "radDam") {
			amount = scr_statRolls_damage(level);
		}
		
		if (key == "radDamPerc" or key == "kinDamPerc" or key == "chemDamPerc") {
			amount = scr_statRolls_damagePerc(level);
		}
		
		if (key == "radRes") {
			amount = scr_statRolls_resistance(level);
		}
		
		if (key == "radResPerc") {
			amount = scr_statRolls_resistancePerc(level);
		}

		if (amount != 0)  scr_loot_addStat(tie, key, amount);
	
	}
	
	return tie;
	
}
	
#endregion