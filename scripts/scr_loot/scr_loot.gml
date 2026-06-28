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