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
	
	}
	
}