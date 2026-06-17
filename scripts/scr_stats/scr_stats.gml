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