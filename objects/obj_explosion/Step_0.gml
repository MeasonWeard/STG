event_inherited();

if (firstStep) {

	firstStep = false;

	//sound
	var snd = scr_audio_randomSoundFromProfile(sounds);
	if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF_EXPLOSION, FALLOFF_FACTOR_EXPLOSION, false, 0);

	//damage
	if (radius > 0) {
	
		var nearby = scr_hash_getNearby(sc.charHash, x, y);
		var nearbyLen = array_length(nearby);
	
		for (var i = 0; i < nearbyLen; i++) {
	
			var char = nearby[i];
			//no need to check if the instance exists. circleDistSq checks that and returns -1 if it doesn't
			var distSq = scr_obj_circleDistSq(x, y, radius, char);
			if (distSq < 0) continue;
		
			var dist = sqrt(distSq);
			var falloff = 1 - (dist / radius);
			var mult = max(0.05, falloff); 
			
			damage = scr_stats_multiplyDamageProfile(damage, mult);
			
			scr_char_damage(char, damage, undefined, true);
		
		}
	
	}
	
}