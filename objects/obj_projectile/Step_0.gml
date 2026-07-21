if (!active) exit;

xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

var nextX = x + xspd;
var nextY = y + yspd;

if (rot == 0) {
	image_angle = dir;
} else {
	image_angle += rot;
}

//char collison
var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
var len = array_length(nearby);

for (var i = 0; i < len; i++) {
	
	var char = nearby[i];
	
	if (!instance_exists(char)) continue;
	if (instance_exists(source) and char.id == source.id) continue;
	if (char.faction == faction) continue;
	
	if (point_in_rectangle(x, y, char.colLeft, char.colTop, char.colRight, char.colBottom)) {
		
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
		
		var hitOutcome = scr_stats_hitOutcome(oa, char.stats.da);
		
		var profile = char.shield > 0 ? shieldHitSounds : char.bulletHitSounds;
		var snd = scr_audio_randomSoundFromProfile(profile);
		if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	
		
		scr_char_damage(char, damage, damageTypes.projectile, false, hitOutcome);
		
		if (charHitReport) audio_play_sound(snd_hitMarker, 0, false);
		if (instance_exists(global.player) and char == global.player) audio_play_sound(snd_playerHit, 0, false);

		active = false;
	
		var eff = instance_create_layer(safeX, safeY, "Instances", obj_bulletEffect);
		eff.sprite_index = destroyEffect;
		
		var hitTop = (dir > 180 and dir < 360 and y <= char.colTop + spd);
		
		if (hitTop) {
			eff.depth = char.depth + 1;
		} else {
			eff.depth = char.depth - 1;
		}
		
		if (is_callable(collisionFunc)) collisionFunc(self);
		if (is_callable(char.bulletHitFunc)) char.bulletHitFunc(self, char);
	
		exit;
		
	}
	
}

if (damageDestructibles) {

	nearby = scr_hash_getNearby(global.stageController.destHash, x, y);
	len = array_length(nearby);
	
	for (var i = 0; i < len; i++) {
	
		var dest = nearby[i];
	
		if (!instance_exists(dest)) continue;
	
		if (point_in_rectangle(x, y, dest.colLeft, dest.colTop, dest.colRight, dest.colBottom)) {
		
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
		
			var hitTop = (dir > 180 and dir < 360 and y <= dest.colTop + spd);
		
			if (hitTop) {
				eff.depth = dest.depth + 1;
			} else {
				eff.depth = dest.depth - 1;
			}

			if (is_callable(collisionFunc)) collisionFunc(self);
			if (is_callable(dest.bulletHitFunc)) dest.bulletHitFunc(self, dest);
	
			exit;
		
		}
	
	}
	
}

//env collison
nearby = scr_hash_getNearby(global.stageController.envHash, x, y);
len = array_length(nearby);

for (var i = 0; i < len; i++) {
	
	var env = nearby[i];
	
	if (!instance_exists(env)) continue;
	if (instance_exists(source) and env.id == source.id) continue;
	if (env.onGround) continue;
	
	if (point_in_rectangle(x, y, env.colLeft, env.colTop, env.colRight, env.colBottom)) {
		
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
	
		var profile = env.bulletHitSounds;
		var snd = scr_audio_randomSoundFromProfile(profile);
		if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	

		active = false;
	
		var eff = instance_create_layer(safeX, safeY, "Instances", obj_bulletEffect);
		eff.sprite_index = destroyEffect;
		
		var hitTop = (dir > 180 and dir < 360 and y <= env.colTop + spd);
		
		if (hitTop) {
			eff.depth = env.depth + 1;
		} else {
			eff.depth = env.depth - 1;
		}

		if (is_callable(collisionFunc)) collisionFunc(self);
		if (is_callable(env.bulletHitFunc)) env.bulletHitFunc(self, env);
	
		exit;
		
	}
	
}

x = nextX;
y = nextY;

rangeLeft -= spd;

if (rangeLeft <= 0) active = false;

if (x <= global.roomLeft or x >= global.roomRight or y <= global.projectileTop or y >= global.roomBottom) {
	
	x = clamp(x, global.roomLeft, global.roomRight);
	y = clamp(y, global.projectileTop, global.roomBottom);
	
	var eff = instance_create_layer(x, y, "Instances", obj_bulletEffect);
	eff.sprite_index = destroyEffect;
	if (is_callable(collisionFunc)) collisionFunc(self);
	
	var profile = global.data.soundProfiles.bulletHitMetal;
	var snd = scr_audio_randomSoundFromProfile(profile);
	if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	

	active = false;
		
}

depth = layers.physical -y - 32;