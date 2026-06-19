if (active and initialSpawn) {

	initialSpawn = false;
	
	var spawns = irandom_range(minEnemies, maxEnemies);
	
	repeat(spawns) {
	
		var obj = scr_random_weightedPick(commonList);
	
		if (object_exists(obj)) {
		
			var inst = instance_create_layer(x, y, "Instances", obj);
		
			var pt = scr_char_chooseSpawnPoint(inst, x, y, 32, 96);
			
			inst.x = pt.xx;
			inst.y = pt.yy;
			
			scr_movement_updateCollisionHitBox(inst);
			scr_movement_updateMovementHitBox(inst);
		
		}
	
	}
	
}