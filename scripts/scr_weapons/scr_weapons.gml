function weaponInst(level, rarity) constructor {

	type = itemTypes.weapon;

	name = "none";
	damage = new damageProfile();
	damage.kin = 12;
	baseDamage = 12;
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

function scr_weapons_clearDamage(weapon) {

	if (!is_instanceof(weapon, weaponInst)) exit;
	
	weapon.damage.kin = 0;
	weapon.damage.fire = 0;
	weapon.damage.chem = 0;
	weapon.damage.elec = 0;
	weapon.damage.rad = 0;
	
}

function scr_weapons_addDamage(weapon, damType, val) {

	if (!is_instanceof(weapon, weaponInst)) exit;

	var damage = weapon.damage;
	
	if (!variable_struct_exists(damage, damType)) exit;
	
	var oldVal = 0;
	
	if (!is_undefined(damage[$ damType])) oldVal = damage[$ damType];
	
	var newVal = oldVal + val;
	
	damage[$ damType] = newVal;
	
}

function scr_weapons_addDamageToExisting(weapon, val) {

	if (!is_instanceof(weapon, weaponInst)) exit;

	var damage = weapon.damage;
	var valid = [];

	var damTypes = [
		"kin",
		"fire",
		"chem",
		"elec",
		"rad"
	];

	for (var i = 0; i < array_length(damTypes); i++) {

		var key = damTypes[i];

		if (variable_struct_exists(damage, key) and damage[$ key] > 0) {
			array_push(valid, key);
		}

	}

	if (array_length(valid) == 0) exit;

	var damType = valid[irandom(array_length(valid) - 1)];
	damage[$ damType] += val;

}

function scr_weapons_addDamageToExistingSpread(weapon, amount) {

	if (!is_instanceof(weapon, weaponInst)) exit;

	var damage = weapon.damage;
	var damTypes = [
		"kin",
		"fire",
		"chem",
		"elec",
		"rad"
	];

	var validCount = 0;

	for (var i = 0; i < array_length(damTypes); i++) {

		var key = damTypes[i];

		if (variable_struct_exists(damage, key) and damage[$ key] > 0) {
			validCount++;
		}

	}

	if (validCount == 0) exit;

	amount = round(amount);
	if (amount <= 0) exit;

	// No need to split if only one damage type exists
	if (validCount == 1) {

		scr_weapons_addDamageToExisting(weapon, amount);
		exit;

	}

	var chunks = [];
	var remaining = amount;

	while (remaining > 0) {

		var chunk = min(remaining, irandom_range(2, 4));

		array_push(chunks, chunk);
		remaining -= chunk;

	}

	array_shuffle(chunks);

	for (var i = 0; i < array_length(chunks); i++) {

		scr_weapons_addDamageToExisting(weapon, chunks[i]);

	}


}

function scr_weapons_addDamageToTypesSpread(weapon, amount, damTypes) {

	if (!is_instanceof(weapon, weaponInst)) exit;
	if (!is_array(damTypes)) exit;

	var validTypes = [];
	var allTypes = ["kin", "fire", "chem", "elec", "rad"];

	// Keep duplicates so they act as weights
	for (var i = 0; i < array_length(damTypes); i++) {

		var key = damTypes[i];

		if (array_contains(allTypes, key)) {
			array_push(validTypes, key);
		}

	}

	var validCount = array_length(validTypes);

	if (validCount == 0) exit;

	amount = round(amount);

	if (amount <= 0) exit;

	// No need to split if only one type was supplied
	if (validCount == 1) {

		scr_weapons_addDamage(weapon, validTypes[0], amount);
		exit;

	}

	var chunks = [];
	var remaining = amount;

	while (remaining > 0) {

		var chunk = min(remaining, irandom_range(2, 4));

		array_push(chunks, chunk);
		remaining -= chunk;

	}

	array_shuffle(chunks);

	for (var i = 0; i < array_length(chunks); i++) {

		var key = validTypes[irandom(validCount - 1)];
		scr_weapons_addDamage(weapon, key, chunks[i]);

	}
	
}

function scr_weapons_getBaseDamage(weapon) {
	
	if (!is_instanceof(weapon, weaponInst)) exit;
	
	return weapon.baseDamage;
	
}

function scr_weapons_setBaseDamage(weapon, dam, element, clearDamage = true) {

	if (!is_instanceof(weapon, weaponInst)) exit;
	
	if (clearDamage) scr_weapons_clearDamage(weapon);
	
	if (is_undefined(weapon.damage[$ element])) return false;
	
	weapon.damage[$ element] = dam;
	weapon.baseDamage = dam;
	
	return true;
	
}

function scr_weapons_applyBaseDamageAcrossTypes(weapon, damTypes, numberOfTypes) {

	if (!is_array(damTypes) or array_length(damTypes) < 1) return weapon;

	var baseDamage = weapon.baseDamage;
	//var damagePortion = round(baseDamage / numberOfTypes);
	var keys = [];
	
	repeat(numberOfTypes) {
		
		var key = scr_randomElementRemove(damTypes);
		if (is_string(key)) array_push(keys, key);
		
	}
	
	scr_weapons_clearDamage(weapon);
	scr_weapons_addDamageToTypesSpread(weapon, baseDamage, keys);
	
	//var keysLen = array_length(keys);
	
	//for (var i = 0; i < keysLen; i ++) {
	
	//	var el = keys[i];
	//	weapon.damage[$ el] = damagePortion;
		
	//}
	
	return weapon;
	
}