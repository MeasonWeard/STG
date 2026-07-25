if (dealDamage) {

	dealDamage = false;
	
	var snd = scr_audio_randomSoundFromProfile(damageSounds);
	if (snd != undefined) scr_audio_playSoundAt(snd, x, y); 
	
	if (is_struct(damage)) {
		
		var nearby = scr_hash_getNearby(charHash, x, y);
		var nearbyLen = array_length(nearby);
			
		for (var i = 0; i < nearbyLen; i++) {
			
			var char = nearby[i];
			if (!instance_exists(char)) continue;
			if (char.faction == faction) continue;
				
			var nearestX = clamp(x, char.colLeft, char.colRight);
			var nearestY = clamp(y, char.colTop, char.colBottom);

			var dist = point_distance(x, y, nearestX, nearestY);

			if (dist > radius) continue;
				
			scr_char_damage(char, damage, undefined, false);
					
		}
		
	}
	
}