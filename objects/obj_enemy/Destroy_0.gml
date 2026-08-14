event_inherited();

if (dropOnDestroy) {

	//drop data
	scr_items_dropData(x, y, minData, maxData);

	//drop stimpack
	scr_items_drop(obj_stimPack, x, y, 1, undefined, true);

	//drop energypack
	scr_items_drop(obj_energyPack, x, y, 0.5, undefined, true);

	//loot
	scr_loot_dropLoot(lootChance, lootMaxRarity, lootImproveChance, lootAmount);

}

if (boss) {

	with(obj_enemy) {
		hp = 0;	
	}
	
}