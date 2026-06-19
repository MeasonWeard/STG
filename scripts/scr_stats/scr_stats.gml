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

function scr_stats_calculateDamageProfileWeapon(char, profile) {

	var newStats = {};
	
	scr_data_structCopyInto(newStats, profile);
	
	newStats.damage.kin = scr_stats_calculateStat(newStats.damage.kin, char.stats.kinDamPerc) + char.finalStats.kinDam;
	newStats.damage.fire = scr_stats_calculateStat(newStats.damage.fire, char.stats.fireDamPerc) + char.finalStats.fireDam;
	newStats.damage.chem = scr_stats_calculateStat(newStats.damage.chem, char.stats.chemDamPerc) + char.finalStats.chemDam;
	newStats.damage.elec = scr_stats_calculateStat(newStats.damage.elec, char.stats.elecDamPerc) + char.finalStats.elecDam;
	newStats.damage.rad = scr_stats_calculateStat(newStats.damage.rad, char.stats.radDamPerc) + char.finalStats.radDam;
	
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

function scr_stats_calculateDamageProfile(char, profile) {

	var newStats = {};
	
	scr_data_structCopyInto(newStats, profile);
	
	newStats.kin = scr_stats_calculateStat(newStats.kin, char.stats.kinDamPerc) + char.finalStats.kinDam;
	newStats.fire = scr_stats_calculateStat(newStats.fire, char.stats.fireDamPerc) + char.finalStats.fireDam;
	newStats.chem = scr_stats_calculateStat(newStats.chem, char.stats.chemDamPerc) + char.finalStats.chemDam;
	newStats.elec = scr_stats_calculateStat(newStats.elec, char.stats.elecDamPerc) + char.finalStats.elecDam;
	newStats.rad = scr_stats_calculateStat(newStats.rad, char.stats.radDamPerc) + char.finalStats.radDam;
	
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