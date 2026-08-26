if (!active) exit;

var funcsLen = array_length(collisionFuncs);
var sourceExists = instance_exists(source);

xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

var nextX = x + xspd;
var nextY = y + yspd;

var moveX = lengthdir_x(1, dir);
var moveY = lengthdir_y(1, dir);

if (rot == 0) {
	image_angle = dir;
} else {
	image_angle += rot;
}

var keepDepth = false;

//char collison
var hash = global.stageController.charHash;

for (var k = 0; k < 9; k++) {
	
	var key = charHashKeys[k];
	
	if (!variable_struct_exists(hash, key)) continue;
	
	var nearby = hash[$ key];
	var len = array_length(nearby);

	for (var i = 0; i < len; i++) {
	
		var char = nearby[i];
	
		if (!instance_exists(char)) continue;
		if (sourceExists and char.id == source.id) continue;
		if (char.faction == faction) continue;
	
		var col = point_in_rectangle(nextX, nextY, char.colLeft, char.colTop, char.colRight, char.colBottom);
	
		//var col = scr_physics_lineIntersectsRectangle(x, y, nextX, nextY, char.colLeft,
		//	char.colTop, char.colRight, char.colBottom);
	
		if (col) {
		
			var safeX = x;
			var safeY = y;
			var hitX = nextX;
			var hitY = nextY;
	
			repeat (4) {
		
				var midX = (safeX + hitX) * 0.5;
				var midY = (safeY + hitY) * 0.5;
		
				if (point_in_rectangle(midX, midY, char.colLeft, char.colTop, char.colRight, char.colBottom)) {
					hitX = midX;
					hitY = midY;
				} else {
					safeX = midX;
					safeY = midY;
				}
		
			}
		
			var hitOutcome = scr_stats_hitOutcome(oa, char.finalStats.da);
		
			var profile = char.shield > 0 ? shieldHitSounds : char.bulletHitSounds;
			var snd = scr_audio_randomSoundFromProfile(profile);
			if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	
		
			var dealt = scr_char_damage(char, damage, damageTypes.projectile, false, hitOutcome);
		
			if (lifeSteal > 0 and dealt > 0 and sourceExists) {
						
				var heal = (lifeSteal * 0.01) * dealt;
			
				if (source.lifeStealForSelf) scr_char_heal(source, heal);
				if (source.lifeStealForOwner and instance_exists(source.owner)) scr_char_heal(source.owner, heal);
							
			}
		
			if (charHitReport) audio_play_sound(snd_hitMarker, 0, false);
			if (instance_exists(global.player) and char == global.player) audio_play_sound(snd_playerHit, 0, false);

			active = false;
	
			var eff = instance_create_layer(safeX, safeY, "Instances", obj_bulletEffect);
			eff.sprite_index = destroyEffect;
			eff.image_angle = image_angle;
		
			var hitTop = (dir > 180 and dir < 360 and y <= char.colTop + spd);
		
			if (hitTop) {
				eff.depth = char.depth + 1;
			} else {
				eff.depth = char.depth - 1;
			}
		
			for (var j = 0; j < funcsLen; j ++) {
				var func = collisionFuncs[j];
				if (is_callable(func)) func(self);
			}
		
			if (is_callable(char.bulletHitFunc)) char.bulletHitFunc(self, char);
	
			exit;
		
		}
	
	}

}


//destructible collision
if (damageDestructibles) {

	if (is_undefined(nearbyDest)) {
		nearbyDest = scr_hash_getNearby(global.stageController.destHash, x, y);
	}

	var nearby = nearbyDest;
	var len = array_length(nearby);
	
	for (var i = 0; i < len; i++) {
	
		var dest = nearby[i];
	
		if (!instance_exists(dest)) continue;
	
		var col = point_in_rectangle(nextX, nextY, dest.colLeft, dest.colTop, dest.colRight, dest.colBottom);
	
		//var col = scr_physics_lineIntersectsRectangle(x, y, nextX, nextY, dest.colLeft,
		//dest.colTop, dest.colRight, dest.colBottom);
	
		if (col) {
		
			var safeX = x;
			var safeY = y;
			var hitX = nextX;
			var hitY = nextY;
	
			repeat (4) {
		
				var midX = (safeX + hitX) * 0.5;
				var midY = (safeY + hitY) * 0.5;
		
				if (point_in_rectangle(midX, midY, dest.colLeft, dest.colTop, dest.colRight, dest.colBottom)) {
					hitX = midX;
					hitY = midY;
				} else {
					safeX = midX;
					safeY = midY;
				}
		
			}
	
			scr_env_damage(dest, damage, undefined, false);
			
			var profile = dest.bulletHitSounds;
			var snd = scr_audio_randomSoundFromProfile(profile);
			if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	

			active = false;
	
			var eff = instance_create_layer(safeX, safeY, "Instances", obj_bulletEffect);
			eff.sprite_index = destroyEffect;
			eff.image_angle = image_angle;
		
			var hitTop = (dir > 180 and dir < 360 and y <= dest.colTop + spd);
		
			if (hitTop) {
				eff.depth = dest.depth + 1;
			} else {
				eff.depth = dest.depth - 1;
			}

			for (var j = 0; j < funcsLen; j ++) {
				var func = collisionFuncs[j];
				if (is_callable(func)) func(self);
			}
			
			if (is_callable(dest.bulletHitFunc)) dest.bulletHitFunc(self, dest);
	
			exit;
		
		}
	
	}
	
}

//env collison
if (is_undefined(nearbyEnv)) {
	nearbyEnv = scr_hash_getNearby(global.stageController.envHash, x, y);
}

var nearby = nearbyEnv;
var len = array_length(nearby);

//don't shoot through env
if (checkObstruction and sourceExists) {
	
	checkObstruction = false;
		
	var result = scr_projectiles_checkObstruction(source, nearby, dir);

	if (result.hit) {

		var env = result.env;
		
		if (env.projCollision) {
		
			var safeX = result.xx;
			var safeY = result.yy;
		
			scr_projectiles_hitEnv(self, env, safeX, safeY);
			exit;
		
		}

	}
	
}

for (var i = 0; i < len; i++) {
	
	var env = nearby[i];
	
	if (!instance_exists(env)) continue;
	if (instance_exists(source) and env.id == source.id) continue;
	if (env.onGround) continue;
	if (!env.projCollision) continue;
	
	//skip if higher
	if (height > env.height) {
		keepDepth = true;
		depth = env.depth - 1;
		continue;
	}
	
	//detect collision
	
	var col = point_in_rectangle(nextX, nextY, env.colLeft, env.colTop, env.colRight, env.colBottom);
	
	//var col = scr_physics_lineIntersectsRectangle(x, y, nextX, nextY, env.colLeft, env.colTop,
	//	env.colRight, env.colBottom);
	
	if (col) {
		
		var safeX = x;
		var safeY = y;
		var hitX = nextX;
		var hitY = nextY;
		
		repeat (4) {
		
			var midX = (safeX + hitX) * 0.5;
			var midY = (safeY + hitY) * 0.5;
		
			if (point_in_rectangle(midX, midY, env.colLeft, env.colTop, env.colRight, env.colBottom)) {
				hitX = midX;
				hitY = midY;
			} else {
				safeX = midX;
				safeY = midY;
			}
		
		}
	
		scr_projectiles_hitEnv(self, env, safeX, safeY);
		
		exit;
	
	}
	
}

//move
if (!sc.pictureMode) {
	
	x = nextX;
	y = nextY;

	rangeLeft -= spd;

	if (rangeLeft <= 0) active = false;

	if (x <= global.roomLeft or x >= global.roomRight or y <= global.projectileTop or y >= global.roomBottom) {

		x = clamp(x, global.roomLeft, global.roomRight);
		y = clamp(y, global.projectileTop, global.roomBottom);
	
		var eff = instance_create_layer(x, y, "Instances", obj_bulletEffect);
		eff.sprite_index = destroyEffect;
		eff.image_angle = image_angle;
	
		for (var i = 0; i < funcsLen; i ++) {
			var func = collisionFuncs[i];
			if (is_callable(func)) func(self);
		}
	
		var profile = global.data.soundProfiles.bulletHitMetal;
		var snd = scr_audio_randomSoundFromProfile(profile);
		if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	

		active = false;
		
	}

	if (!keepDepth) depth = -y - 32;

}