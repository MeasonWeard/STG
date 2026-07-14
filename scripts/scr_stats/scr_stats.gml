function scr_stats_calculateStat(flat, perc) {

	var dec = perc * 0.01;
	var add = dec * flat;
	
	return flat + add;
	
}

function scr_stats_calculateDamageRange(dam) {

	if (dam < 1) return {
		minDam: 0,
		maxDam: 0
	};

	var minDam = floor(dam * 0.8);
	var maxDam = ceil(dam * 1.2);
	
	return {
		minDam: minDam,
		maxDam: maxDam
	}
	
}

function scr_stats_applyDamageBonuses(char, amount, element) {

	var percKey = element + "DamPerc";
	var damKey = element + "Dam";
	
	if (!variable_struct_exists(char.stats, percKey)) return amount;
	if (!variable_struct_exists(char.finalStats, damKey)) return amount;

	var perc = char.stats[$ percKey];
	var dam = char.finalStats[$ damKey];
	
	return scr_stats_calculateStat(amount, perc) + dam;

}

function scr_stats_calculateDamageProfileWeapon(char, profile) {

	var newStats = {};
	
	scr_data_structCopyInto(newStats, profile);
	
	newStats.damage.kin = scr_stats_applyDamageBonuses(char, newStats.damage.kin, "kin"); //scr_stats_calculateStat(newStats.damage.kin, char.stats.kinDamPerc) + char.finalStats.kinDam;
	newStats.damage.fire = scr_stats_applyDamageBonuses(char, newStats.damage.fire, "fire");//scr_stats_calculateStat(newStats.damage.fire, char.stats.fireDamPerc) + char.finalStats.fireDam;
	newStats.damage.chem = scr_stats_applyDamageBonuses(char, newStats.damage.chem, "chem");// scr_stats_calculateStat(newStats.damage.chem, char.stats.chemDamPerc) + char.finalStats.chemDam;
	newStats.damage.elec = scr_stats_applyDamageBonuses(char, newStats.damage.elec, "elec");// scr_stats_calculateStat(newStats.damage.elec, char.stats.elecDamPerc) + char.finalStats.elecDam;
	newStats.damage.rad = scr_stats_applyDamageBonuses(char, newStats.damage.rad, "rad");// scr_stats_calculateStat(newStats.damage.rad, char.stats.radDamPerc) + char.finalStats.radDam;
	
	var range = scr_stats_calculateDamageRange(newStats.damage.kin);
	newStats.damage.kinMin = range.minDam;
	newStats.damage.kinMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.fire);
	newStats.damage.fireMin = range.minDam;
	newStats.damage.fireMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.chem);
	newStats.damage.chemMin = range.minDam;
	newStats.damage.chemMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.elec);
	newStats.damage.elecMin = range.minDam;
	newStats.damage.elecMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.rad);
	newStats.damage.radMin = range.minDam;
	newStats.damage.radMax = range.maxDam;
	
	return newStats;
	
}

function scr_stats_calculateDamageProfile(char, profile, applyBonuses) {

	var newStats = {};
	
	scr_data_structCopyInto(newStats, profile);
	
	if (applyBonuses) {
		
		newStats.kin = scr_stats_applyDamageBonuses(char, newStats.kin, "kin"); //scr_stats_calculateStat(newStats.kin, char.stats.kinDamPerc) + char.finalStats.kinDam;
		newStats.fire = scr_stats_applyDamageBonuses(char, newStats.fire, "fire");//scr_stats_calculateStat(newStats.fire, char.stats.fireDamPerc) + char.finalStats.fireDam;
		newStats.chem = scr_stats_applyDamageBonuses(char, newStats.chem, "chem");//scr_stats_calculateStat(newStats.chem, char.stats.chemDamPerc) + char.finalStats.chemDam;
		newStats.elec = scr_stats_applyDamageBonuses(char, newStats.elec, "elec");//scr_stats_calculateStat(newStats.elec, char.stats.elecDamPerc) + char.finalStats.elecDam;
		newStats.rad = scr_stats_applyDamageBonuses(char, newStats.rad, "rad");//scr_stats_calculateStat(newStats.rad, char.stats.radDamPerc) + char.finalStats.radDam;
		
	}
	
	var range = scr_stats_calculateDamageRange(newStats.kin);
	newStats.kinMin = range.minDam;
	newStats.kinMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.fire);
	newStats.fireMin = range.minDam;
	newStats.fireMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.chem);
	newStats.chemMin = range.minDam;
	newStats.chemMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.elec);
	newStats.elecMin = range.minDam;
	newStats.elecMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.rad);
	newStats.radMin = range.minDam;
	newStats.radMax = range.maxDam;
	
	return newStats;
	
}

function scr_stats_multiplyDamageProfile(profile, mult) {

	var newDamage = new damageProfile();

	if (!is_struct(profile)) return newDamage;

	newDamage.kin    = round(profile.kin    * mult);
	newDamage.kinMin = round(profile.kinMin * mult);
	newDamage.kinMax = round(profile.kinMax * mult);

	newDamage.fire    = round(profile.fire    * mult);
	newDamage.fireMin = round(profile.fireMin * mult);
	newDamage.fireMax = round(profile.fireMax * mult);

	newDamage.chem    = round(profile.chem    * mult);
	newDamage.chemMin = round(profile.chemMin * mult);
	newDamage.chemMax = round(profile.chemMax * mult);

	newDamage.elec    = round(profile.elec    * mult);
	newDamage.elecMin = round(profile.elecMin * mult);
	newDamage.elecMax = round(profile.elecMax * mult);

	newDamage.rad    = round(profile.rad    * mult);
	newDamage.radMin = round(profile.radMin * mult);
	newDamage.radMax = round(profile.radMax * mult);

	return newDamage;

}

function scr_stats_calculateResistanceRange(res) {

	var minRes = floor(res / 5);
	var maxRes = res;
	
	return {
		minRes: minRes,
		maxRes: maxRes
	}
	
}


function scr_stats_calculateFinalStats(stats) {
	
	if (!is_struct(stats)) return undefined;
	
	var newStats = {

		//health and shields
		maxHp: scr_stats_calculateStat(stats.maxHp, stats.maxHpPerc),
		maxShield: scr_stats_calculateStat(stats.maxShield, stats.maxShieldPerc),
		hpRegen: scr_stats_calculateStat(stats.hpRegen, stats.hpRegenPerc),
		shieldRegen: scr_stats_calculateStat(stats.shieldRegen, stats.shieldRegenPerc),
		maxEnergy: scr_stats_calculateStat(stats.maxEnergy, stats.maxEnergyPerc),
		energyRegen: scr_stats_calculateStat(stats.energyRegen, stats.energyRegenPerc),
		
		//movement
		spd: stats.spd,
		dashCoolTime: stats.dashCoolTime,
		maxDashes: stats.maxDashes,

		//damage
		kinDam: scr_stats_calculateStat(stats.kinDam, stats.kinDamPerc),
		fireDam: scr_stats_calculateStat(stats.fireDam, stats.fireDamPerc),
		chemDam: scr_stats_calculateStat(stats.chemDam, stats.chemDamPerc),
		elecDam: scr_stats_calculateStat(stats.elecDam, stats.elecDamPerc),
		radDam: scr_stats_calculateStat(stats.radDam, stats.radDamPerc),
	
		//resistances
		kinRes: scr_stats_calculateStat(stats.kinRes, stats.kinResPerc),
		fireRes: scr_stats_calculateStat(stats.fireRes, stats.fireResPerc),
		chemRes: scr_stats_calculateStat(stats.chemRes, stats.chemResPerc),
		elecRes: scr_stats_calculateStat(stats.elecRes, stats.elecResPerc),
		radRes: scr_stats_calculateStat(stats.radRes, stats.radResPerc),
		
	}
	
	var range = scr_stats_calculateResistanceRange(newStats.kinRes);
	newStats.kinResMin = range.minRes;
	newStats.kinResMax = range.maxRes;
	
	range = scr_stats_calculateResistanceRange(newStats.fireRes);
	newStats.fireResMin = range.minRes;
	newStats.fireResMax = range.maxRes;
	
	range = scr_stats_calculateResistanceRange(newStats.chemRes);
	newStats.chemResMin = range.minRes;
	newStats.chemResMax = range.maxRes;
	
	range = scr_stats_calculateResistanceRange(newStats.elecRes);
	newStats.elecResMin = range.minRes;
	newStats.elecResMax = range.maxRes;
	
	range = scr_stats_calculateResistanceRange(newStats.radRes);
	newStats.radResMin = range.minRes;
	newStats.radResMax = range.maxRes;
	
	return newStats;

}

function scr_stats_getName(statKey) {

    switch (statKey) {

        case "maxHp": return "Max Health";
        case "maxShield": return "Max Shield";
        case "hpRegen": return "Health Regeneration";
        case "shieldRegen": return "Shield Regeneration";
        case "maxEnergy": return "Max Energy";
        case "energyRegen": return "Energy Regeneration";

        case "maxStimPacks": return "Max Stim Packs";
        case "maxEnergyPacks": return "Max Energy Packs";
        case "stimPackRegen": return "Stim Pack Regeneration";
        case "energyPackRegen": return "Energy Pack Regeneration";

        case "oa": return "Offensive Ability";
        case "da": return "Defensive Ability";

        case "spd": return "Movement Speed";
        case "dashCoolTime": return "Dash Cooldown";
        case "maxDashes": return "Max Dashes";

        case "maxHpPerc": return "Max Health %";
        case "maxShieldPerc": return "Max Shield %";
        case "hpRegenPerc": return "Health Regeneration %";
        case "shieldRegenPerc": return "Shield Regeneration %";
        case "maxEnergyPerc": return "Max Energy %";
        case "energyRegenPerc": return "Energy Regeneration %";

        case "kinDam": return "Kinetic Damage";
        case "fireDam": return "Fire Damage";
        case "chemDam": return "Chemical Damage";
        case "elecDam": return "Electric Damage";
        case "radDam": return "Radiation Damage";

        case "kinDamPerc": return "Kinetic Damage %";
        case "fireDamPerc": return "Fire Damage %";
        case "chemDamPerc": return "Chemical Damage %";
        case "elecDamPerc": return "Electric Damage %";
        case "radDamPerc": return "Radiation Damage %";

        case "kinRes": return "Kinetic Resistance";
        case "fireRes": return "Fire Resistance";
        case "chemRes": return "Chemical Resistance";
        case "elecRes": return "Electric Resistance";
        case "radRes": return "Radiation Resistance";

        case "kinResPerc": return "Kinetic Resistance %";
        case "fireResPerc": return "Fire Resistance %";
        case "chemResPerc": return "Chemical Resistance %";
        case "elecResPerc": return "Electric Resistance %";
        case "radResPerc": return "Radiation Resistance %";

        default: return "...";

    }

}

function scr_stats_formatCharStats(stats, finalStats) {

    var str = "";

    // flat health and shields
    str = scr_stats_formatStat(str, stats, "maxHp");
    str = scr_stats_formatStat(str, stats, "maxShield");
    str = scr_stats_formatStat(str, stats, "hpRegen");
    str = scr_stats_formatStat(str, stats, "shieldRegen");
    str = scr_stats_formatStat(str, stats, "maxEnergy");
    str = scr_stats_formatStat(str, stats, "energyRegen");

	str += "\n";

    // packs
    str = scr_stats_formatStat(str, stats, "maxStimPacks");
    str = scr_stats_formatStat(str, stats, "maxEnergyPacks");
    str = scr_stats_formatStat(str, stats, "stimPackRegen");
    str = scr_stats_formatStat(str, stats, "energyPackRegen");

	str += "\n";

    // oa and da
    str = scr_stats_formatStat(str, stats, "oa");
    str = scr_stats_formatStat(str, stats, "da");

	str += "\n";
	
    // movement
    str = scr_stats_formatStat(str, stats, "spd");
    str = scr_stats_formatStat(str, stats, "dashCoolTime");
    str = scr_stats_formatStat(str, stats, "maxDashes");

	str += "\n";

    // flat damage
    str = scr_stats_formatStat(str, stats, "kinDam");
    str = scr_stats_formatStat(str, stats, "fireDam");
    str = scr_stats_formatStat(str, stats, "chemDam");
    str = scr_stats_formatStat(str, stats, "elecDam");
    str = scr_stats_formatStat(str, stats, "radDam");
	
	str += "\n";
	
    // damage percent increase
    str = scr_stats_formatStat(str, stats, "kinDamPerc");
    str = scr_stats_formatStat(str, stats, "fireDamPerc");
    str = scr_stats_formatStat(str, stats, "chemDamPerc");
    str = scr_stats_formatStat(str, stats, "elecDamPerc");
    str = scr_stats_formatStat(str, stats, "radDamPerc");
	
	str += "\n";
	
    // resistances
    str = scr_stats_formatStat(str, finalStats, "kinRes");
    str = scr_stats_formatStat(str, finalStats, "fireRes");
    str = scr_stats_formatStat(str, finalStats, "chemRes");
    str = scr_stats_formatStat(str, finalStats, "elecRes");
    str = scr_stats_formatStat(str, finalStats, "radRes");

    return str;

}

function scr_stats_formatStat(str, stats, name) {

    if (!variable_struct_exists(stats, name)) return str;

    var value = stats[$ name];

    if (str != "") str += "\n";

    str += scr_stats_getName(name) + ":   " + string(value);

    return str;

}

function scr_stats_hitOutcome(oa, da) {

	var outcome = 1;
	var diff = abs(oa - da);
	
	if (diff < 11) return outcome;
	
	//chance for crit
	if (oa > da) {
		
		diff = oa - da;
		
		var crits = 0;
		var rolls = 1 + floor(diff / 100);

		for (var i = 0; i < rolls; i++) {

		    var chance = min(95, diff / (i + 1));

		    var roll = irandom_range(1, 100);

		    if (roll <= chance) {
		        crits++;
		    } else {
		        break;
		    }

		}

		outcome += crits;
		
	}
	
	//chance for glancing hit
	else if (da > oa) {
	
		diff = da - oa;
	
		var rolls = 1 + floor(diff / 300);

		repeat (rolls) {

		    var chance = min(290, diff);

		    var roll = irandom_range(1, 300);

		    if (roll <= chance) {
		        outcome = 0.5;
		        break;
		    }

		}
	
	}
	
	return outcome;
	
}