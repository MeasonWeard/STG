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
		show_debug_message("collecting:");
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