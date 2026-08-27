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
			
			if (char.faction == faction) continue;
			if (distSq < 0) continue;
		
			if (!scr_physics_hasLineOfSight(x, y, char.x, char.y)) continue;
		
			var dist = sqrt(distSq);
			
			var progress = clamp(dist / radius, 0, 1);
			var mult = max(0.05, power(1 - progress, 2));
			
			if (!variable_struct_exists(damage, "kinMin")) damage = scr_stats_calculateDamageProfileRanges(damage);
			
			var finalDamage = scr_stats_multiplyDamageProfile(damage, mult);
			
			scr_char_damage(char, finalDamage, undefined, true);
		
		}
		
		nearby = scr_hash_getNearby(sc.envHash, x, y);
		nearbyLen = array_length(nearby);
	
		for (var i = 0; i < nearbyLen; i++) {
	
			var env = nearby[i];
			
			//no need to check if the instance exists. circleDistSq checks that and returns -1 if it doesn't
			var distSq = scr_obj_circleDistSq(x, y, radius, env);
			if (distSq < 0) continue;
		
			if (env.smashable) env.smashed = true;
			
			if (object_is_ancestor(env.object_index, obj_wall)) {
			
				if (instance_exists(env.decoration)) {
			
					var dec = env.decoration;

					if (dec.smashable and !dec.smashed) {
						
						distSq = scr_obj_circleDistSq(x, y, radius, dec);
						
						if (distSq >= 0) dec.smashed = true;
							
					}
		
				}
			
			}
		
		}
		
	
	}
	
}