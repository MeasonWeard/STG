if (instance_exists(source)) {

	var move = true;

	var meleeX = source.gunX;
	var meleeY = source.gunY;

	var aimX = source.aimX;
	var aimY = source.aimY;

	var dir = point_direction(meleeX, meleeY, aimX, aimY);

	if (hitDelay < 1) {

		move = !stopOnHit;

		if (tick < attackFrames) {
	
			var lineStartX;
			var lineStartY;
			var lineEndX;
			var lineEndY;

			if (damageInLine) {

				var lineStartOffset = source.meleeRangeOffset + range;

				lineStartX = meleeX + lengthdir_x(lineStartOffset, dir);
				lineStartY = meleeY + lengthdir_y(lineStartOffset, dir);

				lineEndX = lineStartX + lengthdir_x(lineLength, dir);
				lineEndY = lineStartY + lengthdir_y(lineLength, dir);

			}
	
			//chars
			var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
			var len = array_length(nearby);
			var doCollisionFuncs = false;

			for (var i = 0; i < len; i++) {

				var char = nearby[i];
	
				if (!instance_exists(char)) continue;
				if (char.id == source.id) continue;
				if (char.faction == source.faction) continue;
		
				var col = false;
				
				if (damageInRadius) {
				
					var nearestX = clamp(x, char.colLeft, char.colRight);
					var nearestY = clamp(y, char.colTop, char.colBottom);

					var dist = point_distance(x, y, nearestX, nearestY);

					if (dist <= radius) col = true;
					
				} else if (damageInLine) {
					
					col = scr_physics_collisionLineRectangle(
						lineStartX,
						lineStartY,
						lineEndX,
						lineEndY,
						char.colLeft,
						char.colTop,
						char.colRight,
						char.colBottom
					);
					
					
				} else {
				
					col = bbox_right > char.colLeft and bbox_left < char.colRight
					and bbox_bottom > char.colTop and bbox_top < char.colBottom;
				
				}
		
				if (col) {
			
					if (!scr_melee_alreadyHit(char, self)) {
					
						hitX = char.x;
						hitY = char.y;
						
						doCollisionFuncs = true;
					
						var hitOutcome = scr_stats_hitOutcome(oa, char.finalStats.da);
						
						if (char.shield > 0) {
							var snd = scr_audio_randomSoundFromProfile(shieldSounds);
							if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
						}
						
						var dealt = scr_char_damage(char, damage, damageTypes.melee, false, hitOutcome);
					
						if (lifeSteal > 0 and dealt > 0) {

							var heal = (lifeSteal * 0.01) * dealt;
							
							if (source.lifeStealForSelf) scr_char_heal(source, heal);
							if (source.lifeStealForOwner and instance_exists(source.owner)) scr_char_heal(source.owner, heal);
							
						}
					
						var dec = killThreshold * 0.01;
						var threshHp = char.maxHp * dec;
						if (char.hp <= threshHp) char.hp = 0;
				
						var snd = scr_audio_randomSoundFromProfile(hitSounds);
						if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
					
						array_push(char.meleeHitList, self);
					
						if (is_callable(char.bulletHitFunc)) char.bulletHitFunc(self, char);
							
					}

				}
				
			}
		
			//collision functions
			if (doCollisionFuncs) {
					
					var funcsLen = array_length(collisionFuncs);
						
					for (var j = 0; j < funcsLen; j ++) {
						var func = collisionFuncs[j];
						if (is_callable(func)) func(self);
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
			
			//env
			if (damageEnv and tick == 0) {
				
				nearby = scr_hash_getNearby(global.stageController.envHash, x, y);
				len = array_length(nearby);
				
				for (var i = 0; i < len; i ++) {
				
					var env = nearby[i];
					
					if (!instance_exists(env)) continue;
					
					if (env.smashable) {
					
						var col = false;
				
						if (damageInRadius) {
				
							var nearestX = clamp(x, env.colLeft, env.colRight);
							var nearestY = clamp(y, env.colTop, env.colBottom);

							var dist = point_distance(x, y, nearestX, nearestY);

							if (dist <= radius) col = true;
					
						} else if (damageInLine) {
					
							col = scr_physics_collisionLineRectangle(
								lineStartX,
								lineStartY,
								lineEndX,
								lineEndY,
								env.colLeft,
								env.colTop,
								env.colRight,
								env.colBottom
							);
					
					
						} else {
				
							col = bbox_right > env.colLeft and bbox_left < env.colRight
							and bbox_bottom > env.colTop and bbox_top < env.colBottom;
				
						}
					
						if (col) env.smashed = true;
					
					}
					
					if (object_is_ancestor(env.object_index, obj_wall)) {
		
						if (instance_exists(env.decoration)) {
			
							var dec = env.decoration;
			
							if (dec.smashable and !dec.smashed) {
	
								dec.smashed  = bbox_right > dec.bbox_left and bbox_left < dec.bbox_right
								and bbox_bottom > dec.bbox_top and bbox_top < dec.bbox_bottom;
								
							}
		
						}
		
					}
				
				}
				
			}
	
		}

		tick ++;
	
	}
	
	if (move) {
		
		var offset = source.meleeRangeOffset + range;
		var attackX = meleeX + lengthdir_x(offset, dir);
		var attackY = meleeY + lengthdir_y(offset, dir);

		x = attackX;
		y = attackY;
	
	}

}

if (hitDelay > 0) {
	hitDelay --;	
}

