if (instance_exists(owner)) {

	x = owner.gunX;
	y = owner.gunY;
	
	if (tick < attackFrames) {
	
		var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
		var len = array_length(nearby);

		for (var i = 0; i < len; i++) {

			var char = nearby[i];
	
			if (!instance_exists(char)) continue;
			if (char.id == owner.id) continue;
			if (char.faction == owner.faction) continue;
		
			if (
				bbox_right > char.colLeft and
				bbox_left < char.colRight and
				bbox_bottom > char.colTop and
				bbox_top < char.colBottom
			) {
			
				if (!scr_melee_alreadyHit(char, self)) {
					
					var hitOutcome = scr_stats_hitOutcome(oa, char.stats.da);
					
					scr_char_damage(char, damage, damageTypes.melee, false, hitOutcome);
					
					if (char.hp <= killThreshold) char.hp = 0;
				
					var snd = scr_audio_randomSoundFromProfile(hitSounds);
					if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
					
					array_push(char.meleeHitList, self);
					
					if (is_callable(char.bulletHitFunc)) char.bulletHitFunc(self, char);
						

					
				}

			}
	
		}
	
	}

}

tick ++;