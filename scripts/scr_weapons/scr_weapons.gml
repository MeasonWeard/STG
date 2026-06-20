function weaponInst() constructor {

	name = "none";
	damage = new damageProfile();
	damage.kin = 12;
	
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