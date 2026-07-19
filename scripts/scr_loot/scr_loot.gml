function scr_loot_rollLevel(maxLevel) {

    if (maxLevel <= 0) return 0;

    var minLevel = max(1, floor(maxLevel * 0.5));
    var level = minLevel;

    var firstChance = 75;
    var finalChance = 10;

    var increases = maxLevel - minLevel;

    while (level < maxLevel) {

        var step = level - minLevel;

        var progress = (increases <= 1) ? 1 : step / (increases - 1);

        var chance = lerp(firstChance, finalChance, progress);

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

function scr_loot_getRarityNum(rarityKey) {

	static rarities = global.data.rarities;
	static keys = variable_struct_get_names(rarities);
	static keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i++) {
	
		var key = keys[i];
		var info = rarities[$ key];
		
		if (rarityKey == key) {
			
			return info.num;
			
		}
			
	}
	
	return 0;
	
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

function scr_loot_addBonusStat(loot, stat, val) {

	if (!is_struct(loot)) exit;
	if (!variable_struct_exists(loot, "bonusStats")) exit;
	
	var stats = loot.bonusStats;
	
	var oldVal = 0;
	
	if (!is_undefined(stats[$ stat])) oldVal = stats[$ stat];
	
	var newVal = oldVal + val;
	
	stats[$ stat] = newVal;
	
}

function scr_loot_addDamage(weapon, damType, val) {

	if (!is_instanceof(weapon, weaponInst)) exit;

	var damage = weapon.damage;
	
	if (!variable_struct_exists(damage, damType)) exit;
	
	var oldVal = 0;
	
	if (!is_undefined(damage[$ damType])) oldVal = damage[$ damType];
	
	var newVal = oldVal + val;
	
	damage[$ damType] = newVal;
	
}

function scr_loot_generateGenericLoot(maxLevel, rarity) {

	var loot = noone;
	var type = choose("gun","melee","device","tie","headgear");
	
	var level = scr_loot_rollLevel(maxLevel);
	
	if (type == "gun") {
		
		var func = choose(scr_genGuns_blaster, scr_genGuns_pistol, scr_genGuns_smg, scr_genGuns_pulseRifle,
		scr_genGuns_shotgun, scr_genGuns_autoShotgun);
		loot = func(level, rarity);
		
	}
	
	if (type == "melee") {
		
		loot = new meleeInst(level, rarity);
		
	}
	
	if (type == "device") {
		
		var devType = choose("laserPointer", "watch", "powerBank");
		if (devType == "laserPointer") loot = scr_genDevices_laserPointer(level, rarity);
		if (devType == "watch") loot = scr_genDevices_watch(level, rarity);
		if (devType == "powerBank") loot = scr_genDevices_powerBank(level, rarity);
		
	}
	
	if (type == "tie") {
		
		loot = new tieInst(level, rarity);
		
	}
	
	if (type == "headgear") {
		
		loot = new headgearInst(level, rarity);
		
	}
	
	return loot;
	
}

function scr_loot_saveToStash(loot) {

	if (!is_array(loot)) return false;

	if (!variable_global_exists("gameData")) return false;
	
	if (!variable_struct_exists(global.gameData, "inventory")) {
		
		global.gameData.inventory = {
			devices: [],
			ties: [],
			headgear: [],
			guns: [],
			melee: []
		}
		
	}
	
	var inventory = global.gameData.inventory;
	
	var len = array_length(loot);
	
	for (var i = 0; i < len; i++) {
	
		var item = loot[i];
		
		if (!is_struct(item)) continue;
		
		if (is_instanceof(item, gunInst)) array_push(inventory.guns, item);
		if (is_instanceof(item, meleeInst)) array_push(inventory.melee, item);
		if (is_instanceof(item, deviceInst)) array_push(inventory.devices, item);
		if (is_instanceof(item, tieInst)) array_push(inventory.ties, item);
		if (is_instanceof(item, headgearInst)) array_push(inventory.headgear, item);
		
	}
	
	return true;
	
}