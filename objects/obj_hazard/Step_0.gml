event_inherited();

if (active) {

	if (damTick > 0) {
	
		damTick --;
	
	} else {
		
		damTick = damTime * 60;
		
		if (is_struct(damage)) {
		
			var nearby = scr_hash_getNearby(charHash, x, y);
			var nearbyLen = array_length(nearby);
			
			for (var i = 0; i < nearbyLen; i++) {
			
				var char = nearby[i];
				if (!instance_exists(char)) continue;
				if (char.faction == faction) continue;
				
				if(!scr_obj_collision(self, char, true)) continue;
				
				scr_char_damage(char, damage, undefined, ignoreShield);
				
				var snd = scr_audio_randomSoundFromProfile(damageSounds);
				if (snd != undefined) scr_audio_playSoundAt(snd, x, y); 
			
			}
		
		}
		
	}

}

if (is_real(lifeTick)) {

	lifeTick--;
	
	if (lifeTick <= 0) instance_destroy();

	
}