if (instance_exists(owner)) {

	x = owner.x;
	y = owner.y;
	
	if(t > 0) {
		
		t--;
		
	} else {
		
		t = 60;
		ticks --;
		
		alpha = 0.6;
		
		var nearby = scr_hash_getNearbyRange(charHash, x, y, 2);
		var nearbyLen = array_length(nearby);
		
		for (var i = 0; i < nearbyLen; i++) {
		
			var char = nearby[i];
			
			if (!instance_exists(char)) continue;
			
			if (char.faction != faction) continue;
			
			if (!scr_char_hasTag(char, "bio")) continue;
			
			var dist = point_distance(x, y, char.x, char.y);
			
			if (dist > range) continue;
			
			scr_char_heal(char, heal);
			
		}
		
	}
	
	if (ticks < 1) {
		instance_destroy();
		exit;
	}
	
} else {
	
	instance_destroy();
	
}

if (audio_emitter_exists(emitter)) {
	audio_emitter_position(emitter, x, y, 0);
}