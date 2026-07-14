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

function scr_loot_rollRarity(maxRarity, improveChance) {

    if (maxRarity <= 1) return 1;

    var rarity = 1;

	var chance = improveChance;
	
	while(rarity < maxRarity and scr_random_chance(chance)) {
	
		rarity ++;
		chance *= 0.5;
	
	}

    return rarity;

}

function scr_loot_dropLoot(chance, maxRarity, improveChance, maxAmount) {
	
	var drops = 0;

	while (chance >= 1 and drops < maxAmount) {

	    if (chance >= 100) {
	        drops++;
	    }
	
	    else if (scr_random_chance(chance)) {
	        drops++;
	    }

	    chance *= 0.5;
	
	}

	repeat(drops) {

		var rarity = scr_loot_rollRarity(maxRarity, improveChance);
		var loot = scr_items_spawn(obj_lootOrb, x, y, 1, true);
		loot.rarity = rarity;
		
	}

}

function scr_loot_getRarityInfo(rarity) {

	static rarities = global.data.rarities;
	static keys = variable_struct_get_names(rarities);
	static keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i++) {
	
		var key = keys[i];
		var info = rarities[$ key];

		if (rarity == info.num) {
			
			var newInfo = {};
			scr_data_structCopyInto(newInfo, info);
			
			newInfo.key = key;
			
			return newInfo;
			
		}
			
	}
	
	return undefined;
	
}

function scr_loot_addStat(loot, stat, val) {

	if (!is_struct(loot)) exit;
	if (!variable_struct_exists(loot, "stats")) exit;
	
	var stats = loot.stats;
	
	var oldVal = 0;
	
	if (!is_undefined(stats[$ stat])) oldVal = stats[$ stat];
	
	var newVal = oldVal + val;
	
	stats[$ stat] = newVal;
	
}

function scr_loot_generateGenericLoot(level, rarity) {

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
		if (devType == "lasterPointer") loot = scr_devices_laserPointer(level, rarity);
		if (devType == "watch") loot = scr_devices_watch(level, rarity);
		if (devType == "powerBank") loot = scr_devices_powerBank(level, rarity);
		
	}
	
	if (type == "tie") {
		
		loot = new tieInst();
		
	}
	
	if (type == "headgear") {
		
		loot = new headgearInst();
		
	}
	
	return loot;
	
}