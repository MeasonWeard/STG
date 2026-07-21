if (instance_exists(owner)) {

	var move = true;

	if (hitDelay < 1) {

		move = !stopOnHit;

		if (tick < attackFrames) {
	
			//chars
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
						
						if (char.shield > 0) {
							var snd = scr_audio_randomSoundFromProfile(shieldSounds);
							if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
						}
						
						scr_char_damage(char, damage, damageTypes.melee, false, hitOutcome);
					
						if (char.hp <= killThreshold) char.hp = 0;
				
						var snd = scr_audio_randomSoundFromProfile(hitSounds);
						if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
					

					
						array_push(char.meleeHitList, self);
					
						if (is_callable(char.bulletHitFunc)) char.bulletHitFunc(self, char);
						

					
					}

				}
	
			}
		
			//destructibles
			if (damageDestructibles) {
		
				nearby = scr_hash_getNearby(global.stageController.destHash, x, y);
				len = array_length(nearby);

				for (var i = 0; i < len; i++) {

					var dest = nearby[i];
	
					if (!instance_exists(dest)) continue;

					if (
						bbox_right > dest.colLeft and
						bbox_left < dest.colRight and
						bbox_bottom > dest.colTop and
						bbox_top < dest.colBottom
					) {
			
						if (!scr_melee_alreadyHit(dest, self)) {
					
							scr_env_damage(dest, damage, damageTypes.melee, false);
					
							var snd = scr_audio_randomSoundFromProfile(hitSounds);
							if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);

							array_push(dest.meleeHitList, self);
					
							if (is_callable(dest.bulletHitFunc)) dest.bulletHitFunc(self, dest);

						}

					}
	
				}
		
			}
	
		}

		tick ++;
	
	}
	
	if (move) {
		
		var meleeX = owner.gunX;
		var meleeY = owner.gunY;
		var aimX = owner.aimX;
		var aimY = owner.aimY;
		var offset = owner.meleeRangeOffset + range;
	
		var dir = point_direction(meleeX, meleeY, aimX, aimY);
	
		var attackX = meleeX + lengthdir_x(offset, dir);
		var attackY = meleeY + lengthdir_y(offset, dir);

		x = attackX;
		y = attackY;
	
	}

}

if (hitDelay > 0) {
	hitDelay --;	
}

