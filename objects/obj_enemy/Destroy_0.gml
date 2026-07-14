if (instance_exists(ghost)) instance_destroy(ghost);

//drop data
scr_items_dropData(x, y, minData, maxData);

//drop stimpack
scr_items_drop(obj_stimPack, x, y, 2, undefined, true);

//drop energypack
scr_items_drop(obj_energyPack, x, y, 2, undefined, true);

//loot
scr_loot_dropLoot(lootChance, lootMaxRarity, lootImproveChance, lootAmount);