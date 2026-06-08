function scr_char_isFriendly(source, target) {

	if (!instance_exists(source)) return false;
	if (!instance_exists(target)) return false;

	return source.faction == target.faction;
	
}

function scr_char_fleshExplosion(char){
	
	var spr = char.sprite_index;
	
	var w = sprite_get_width(spr) * 0.5;
	var h = sprite_get_height(spr) * 0.5;
	
	var xx = char.x;
	var yy = char.y;

	// diamond points (approx, centred on origin)
	var topX = xx;
	var topY = yy - h;

	var bottomX = xx;
	var bottomY = yy + h; //* 0.75;
	
	var midY = (bottomY + topY) * 0.5;

	var leftX = xx - w;
	var leftY = yy;

	var rightX = xx + w;
	var rightY = yy;
	
	var col = char.bloodCol;
	var force = 12;
	var particles = 10;
	var rad = 6;
	var splits = 2;
	var life = 8;
	
	var dels = [0, 1, 3, 5];
	dels = array_shuffle(dels);
	
	scr_effects_bloodSplatter(topX, midY, col, force, 15, 7, 0, life);
	
	var b1 = scr_effects_bloodSplatter(topX, topY, col, force, particles, rad, splits, life);
	var b2 = scr_effects_bloodSplatter(bottomX, bottomY, col, force, particles, rad, splits, life);
	var b3 = scr_effects_bloodSplatter(leftX, leftY, col, force, particles, rad, splits, life);
	var b4 = scr_effects_bloodSplatter(rightX, rightY, col, force, particles, rad, splits, life);

	b1.delay = dels[0];
	b2.delay = dels[1];
	b3.delay = dels[2];
	b4.delay = dels[3];

}

function scr_char_damage(char, damage, type, ignoreShield) {
	
	if (!instance_exists(char)) return 0;
	if (!is_struct(damage)) return 0;
	
	//randomise damage
	var kin = damage.kin > 0 ? irandom_range(damage.kinMin, damage.kinMax) : 0;
	var fire = damage.fire > 0 ? irandom_range(damage.fireMin, damage.fireMax) : 0;
	var chem = damage.chem > 0 ?irandom_range(damage.chemMin, damage.chemMax) : 0;
	var elec = damage.elec > 0 ?irandom_range(damage.elecMin, damage.elecMax) : 0;
	var rad = damage.rad > 0 ? irandom_range(damage.radMin, damage.radMax) : 0;
	
	//apply resistances
	var totalRes = 0;
	var preDam = kin + fire + chem + elec + rad;
	
	if (kin > 0 and char.finalStats.kinRes > 0) {
		var res = irandom_range(char.finalStats.kinResMin, char.finalStats.kinResMax);
		kin = max(1, kin - res);
		totalRes += res;
	}
	
	if (fire > 0 and char.finalStats.fireRes > 0) {
		var res = irandom_range(char.finalStats.fireResMin, char.finalStats.fireResMax);
		fire = max(1, fire - res);
		totalRes += res;
	}
	
	if (chem > 0 and char.finalStats.chemRes > 0) {
		var res = irandom_range(char.finalStats.chemResMin, char.finalStats.chemResMax);
		chem = max(1, chem - res);
		totalRes += res;
	}
	
	if (elec > 0 and char.finalStats.elecRes > 0) {
		var res = irandom_range(char.finalStats.elecResMin, char.finalStats.elecResMax);
		elec = max(1, elec - res);
		totalRes += res;
	}
	
	if (rad > 0 and char.finalStats.radRes > 0) {
		var res = irandom_range(char.finalStats.radResMin, char.finalStats.radResMax);
		rad = max(1, rad - res);
		totalRes += res;
	}
	
	//final
	var totalDam = kin + fire + chem + elec + rad;
	
	show_debug_message("dam: " + string(preDam));
	show_debug_message("res: " + string(totalRes));
	show_debug_message("final dam: " + string(totalDam));
	show_debug_message("--------");
	
	
	if (!ignoreShield and char.shield > 0) {
	
		char.shield -= 1;
		return 0;
	
	}
	
	var lost = min(char.hp, totalDam);
	
	char.hp = max(char.hp - totalDam, 0);
	
	return lost;
	
}

function scr_char_heal(char, amount) {

	if (!instance_exists(char)) return 0;
	
	var missing = char.maxHp - char.hp;
	
	char.hp = min(char.hp + amount, char.maxHp);
	
	return min(amount, missing);
	
}

function scr_char_calculateFinalStats(stats) {
	
	if (!is_struct(stats)) return undefined;
	
	var newStats = {

		//health and shields
		maxHp: scr_char_calculateStat(stats.maxHp, stats.maxHpPerc),
		maxShield: scr_char_calculateStat(stats.maxShield, stats.maxShieldPerc),
		hpRegen: scr_char_calculateStat(stats.hpRegen, stats.hpRegenPerc),
		shieldRegen: scr_char_calculateStat(stats.shieldRegen, stats.shieldRegenPerc),

		//damage
		kinDam: scr_char_calculateStat(stats.kinDam, stats.kinDamPerc),
		fireDam: scr_char_calculateStat(stats.fireDam, stats.fireDamPerc),
		chemDam: scr_char_calculateStat(stats.chemDam, stats.chemDamPerc),
		elecDam: scr_char_calculateStat(stats.elecDam, stats.elecDamPerc),
		radDam: scr_char_calculateStat(stats.radDam, stats.radDamPerc),
	
		//resistances
		kinRes: scr_char_calculateStat(stats.kinRes, stats.kinResPerc),
		fireRes: scr_char_calculateStat(stats.fireRes, stats.fireResPerc),
		chemRes: scr_char_calculateStat(stats.chemRes, stats.chemResPerc),
		elecRes: scr_char_calculateStat(stats.elecRes, stats.elecResPerc),
		radRes: scr_char_calculateStat(stats.radRes, stats.radResPerc),
		
	}
	
	var range = scr_char_calculateResistanceRange(newStats.kinRes);
	newStats.kinResMin = range.minRes;
	newStats.kinResMax = range.maxRes;
	
	range = scr_char_calculateResistanceRange(newStats.fireRes);
	newStats.fireResMin = range.minRes;
	newStats.fireResMax = range.maxRes;
	
	range = scr_char_calculateResistanceRange(newStats.chemRes);
	newStats.chemResMin = range.minRes;
	newStats.chemResMax = range.maxRes;
	
	range = scr_char_calculateResistanceRange(newStats.elecRes);
	newStats.elecResMin = range.minRes;
	newStats.elecResMax = range.maxRes;
	
	range = scr_char_calculateResistanceRange(newStats.radRes);
	newStats.radResMin = range.minRes;
	newStats.radResMax = range.maxRes;
	
	return newStats;

}

function scr_char_calculateStat(flat, perc) {

	//show_debug_message("flat: " + string(flat));
	//show_debug_message("perc: " + string(perc));

	var dec = perc * 0.01;
	var add = dec * flat;
	
	//show_debug_message("dec: " + string(dec));
	//show_debug_message("add: " + string(add));
	
	//show_debug_message("total: " + string(flat + add));

	//show_debug_message("----------");

	return flat + add;
	
}

function scr_char_calculateResistanceRange(res) {

	var minRes = floor(res / 5);
	var maxRes = res;
	
	return {
		minRes: minRes,
		maxRes: maxRes
	}
	
}