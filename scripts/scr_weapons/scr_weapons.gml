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

function scr_weapons_getHighestDamageType(weapon, randomiseTies = true) {

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

	var key;

	if (randomiseTies) {
		key = best[irandom(array_length(best) - 1)];
	} else {
		key = best[0];
	}

	return {
		key: key,
		val: highest
	};

}

function scr_weapons_getTop2DamageTypes(weapon, randomiseTies = true) {

	if (!is_instanceof(weapon, weaponInst)) return [];

	var damage = weapon.damage;
	var keys = ["kin", "fire", "chem", "elec", "rad"];

	var entries = [];

	// Build list of non-zero damage types
	for (var i = 0; i < array_length(keys); i++) {

		var key = keys[i];
		var val = damage[$ key];

		if (val > 0) {
			array_push(entries, {
				key: key,
				val: val
			});
		}

	}

	if (array_length(entries) == 0) return [];

	var result = [];

	repeat (2) {

		if (array_length(entries) == 0) break;

		// Find highest value remaining
		var highest = -1;
		var best = [];

		for (var i = 0; i < array_length(entries); i++) {

			var entry = entries[i];

			if (entry.val > highest) {

				highest = entry.val;
				best = [entry];

			} else if (entry.val == highest) {

				array_push(best, entry);

			}

		}

		// Resolve ties
		var chosen;

		if (randomiseTies) {
			chosen = best[irandom(array_length(best) - 1)];
		} else {
			chosen = best[0];
		}

		array_push(result, chosen);

		// Remove chosen so next iteration finds the next distinct type
		for (var i = 0; i < array_length(entries); i++) {

			if (entries[i].key == chosen.key) {
				array_delete(entries, i, 1);
				break;
			}

		}

	}

	return result;

}

function scr_weapons_pickFromTop2DamageTypes(weapon, randomiseTies = true) {

	var top = scr_weapons_getTop2DamageTypes(weapon, randomiseTies);

	if (array_length(top) == 0) return undefined;

	return top[irandom(array_length(top) - 1)];
	
}