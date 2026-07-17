event_inherited();

if (setup) {

	setup = false;
	
	if (spawnChance < 100) {
	
		var seed = scr_obj_generateSeed(self);
		random_set_seed(seed);
		
		if (!scr_random_chance(spawnChance)) {
			dropOnDestroy = false;
			instance_destroy();
		}
		
		randomise();
	
	}
	
	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.destHash, id, hashCellX, hashCellY);
	
}