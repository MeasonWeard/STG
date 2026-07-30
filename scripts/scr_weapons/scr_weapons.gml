function weaponInst(level, rarity) constructor {

	type = itemTypes.weapon;

	name = "none";
	damage = new damageProfile();
	damage.kin = 12;
	lvl = level;
	rar = rarity;
	
	bonusStats = {};
	
}

function scr_weapons_collectWeapon(char, weapon, equip) {
	
	if (!instance_exists(char)) exit;
    
	var slot = {}
	
	if (is_instanceof(weapon, gunInst)) {
		
		//weapon.ammo = equippedWeapon.clipSize;
		
	    slot = {
	        weapon: weapon,
	        stats: scr_guns_calculateGunStats(char, weapon)
	    };
		
	} else if (is_instanceof(weapon, meleeInst)) {

		slot = {
			weapon: weapon,
			stats: scr_melee_calculateMeleeStats(char, weapon)
	    };
		
	} else {
	
		exit;
	
	}
    
    array_push(char.weapons, slot);
    
	if (equip) scr_weapons_equipWeapon(char, array_length(char.weapons) - 1);
	
}

function scr_weapons_equipWeapon(char, index) {

    if (!instance_exists(char)) return false;

    var len = array_length(char.weapons);

    if (index < 0 or index >= len) return false;

    char.weaponIndex = index;

    var slot = char.weapons[index];

    char.equippedWeapon = slot.weapon;
    char.equippedWeaponStats = slot.stats;
	
    return true;

}

function scr_weapons_replaceWeapon(char, index, gun) {

    if (!instance_exists(char)) return undefined;

    var oldSlot = char.weapons[index];
    var oldWeapon = oldSlot.weapon;

	var newSlot = {};
	
	if (is_instanceof(weapon, gunInst)) {
		
		weapon.ammo = gun.clipSize;
		
	    newSlot = {
	        weapon: weapon,
	        stats: scr_guns_calculateGunStats(char, weapon)
	    };
		
	} else if (is_instanceof(weapon, meleeInst)) {
		
		newSlot = {
			weapon: weapon,
			stats: scr_melee_calculateMeleeStats(char, weapon)
	    };
		
	} else {
	
		exit;
	
	}

    char.weapons[index] = newSlot;

    if (char.weaponIndex == index) {
        scr_weapons_equipWeapon(char, index);
    }

    return oldWeapon;

}

function scr_weapons_applyWeaponBonusesToChar(weapon, char) {
	
	if (!instance_exists(char)) exit;
	if (!is_instanceof(weapon, weaponInst)) exit;
	
	var bonusStats = weapon.bonusStats;
	var charStats = char.stats;
	
	var keys = variable_struct_get_names(bonusStats);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
		
		var key = keys[i];
		var amount = bonusStats[$ key];
		
		scr_stats_alterStat(charStats, key, amount);
		
	}
	
}

function scr_weapons_calculateBonusDamage(startingDam, level) {

	var low = max(1, floor(startingDam * (0.05 * level)));
	var high = max(1, ceil(startingDam * (0.15 * level)));
	
	return {
		low: low,
		high: high
	}
	
}

function scr_weapon_getHighestDamageType(weapon) {

	if (!is_instanceof(weapon, weaponInst)) return undefined;

	var damage = weapon.damage;
	var keys = ["kin", "fire", "chem", "elec", "rad"];

	var highest = -1;
	var best = [];

	for (var i = 0; i < array_length(keys); i++) {

		var key = keys[i];
		var val = damage[$ key];

		if (val > highest) {

			highest = val;
			best = [key];

		} else if (val == highest) {

			array_push(best, key);

		}

	}

	var key = best[irandom(array_length(best) - 1)];

	return {
		key: key,
		val: highest
	};

}

function scr_weapon_pickFromTop2DamageTypes(weapon) {

	if (!is_instanceof(weapon, weaponInst)) return undefined;

	var damage = weapon.damage;
	var keys = ["kin", "fire", "chem", "elec", "rad"];

	var highest = -1;
	var second = -1;

	// Find highest and second-highest non-zero values
	for (var i = 0; i < array_length(keys); i++) {

		var val = damage[$ keys[i]];
		if (val <= 0) continue;

		if (val > highest) {

			second = highest;
			highest = val;

		} else if (val > second and val < highest) {

			second = val;

		}

	}

	// No non-zero damage
	if (highest < 0) return undefined;

	// Collect all damage types matching the highest or second-highest values
	var best = [];

	for (var i = 0; i < array_length(keys); i++) {

		var key = keys[i];
		var val = damage[$ key];

		if (val <= 0) continue;

		if (val == highest or val == second) {
			array_push(best, key);
		}

	}

	var key = best[irandom(array_length(best) - 1)];

	return {
		key: key,
		val: damage[$ key]
	};

}