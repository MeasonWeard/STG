if (getStats or setup) {
	
	getStats = false;
	setup = false;
	var finalStats = player.finalStats;
	
	txtCore = scr_stats_formatCharCore(finalStats);
	txtDef = scr_stats_formatCharDefence(finalStats);
	txtOff = scr_stats_formatCharOffence(finalStats);
	
}

itemsDirty = stashController.itemsDirty;

if (itemsDirty) {
	
	itemsDirty = false;
	
	if (instance_exists(player)) {

		player.gear = stashController.equippedGear;
		
		var w1 = stashController.equippedWeapons.weapon1;
		var w2 = stashController.equippedWeapons.weapon2;
		
		player.weapons = [];
		player.equippedWeapon = undefined;
		
		if (is_instanceof(w1, weaponInst)) scr_weapons_collectWeapon(player, w1, true);
		if (is_instanceof(w2, weaponInst)) scr_weapons_collectWeapon(player, w2, false);	
		
		player.setupStats = true;
		
		getStats = true;
		
	}
	
}

stashController.itemsDirty = false;