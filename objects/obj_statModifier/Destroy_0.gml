if (instance_exists(owner) and active) {
	
	if (variable_instance_exists(owner, modName)) {
		variable_instance_set(owner, modName, noone);
	}
	
	owner.finalStats[$ statKey] -= amount;
	
	if (isResistance) {
		
		var range = scr_stats_calculateResistanceRange(owner.finalStats[$ statKey]);
		
		owner.finalStats[$ resMinKey] = range.minRes;
		owner.finalStats[$ resMaxKey] = range.maxRes;
		
	}
	
	if (isDamage) {
	
		scr_char_calculateWeaponStats(owner, false);
		scr_char_setupSkills(owner, false, false);
		scr_weapons_equipWeapon(owner, owner.weaponIndex);
	
	}
	
}