function scr_stats_blankCharStats() {

	var stats = {

		//flat health and shields
		maxHp: 100,
		maxShield: 0,
		hpRegen: 0,
		shieldRegen: 0.2,
		maxEnergy: 0,
		energyRegen: 2,
		shieldRegenDelay: 3,

		//packs
		maxStimPacks: 0,
		maxEnergyPacks: 0,
		stimPackRegen: 1,
		energyPackRegen: 1,
	
		//oa and da
		oa: 100,
		da: 100,
	
		//movement
		spd: 4,
		dashRegen: 0.25,
		maxDashes: 1,

		//health and shields percent increase
		maxHpPerc: 0,
		maxShieldPerc: 0,
		hpRegenPerc: 0,
		shieldRegenPerc: 0,
		maxEnergyPerc: 0,
		energyRegenPerc: 0,
		healingPerc: 0,
		
		rangedLifeSteal: 0,
		meleeLifeSteal: 0,
	
		//flat damage
		kinDam: 0,
		fireDam: 0,
		chemDam: 0, 
		elecDam: 0,
		radDam: 0,

		//damage percent increase
		kinDamPerc: 0,
		fireDamPerc: 0,
		chemDamPerc: 0,
		elecDamPerc: 0,
		radDamPerc: 0,
		
		//
		gunDamPerc: 0,
		meleeDamPerc: 0,
	
		//flat resistances
		kinRes: 0,
		fireRes: 0,
		chemRes: 0,
		elecRes: 0,
		radRes: 0,
	
		//resistance percent increase
		kinResPerc: 0,
		fireResPerc: 0,
		chemResPerc: 0,
		elecResPerc: 0,
		radResPerc: 0,
		
		projRes: 0,
		meleeRes: 0
	
	};
	
	return stats;
	
}

function damageProfile() constructor {

	kin = 0;
	fire = 0;
	chem = 0;
	elec = 0;
	rad = 0;
	
}

function scr_stats_calculateStat(flat, perc, roundProduct = false) {

	if (is_undefined(flat)) flat = 0;
	if (is_undefined(perc)) perc = 0;

	var dec = perc * 0.01;
	var add = dec * flat;

	var amount = flat + add;

	if (roundProduct) amount = round(amount);

	return amount;

	//var dec = perc * 0.01;
	//var add = dec * flat;
	
	//var amount = flat + add;
	
	//if (roundProduct) amount = round(amount);
	
	//return amount;
	
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
	
	if (!variable_struct_exists(char.finalStats, percKey)) return amount;
	if (!variable_struct_exists(char.finalStats, damKey)) return amount;

	var perc = char.finalStats[$ percKey];
	var dam = char.finalStats[$ damKey];
	
	return scr_stats_calculateStat(amount, perc) + dam;

}

function scr_stats_calculateDamageProfileRanges(profile) {
	
	var newProfile = {};
	
	scr_data_structCopyInto(newProfile, profile);
	
	var range = scr_stats_calculateDamageRange(newProfile.kin);
	newProfile.kinMin = range.minDam;
	newProfile.kinMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newProfile.fire);
	newProfile.fireMin = range.minDam;
	newProfile.fireMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newProfile.chem);
	newProfile.chemMin = range.minDam;
	newProfile.chemMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newProfile.elec);
	newProfile.elecMin = range.minDam;
	newProfile.elecMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newProfile.rad);
	newProfile.radMin = range.minDam;
	newProfile.radMax = range.maxDam;
	
	return newProfile;
	
}

function scr_stats_calculateDamageProfileWeapon(char, profile) {

	var newStats = {};
	
	scr_data_structCopyInto(newStats, profile);
	
	newStats.damage.kin = scr_stats_applyDamageBonuses(char, newStats.damage.kin, "kin");
	newStats.damage.fire = scr_stats_applyDamageBonuses(char, newStats.damage.fire, "fire");
	newStats.damage.chem = scr_stats_applyDamageBonuses(char, newStats.damage.chem, "chem");
	newStats.damage.elec = scr_stats_applyDamageBonuses(char, newStats.damage.elec, "elec");
	newStats.damage.rad = scr_stats_applyDamageBonuses(char, newStats.damage.rad, "rad");
	
	//newStats.damage.kin = scr_stats_calculateStat(newStats.damage.kin, char.stats.kinDamPerc) + char.finalStats.kinDam;
	//newStats.damage.fire = scr_stats_calculateStat(newStats.damage.fire, char.stats.fireDamPerc) + char.finalStats.fireDam;
	//newStats.damage.chem = scr_stats_calculateStat(newStats.damage.chem, char.stats.chemDamPerc) + char.finalStats.chemDam;
	//newStats.damage.elec = scr_stats_calculateStat(newStats.damage.elec, char.stats.elecDamPerc) + char.finalStats.elecDam;
	//newStats.damage.rad = scr_stats_calculateStat(newStats.damage.rad, char.stats.radDamPerc) + char.finalStats.radDam;
	
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

function scr_stats_calculateCharDamageProfile(char, profile, applyBonuses) {

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
	newDamage.fire    = round(profile.fire    * mult);
	newDamage.chem    = round(profile.chem    * mult);
	newDamage.elec    = round(profile.elec    * mult);
	newDamage.rad    = round(profile.rad    * mult);

	if (variable_struct_exists(profile, "kinMin")) {
		
		newDamage.kinMin = round(profile.kinMin * mult);
		newDamage.kinMax = round(profile.kinMax * mult);
	
		newDamage.fireMin = round(profile.fireMin * mult);
		newDamage.fireMax = round(profile.fireMax * mult);
	
		newDamage.chemMin = round(profile.chemMin * mult);
		newDamage.chemMax = round(profile.chemMax * mult);
	
		newDamage.elecMin = round(profile.elecMin * mult);
		newDamage.elecMax = round(profile.elecMax * mult);
	
		newDamage.radMin = round(profile.radMin * mult);
		newDamage.radMax = round(profile.radMax * mult);
		
	}

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

function scr_stats_updateResistanceRange(stats, key) {

	var res = stats[$ key];

	var range = scr_stats_calculateResistanceRange(res);

	stats[$ (key + "Min")] = range.minRes;
	stats[$ (key + "Max")] = range.maxRes;

}


function scr_stats_calculateFinalStats(stats) {
	
	if (!is_struct(stats)) return undefined;
	
	var newStats = variable_clone(stats);
	
	//health and shields
	newStats.maxHp = scr_stats_calculateStat(stats.maxHp, stats.maxHpPerc, true);
	newStats.maxShield = scr_stats_calculateStat(stats.maxShield, stats.maxShieldPerc, true);
	newStats.hpRegen = scr_stats_calculateStat(stats.hpRegen, stats.hpRegenPerc);
	newStats.shieldRegen = scr_stats_calculateStat(stats.shieldRegen, stats.shieldRegenPerc);
	newStats.maxEnergy = scr_stats_calculateStat(stats.maxEnergy, stats.maxEnergyPerc, true);
	newStats.energyRegen = scr_stats_calculateStat(stats.energyRegen, stats.energyRegenPerc);
	
	//damage
	newStats.kinDam = scr_stats_calculateStat(stats.kinDam, stats.kinDamPerc, true);
	newStats.fireDam = scr_stats_calculateStat(stats.fireDam, stats.fireDamPerc, true);
	newStats.chemDam = scr_stats_calculateStat(stats.chemDam, stats.chemDamPerc, true);
	newStats.elecDam = scr_stats_calculateStat(stats.elecDam, stats.elecDamPerc, true);
	newStats.radDam = scr_stats_calculateStat(stats.radDam, stats.radDamPerc, true);
	
	//resistances
	newStats.kinRes = scr_stats_calculateStat(stats.kinRes, stats.kinResPerc, true);
	newStats.fireRes = scr_stats_calculateStat(stats.fireRes, stats.fireResPerc, true);
	newStats.chemRes = scr_stats_calculateStat(stats.chemRes, stats.chemResPerc, true);
	newStats.elecRes = scr_stats_calculateStat(stats.elecRes, stats.elecResPerc, true);
	newStats.radRes = scr_stats_calculateStat(stats.radRes, stats.radResPerc, true);
	
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
	
	range = scr_stats_calculateResistanceRange(newStats.meleeRes);
	newStats.meleeResMin = range.minRes;
	newStats.meleeResMax = range.maxRes;
	
	range = scr_stats_calculateResistanceRange(newStats.projRes);
	newStats.projResMin = range.minRes;
	newStats.projResMax = range.maxRes;
	
	return newStats;
	
	//if (!is_struct(stats)) return undefined;
	
	//var newStats = {

	//	//health and shields
	//	maxHp: scr_stats_calculateStat(stats.maxHp, stats.maxHpPerc, true),
	//	maxShield: scr_stats_calculateStat(stats.maxShield, stats.maxShieldPerc, true),
	//	hpRegen: scr_stats_calculateStat(stats.hpRegen, stats.hpRegenPerc),
	//	shieldRegen: scr_stats_calculateStat(stats.shieldRegen, stats.shieldRegenPerc),
	//	maxEnergy: scr_stats_calculateStat(stats.maxEnergy, stats.maxEnergyPerc, true),
	//	energyRegen: scr_stats_calculateStat(stats.energyRegen, stats.energyRegenPerc),
		
	//	//movement
	//	spd: stats.spd,
	//	dashRegen: stats.dashRegen,
	//	maxDashes: stats.maxDashes,

	//	//damage
	//	kinDam: scr_stats_calculateStat(stats.kinDam, stats.kinDamPerc, true),
	//	fireDam: scr_stats_calculateStat(stats.fireDam, stats.fireDamPerc, true),
	//	chemDam: scr_stats_calculateStat(stats.chemDam, stats.chemDamPerc, true),
	//	elecDam: scr_stats_calculateStat(stats.elecDam, stats.elecDamPerc, true),
	//	radDam: scr_stats_calculateStat(stats.radDam, stats.radDamPerc, true),
	
	//	//resistances
	//	kinRes: scr_stats_calculateStat(stats.kinRes, stats.kinResPerc, true),
	//	fireRes: scr_stats_calculateStat(stats.fireRes, stats.fireResPerc, true),
	//	chemRes: scr_stats_calculateStat(stats.chemRes, stats.chemResPerc, true),
	//	elecRes: scr_stats_calculateStat(stats.elecRes, stats.elecResPerc, true),
	//	radRes: scr_stats_calculateStat(stats.radRes, stats.radResPerc, true),
		
	//}
	
	//var range = scr_stats_calculateResistanceRange(newStats.kinRes);
	//newStats.kinResMin = range.minRes;
	//newStats.kinResMax = range.maxRes;
	
	//range = scr_stats_calculateResistanceRange(newStats.fireRes);
	//newStats.fireResMin = range.minRes;
	//newStats.fireResMax = range.maxRes;
	
	//range = scr_stats_calculateResistanceRange(newStats.chemRes);
	//newStats.chemResMin = range.minRes;
	//newStats.chemResMax = range.maxRes;
	
	//range = scr_stats_calculateResistanceRange(newStats.elecRes);
	//newStats.elecResMin = range.minRes;
	//newStats.elecResMax = range.maxRes;
	
	//range = scr_stats_calculateResistanceRange(newStats.radRes);
	//newStats.radResMin = range.minRes;
	//newStats.radResMax = range.maxRes;
	
	//return newStats;

}

function scr_stats_getName(statKey) {

    switch (statKey) {

        case "maxHp": return "Max Health";
        case "maxShield": return "Max Shield";
        case "hpRegen": return "Health Regeneration";
        case "shieldRegen": return "Shield Regeneration";
		case "shieldRegenDelay": return "Shield Regeneration Delay";
        case "maxEnergy": return "Max Energy";
        case "energyRegen": return "Energy Regeneration";

        case "maxStimPacks": return "Max Stim Packs";
        case "maxEnergyPacks": return "Max Energy Packs";
        case "stimPackRegen": return "Stim Pack Recharge";
        case "energyPackRegen": return "Energy Pack Recharge";

        case "oa": return "Offensive Ability";
        case "da": return "Defensive Ability";

        case "spd": return "Movement Speed";
        case "dashRegen": return "Dash Recharge";
        case "maxDashes": return "Max Dashes";

        case "maxHpPerc": return "Max Health %";
        case "maxShieldPerc": return "Max Shield %";
        case "hpRegenPerc": return "Health Regeneration %";
        case "shieldRegenPerc": return "Shield Regeneration %";
        case "maxEnergyPerc": return "Max Energy %";
        case "energyRegenPerc": return "Energy Regeneration %";
		case "healingPerc" : return "Healing %";
		
		case "rangedLifeSteal" : return  "Ranged Life Steal";
		case "meleeLifeSteal" : return  "Melee Life Steal";

        case "kinDam": return "Flat Kinetic Damage";
        case "fireDam": return "Flat Fire Damage";
        case "chemDam": return "Flat Chemical Damage";
        case "elecDam": return "Flat Electric Damage";
        case "radDam": return "Flat Radiation Damage";

        case "kinDamPerc": return "Kinetic Damage %";
        case "fireDamPerc": return "Fire Damage %";
        case "chemDamPerc": return "Chemical Damage %";
        case "elecDamPerc": return "Electric Damage %";
        case "radDamPerc": return "Radiation Damage %";
		
		case "gunDamPerc": return "Gun Damage %";
        case "meleeDamPerc": return "Melee Damage %";

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
		
		case "meleeRes": return "Melee Resistance";
		case "projRes": return "Projectile Resistance";

        default: return "???" + statKey + "???";

    }

}

function scr_stats_formatCharStats(finalStats) {

    var str = "";

    // flat health and shields
    str = scr_stats_formatStat(str, finalStats, "maxHp");
	str = scr_stats_formatStat(str, finalStats, "hpRegen", " p/s");
	str += "\n";
	
    str = scr_stats_formatStat(str, finalStats, "maxShield");
    str = scr_stats_formatStat(str, finalStats, "shieldRegen", " p/s");
	str = scr_stats_formatStat(str, finalStats, "shieldRegenDelay", " seconds");
	str += "\n";
	
    str = scr_stats_formatStat(str, finalStats, "maxEnergy");
    str = scr_stats_formatStat(str, finalStats, "energyRegen", " p/s");

	str += "\n";

    // packs
    str = scr_stats_formatStat(str, finalStats, "maxStimPacks");
    str = scr_stats_formatStat(str, finalStats, "maxEnergyPacks");
    str = scr_stats_formatStat(str, finalStats, "stimPackRegen", " per minute");
    str = scr_stats_formatStat(str, finalStats, "energyPackRegen", " per minute");

	str += "\n";

    // oa and da
    str = scr_stats_formatStat(str, finalStats, "oa");
    str = scr_stats_formatStat(str, finalStats, "da");

	str += "\n";
	
    // movement
    str = scr_stats_formatStat(str, finalStats, "spd");
    str = scr_stats_formatStat(str, finalStats, "dashRegen", " p/s");
    str = scr_stats_formatStat(str, finalStats, "maxDashes");

	str += "\n";

    // flat damage
    str = scr_stats_formatStat(str, finalStats, "kinDam");
    str = scr_stats_formatStat(str, finalStats, "fireDam");
    str = scr_stats_formatStat(str, finalStats, "chemDam");
    str = scr_stats_formatStat(str, finalStats, "elecDam");
    str = scr_stats_formatStat(str, finalStats, "radDam");
	
	str += "\n";
	
    // damage percent increase
    str = scr_stats_formatStat(str, finalStats, "kinDamPerc", "%");
    str = scr_stats_formatStat(str, finalStats, "fireDamPerc", "%");
    str = scr_stats_formatStat(str, finalStats, "chemDamPerc", "%");
    str = scr_stats_formatStat(str, finalStats, "elecDamPerc", "%");
    str = scr_stats_formatStat(str, finalStats, "radDamPerc", "%");
	
	str += "\n";
	
	//
	str = scr_stats_formatStat(str, finalStats, "gunDamPerc", "%");
    str = scr_stats_formatStat(str, finalStats, "meleeDamPerc", "%");
	
	str += "\n";
	
    // resistances
    str = scr_stats_formatStat(str, finalStats, "kinRes");
    str = scr_stats_formatStat(str, finalStats, "fireRes");
    str = scr_stats_formatStat(str, finalStats, "chemRes");
    str = scr_stats_formatStat(str, finalStats, "elecRes");
    str = scr_stats_formatStat(str, finalStats, "radRes");
	
	str = scr_stats_formatStat(str, finalStats, "meleeRes");
	str = scr_stats_formatStat(str, finalStats, "projRes");
	
    return str;

}

function scr_stats_formatCharCore(finalStats) {

	var str = "";

	// health
	str = scr_stats_formatStat(str, finalStats, "maxHp");
	str = scr_stats_formatStat(str, finalStats, "hpRegen", " p/s");
	str += "\n";

	// shields
	str = scr_stats_formatStat(str, finalStats, "maxShield");
	str = scr_stats_formatStat(str, finalStats, "shieldRegen", " p/s");
	str = scr_stats_formatStat(str, finalStats, "shieldRegenDelay", " seconds");
	str += "\n";

	// energy
	str = scr_stats_formatStat(str, finalStats, "maxEnergy");
	str = scr_stats_formatStat(str, finalStats, "energyRegen", " p/s");
	str += "\n";

	// packs
	str = scr_stats_formatStat(str, finalStats, "maxStimPacks");
	str = scr_stats_formatStat(str, finalStats, "maxEnergyPacks");
	str = scr_stats_formatStat(str, finalStats, "stimPackRegen", " per minute");
	str = scr_stats_formatStat(str, finalStats, "energyPackRegen", " per minute");
	str += "\n";
	
	//healing
	str = scr_stats_formatStat(str, finalStats, "healingPerc");
	str += "\n";
	
	// movement
	str = scr_stats_formatStat(str, finalStats, "spd");
	str = scr_stats_formatStat(str, finalStats, "dashRegen", " p/s");
	str = scr_stats_formatStat(str, finalStats, "maxDashes");

	return str;
}

function scr_stats_formatCharDefence(finalStats) {

	var str = "";

	// defensive ability
	str = scr_stats_formatStat(str, finalStats, "da");
	str += "\n";

	// elemental resistances
	str = scr_stats_formatStat(str, finalStats, "kinRes");
	str = scr_stats_formatStat(str, finalStats, "fireRes");
	str = scr_stats_formatStat(str, finalStats, "chemRes");
	str = scr_stats_formatStat(str, finalStats, "elecRes");
	str = scr_stats_formatStat(str, finalStats, "radRes");
	str += "\n";

	// attack-type resistances
	str = scr_stats_formatStat(str, finalStats, "meleeRes");
	str = scr_stats_formatStat(str, finalStats, "projRes");

	return str;
}

function scr_stats_formatCharOffence(finalStats) {

	var str = "";

	// offensive ability
	str = scr_stats_formatStat(str, finalStats, "oa");
	str += "\n";

	// flat damage
	str = scr_stats_formatStat(str, finalStats, "kinDam");
	str = scr_stats_formatStat(str, finalStats, "fireDam");
	str = scr_stats_formatStat(str, finalStats, "chemDam");
	str = scr_stats_formatStat(str, finalStats, "elecDam");
	str = scr_stats_formatStat(str, finalStats, "radDam");
	str += "\n";

	// damage percentage increases
	str = scr_stats_formatStat(str, finalStats, "kinDamPerc", "%");
	str = scr_stats_formatStat(str, finalStats, "fireDamPerc", "%");
	str = scr_stats_formatStat(str, finalStats, "chemDamPerc", "%");
	str = scr_stats_formatStat(str, finalStats, "elecDamPerc", "%");
	str = scr_stats_formatStat(str, finalStats, "radDamPerc", "%");
	str += "\n";

	// weapon damage percentage increases
	str = scr_stats_formatStat(str, finalStats, "gunDamPerc", "%");
	str = scr_stats_formatStat(str, finalStats, "meleeDamPerc", "%");

	return str;
}

function scr_stats_formatStat(str, stats, name, appendString = undefined) {

    if (!variable_struct_exists(stats, name)) return str;

    var value = stats[$ name];

    if (str != "") str += "\n";

    str += scr_stats_getName(name) + ":     " + string(value);
	
	if (is_string(appendString)) str += appendString;

    return str;

}

function scr_stats_hitOutcome(oa, da) {

	var outcome = 1;
	var diff = abs(oa - da);
	
	if (diff < 10) return outcome;
	
	//chance for crit
	if (oa > da) {
		
		diff = (oa - da) * 0.5;
		
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

function scr_stats_formatDamage(damage) {
	
	var txt = "";
	
	if (damage.kin > 0) {
		if (txt != "") txt += "\n";
		txt += "Kinetic: " + string(damage.kin);
	}
	
	if (damage.fire > 0) {
		if (txt != "") txt += "\n";
		txt += "Fire: " + string(damage.fire);
	}
	
	if (damage.chem > 0) {
		if (txt != "") txt += "\n";
		txt += "Chemical: " + string(damage.chem);
	}
	
	if (damage.elec > 0) {
		if (txt != "") txt += "\n";
		txt += "Electric: " + string(damage.elec);
	}
	
	if (damage.rad > 0) {
		if (txt != "") txt += "\n";
		txt += "Radiation: " + string(damage.rad);
	}
	
	return txt;
	
}

function scr_stats_formatDamageRange(damage) {
	
	var txt = "";
	
	if (damage.kinMax > 0) {
		if (txt != "") txt += "\n";
		txt += "Kinetic: " + string(damage.kinMin) + " - " + string(damage.kinMax);
	}
	
	if (damage.fireMax > 0) {
		if (txt != "") txt += "\n";
		txt += "Fire: " + string(damage.fireMin) + " - " + string(damage.fireMax);
	}
	
	if (damage.chemMax > 0) {
		if (txt != "") txt += "\n";
		txt += "Chemical: " + string(damage.chemMin) + " - " + string(damage.chemMax);
	}
	
	if (damage.elecMax > 0) {
		if (txt != "") txt += "\n";
		txt += "Electric: " + string(damage.elecMin) + " - " + string(damage.elecMax);
	}
	
	if (damage.radMax > 0) {
		if (txt != "") txt += "\n";
		txt += "Radiation: " + string(damage.radMin) + " - " + string(damage.radMax);
	}
	
	return txt;
	
}

/// @function scr_stats_alterStat(struct, key, amount)
/// @desc Alters an existing field in a stats struct. Does not create new fields.
///
/// @param {struct} struct   The stats struct to modify.
/// @param {string} key      The name of the field to alter.
/// @param {real|bool} amount The amount to add to a numeric field, or the value to assign to a boolean field.
function scr_stats_alterStat(struct, key, amount) {

	if (!is_struct(struct)) exit;
	if (!variable_struct_exists(struct, key)) exit;

	var value = struct[$ key];

	if (is_bool(value)) {

		if (is_bool(amount)) {
			struct[$ key] = amount;
		}

	} else if (is_numeric(value) && is_numeric(amount)) {

		struct[$ key] = value + amount;

	}

}

function scr_stats_copyDamageBonuses(source, dest) {
	
	if (!is_struct(source) or !is_struct(dest)) exit;
	
	dest.kinDam = source.kinDam;
	dest.fireDam = source.fireDam;
	dest.chemDam = source.chemDam;
	dest.elecDam = source.elecDam;
	dest.radDam = source.radDam;
	
}

function scr_stats_copyDamageMultipliers(source, dest) {
	
	if (!is_struct(source) or !is_struct(dest)) exit;
	
	dest.kinDamPerc = source.kinDamPerc;
	dest.fireDamPerc = source.fireDamPerc;
	dest.chemDamPerc = source.chemDamPerc;
	dest.elecDamPerc = source.elecDamPerc;
	dest.radDamPerc = source.radDamPerc;
	
}

function scr_stats_copyResistanceBonuses(source, dest) {
	
	if (!is_struct(source) or !is_struct(dest)) exit;
	
	dest.kinRes = source.kinRes;
	dest.fireRes = source.fireRes;
	dest.chemRes = source.chemRes;
	dest.elecRes = source.elecRes;
	dest.radRes = source.radRes;
	
}

function scr_stats_copyResistanceMultipliers(source, dest) {
	
	if (!is_struct(source) or !is_struct(dest)) exit;
	
	dest.kinResPerc = source.kinResPerc;
	dest.fireResPerc = source.fireResPerc;
	dest.chemResPerc = source.chemResPerc;
	dest.elecResPerc = source.elecResPerc;
	dest.radResPerc = source.radResPerc;
	
}

function scr_stats_orderStatKeys(keysArray) {

	static order = [

		"maxHp",
		"maxShield",
		"hpRegen",
		"shieldRegen",
		"shieldRegenDelay",
		"maxEnergy",
		"energyRegen",

		"maxStimPacks",
		"maxEnergyPacks",
		"stimPackRegen",
		"energyPackRegen",

		"oa",
		"da",

		"spd",
		"dashRegen",
		"maxDashes",

		"maxHpPerc",
		"maxShieldPerc",
		"hpRegenPerc",
		"shieldRegenPerc",
		"maxEnergyPerc",
		"energyRegenPerc",
		"healingPerc",
		
		"rangedLifeSteal",
		"meleeLifeSteal",

		"kinDam",
		"fireDam",
		"chemDam",
		"elecDam",
		"radDam",

		"kinDamPerc",
		"fireDamPerc",
		"chemDamPerc",
		"elecDamPerc",
		"radDamPerc",

		"gunDamPerc",
		"meleeDamPerc",

		"kinRes",
		"fireRes",
		"chemRes",
		"elecRes",
		"radRes",

		"kinResPerc",
		"fireResPerc",
		"chemResPerc",
		"elecResPerc",
		"radResPerc"

	];

	static orderLen = array_length(order);

	var result = [];

	var keysLen = array_length(keysArray);

	//Reorder the keys
	for (var i = 0; i < orderLen; i++) {

		var key = order[i];

		for (var j = 0; j < keysLen; j++) {

			if (keysArray[j] == key) {
			    array_push(result, key);
			    break;
			}

		}

	}
	
	//Append any keys not in the ordering list
	for (var i = 0; i < keysLen; i++) {

	    var key = keysArray[i];

	    if (!array_contains(result, key)) {
	        array_push(result, key);
	    }

	}

	return result;

}

function scr_stats_calculateSkillDamage(char, damage, types) {

    var len = array_length(types);

    for (var i = 0; i < len; i++) {

        var type = types[i];

        damage[$ type] = scr_stats_applyDamageBonuses(
            char,
            damage[$ type],
            type
        );

    }

    return scr_stats_calculateDamageProfileRanges(damage);

}

function scr_stats_calculateBonusStatInteger(startingStat, level) {

	var low = max(1, floor(startingStat * (0.01 * level)));
	var high = max(1, ceil(startingStat * (0.04 * level)));
	
	return {
		low: low,
		high: high
	}
	
}

function scr_stats_calculateBonusStatFloat(startingStat, level) {

	var low = max(0.001, startingStat * (0.01 * level));
	var high = max(0.001, startingStat * (0.04 * level));
	
	return {
		low: low,
		high: high
	}
	
}

function scr_stats_rollSteppedBonus(interval, maximum, level) {

	static levelCap = 50;
	static minChance = 20;
	static maxChance = 90;
	static levelPower = 0.5;
	static chanceDecay = 0.75;

	var totalSteps = floor(maximum / interval);
	if (totalSteps <= 0) return 0;

	var maxSteps = min(totalSteps, max(1, level + 1));
	var steps = 1;

	// Level 1 begins at minChance; levelCap reaches maxChance
	var progress = clamp((level - 1) / (levelCap - 1), 0, 1);
	progress = power(progress, levelPower);

	var chance = lerp(minChance, maxChance, progress);

	while (steps < maxSteps and scr_random_chance(chance)) {

		steps++;
		chance *= chanceDecay;

	}

	return steps * interval;
	
}

function scr_stats_getHighestDamPerc(char) {

	if (!instance_exists(char)) return undefined;
	if (!is_struct(char.stats)) return undefined;

	var stats = char.stats;

	var keys = [
		"kinDamPerc",
		"fireDamPerc",
		"chemDamPerc",
		"elecDamPerc",
		"radDamPerc"
	];

	var highestKey = undefined;
	var highestVal = -infinity;

	var len = array_length(keys);

	for (var i = 0; i < len; i++) {

		var key = keys[i];

		if (!variable_struct_exists(stats, key)) continue;

		var val = stats[$ key];

		if (!is_real(val)) continue;

		if (val > highestVal) {
			highestVal = val;
			highestKey = key;
		}
	}

	return highestKey;

}