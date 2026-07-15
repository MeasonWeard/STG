event_inherited();

//hash cell
if (movedThisStep) {

	var cell = scr_hash_getCellAt(x, y);

	var newCellX = cell.xx;
	var newCellY = cell.yy;

	if (newCellX != hashCellX or newCellY != hashCellY) {
	
		scr_hash_remove(global.stageController.destHash, id, hashCellX, hashCellY);
	
		hashCellX = newCellX;
		hashCellY = newCellY;
	
		scr_hash_add(global.stageController.destHash, id, hashCellX, hashCellY);
	
	}
	
}

//depopulate melee hit immunity
var len = array_length(meleeHitList) - 1

for (var i = len; i >= 0; i--) {

    var entry = meleeHitList[i];

    if (!instance_exists(entry)) {
        array_delete(meleeHitList, i, 1);
        continue;
    }

}

//destroy
if (hp <= 0) {
	
	if (is_callable(destroyFunc)) destroyFunc();
	
	if (destroySound != undefined) scr_audio_playSoundAt(destroySound, x, y);
	
	var contentsLen = array_length(contents);
	
	for (var i = 0; i < contentsLen; i ++) {
	
		var item = contents[i];
		
		var obj = item.obj;
		var chance = item.chance;
		var maxVal = item.maxVal;
		
		if (object_is_ancestor(obj, obj_item)) {
		
			//resources
			if (object_is_ancestor(obj, obj_resource)) {
				
				if (scr_random_chance(chance)) {
				
					var minVal = ceil(maxVal * resMinFactor);
					var val = irandom_range(minVal, maxVal);
				
					if (val <= resStackSize) {
					
						scr_items_spawn(obj, x, y, val, true);
					
					} else {
						
						var fullStacks = val div resStackSize;
						var remainder = val mod resStackSize;
						
						repeat(fullStacks) {
							scr_items_spawn(obj, x, y, resStackSize, true);
						}
						
						if (remainder > 0) {
						    scr_items_spawn(obj, x, y, remainder, true);
						}
					
					}
					
				}
				
				
			} else {
				
				//other items
				repeat(maxVal) {
				
					if (scr_random_chance(chance)) scr_items_spawn(obj, x, y, 1, true);
				
				}
				
			}
		
		} else if (obj == obj_lootOrb) {
		
			scr_loot_dropLoot(chance, lootMaxRarity, lootImproveChance, maxVal);
		
		} else {
		
			repeat(maxVal) {
			
				if (scr_random_chance(chance)) instance_create_layer(x, y, "Instances", obj);
			
			}
		
		}

	}
	
	instance_destroy();
	
}