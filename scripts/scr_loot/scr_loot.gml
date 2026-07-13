function scr_loot_rollLevel(lootLevel) {

    if (lootLevel <= 0) return 0;

    var level = 0;
    var denom = lootLevel + 3;

    while (level < lootLevel) {

        var chance = (lootLevel - level) / denom * 100;

        if (!scr_random_chance(chance)) break;

        level++;

    }

    return level;

}

function scr_loot_dropLoot(chance, level) {
	
	var drops = 0;

	while (chance >= 1) {

	    if (chance >= 100) {
	        drops++;
	    }
	
	    else if (scr_random_chance(chance)) {
	        drops++;
	    }

	    chance *= 0.5;
	
	}

	repeat(drops) {

		var lootLevel = scr_loot_rollLevel(level);
		var loot = scr_items_spawn(obj_lootOrb, x, y, 1, true);
		loot.level = lootLevel;
		
	}

}

function scr_loot_getRarityInfo(level) {

	static rarities = global.data.rarities;
	static keys = variable_struct_get_names(rarities);
	static keysLen = array_length(keys);
	
	var info = undefined;
	var highest = -1;
	
	for (var i = 0; i < keysLen; i++) {
	
		var key = keys[i];
		var rarity = rarities[$ key];
		
		if (level >= rarity.level and rarity.level > highest) {
			
			highest = rarity.level;
			info = rarity;
			if (level == rarity.level) break;
		
		}
	
	}
	
	return info;
	
}

function scr_loot_generateGenericLoot(level) {

	var loot = noone;
	var type = choose("gun","melee","device","tie","headgear");
	
	if (type == "gun") {
		
		loot = new gunInst();
		
	}
	
	if (type == "melee") {
		
		loot = new meleeInst();
		
	}
	
	if (type == "device") {
		
		var devType = choose("laserPointer", "watch", "powerBank");
		if (devType == "lasterPointer") loot = scr_devices_laserPointer(level);
		if (devType == "watch") loot = scr_devices_watch(level);
		if (devType == "powerBank") loot = scr_devices_powerBank(level);
		
	}
	
	if (type == "tie") {
		
		loot = new tieInst();
		
	}
	
	if (type == "headgear") {
		
		loot = new headgearInst();
		
	}
	
	return loot;
	
}