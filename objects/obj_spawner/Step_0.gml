if (active and initialSpawn) {

	initialSpawn = false;
	
	var spawns = irandom_range(minEnemies, maxEnemies);
	
	repeat(spawns) {
	
		var obj = scr_random_weightedPick(commonList);
	
		if (object_exists(obj)) {
		
			var inst = instance_create_layer(x, y, "Instances", obj);
		
			var tries = 0;
			var col = true;
			
			while (tries < 50 and col) {
				
				tries++;
				
				var pt = scr_char_chooseSpawnPoint(inst, x, y, 32, 96);
			
				inst.x = pt.xx;
				inst.y = pt.yy;
					
				scr_movement_updateCollisionHitBox(inst);
				scr_movement_updateMovementHitBox(inst);
				
				var nearby = scr_hash_getNearby(sc.envHash, pt.xx, pt.yy);
				var nearbyLen = array_length(nearby);
				
				col = false;
				
				for (var i = 0; i < nearbyLen; i++) {
				
					var env = nearby[i];
					
					if (!instance_exists(env)) continue;
					
					if (scr_obj_collision(inst, env, true)) {
						col = true;
						break;
					}
				
				}
				
			}
			
			if (col) {
				instance_destroy(inst);
				continue;
			}
				
		}
	
	}
	
}