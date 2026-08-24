if (!active) exit;

event_inherited();

audio_listener_position(x, y, 0);

//xp
if (!sc.hub and instance_exists(rc)) {
	
	var levelUp = false;
	
	var dataCollected = variable_struct_exists(rc.resources, "data") ? rc.resources.data.val: 0;

	if (dataCollected > xpEarned) {

		var newXp = dataCollected - xpEarned;
		xpEarned = dataCollected;
		
		xp += newXp;
		
		while(xp >= xpRequired) {
		
			levelUp = true;
			level ++;
			xp -= xpRequired;
			
			xpRequired = scr_progression_xpRequired(level);
			
		}
		
	}
	
	if (levelUp) {
	
		var eff = instance_create_layer(x, y, "Instances", obj_levelUp);
		eff.owner = self;
		global.hud.unspentPoints = true;
	
	}
	
}

//
if (getNearbyEnv) {

	getNearbyEnv = false;
	
	nearbyEnv =	scr_hash_getNearbyCell(
		global.stageController.envHash,
		hashCellX,
		hashCellY
	);
	
}

//teleport
if (teleport) {

	teleport = false;
	
	var mx = room_width * 0.5;
	var my = room_height * 0.5;
	
	var px = mx;
	var py = my;
	
	var doors = [];
	
	with (obj_door) {
	
		array_push(doors, self);
	
	}
	
	var chosenDoor = scr_randomElement(doors);
	
	if (instance_exists(chosenDoor)) {
		px = chosenDoor.x;
		py = chosenDoor.y;
		
		if (chosenDoor.side == "top") py += 200;
		if (chosenDoor.side == "bottom") py -= 200;
		if (chosenDoor.side == "left") px += 200;
		if (chosenDoor.side == "right") px -= 200;
		
	}
	
	var col = true;
	var tries = 0;
	var inc = 0;
	
	while (col and tries < 400) {
	
		var nearby = scr_hash_getNearby(sc.envHash, px, py);
		var nearbyLen = array_length(nearby);
		
		tries ++;
		
		if (tries mod 10 == 0) inc++;
		
		col = false;
		
		for (var i = 0; i < nearbyLen; i++) {
		
			var env = nearby[i];
			if (!instance_exists(env)) continue;
			if (!env.solid) continue;
			
			if (scr_obj_movementCollisionAt(self, env, px, py, true)) {
				col = true;
				break;
			}
			
		}
		
		if (col) {
		
			var minRad = inc * 50;
			var maxRad = minRad + 50;
			var point = scr_randomPointInCircleMinDist(mx, my, maxRad, minRad);
			
			px = clamp(point.xx, 12, room_width - 12);
			py = clamp(point.yy, 12, room_height - 12);
		
		}
	
	}
	
	instance_create_layer(px, py, "Instances", obj_closingPortal);
	scr_movement_teleport(self, px, py);
	
}