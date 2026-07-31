if (!active) exit;

event_inherited();

audio_listener_position(x, y, 0);

//xp
//if (keyboard_check_pressed(ord("P"))) {
	
//	var eff = instance_create_layer(x, y, "Instances", obj_levelUp);
//	eff.owner = self;

//}

if (instance_exists(rc)) {
	
	var dataCollected = rc.resources[$ "data"] ?? 0;
	
	if (dataCollected > xpEarned) {
	
		var newXp = dataCollected - xpEarned;
		xpEarned = dataCollected;
		
		xp += newXp;
		
		while(xp >= xpRequired) {
		
			levelUp = true;
			level ++;
			xp -= xpRequired;
			
			xpRequired = scr_progression_xpRequired(level);
			
			var eff = instance_create_layer(x, y, "Instances", obj_levelUp);
			eff.owner = self;
		
		}
		
	}
	
}