//movement
wiggleDir += wiggleStep;

if (wiggleDir >= 2) {
	wiggleDir = 2;
	wiggleStep = -abs(wiggleStep);
}

if (wiggleDir <= -2) {
	wiggleDir = -2;
	wiggleStep = abs(wiggleStep);
}

var perpDir = dir + 90;
var sideMove = wiggleDir * wiggleStrength;

var xMove = lengthdir_x(spd, dir);
var yMove = lengthdir_y(spd, dir);

xMove += lengthdir_x(sideMove, perpDir);
yMove += lengthdir_y(sideMove, perpDir);

x += xMove;
y += yMove;

colLeft = bbox_left;
colRight = bbox_right;
colTop = bbox_top;
colBottom = bbox_bottom;

depth = -y - 32;

//damage
if (damTick > 0) {
	
	damTick --;
	
} else {

	if (charges > 0) {
		
		damTick = damTime;

		var dec = 1 + bioBonus * 0.01;

		var nearby = scr_hash_getNearby(charHash, x, y);
		var len = array_length(nearby);
	
		for (var i = 0; i < len; i++) {
	
			var char = nearby[i];
		
			if (!instance_exists(char)) continue;
		
			if (char.faction == faction) continue;
	
			var col = scr_obj_collision(self, char, false);
		
			if (col) {
			
				var isBio = scr_char_hasTag(char, "bio");
			
				var dam = isBio? scr_stats_multiplyDamageProfile(damage, dec) : damage;
			
				scr_char_damage(char, dam, undefined, true);
			
				var snd = scr_audio_randomSoundFromProfile(damSounds);
				scr_audio_playSoundAt(snd, x, y);
			
				charges--;
				life -= 22;
				
			}
	
		}
	
	}
	
	if (charges < 1) life = min(life, 30);
	
}

if (envTick > 0) {
	
	envTick--;
	
} else {
	
	envTick = envTime;
	
	var nearby = scr_hash_getNearby(envHash, x, y);
	var len = array_length(nearby);
	
	var col = false;
	
	for (var i = 0; i < len; i++) {
	
		var env = nearby[i];
		if (!instance_exists(env)) continue;
		
		if(height > env.height) continue;
		
		col = scr_obj_collision(self, env, true);
		
		if (col) break;
			
	}
	
	var out = x > global.roomRight or x < global.roomLeft or y > global.roomBottom or y < global.roomTop; 
	
	if (out or col) {
	
		dir += 180 + irandom_range(-4, 4);
		
		//rot = random_range(-2, 2);
		
		x = lastSafeX;
		y = lastSafeY;
	
	} else {

		lastSafeX = x;
		lastSafeY = y;
	}
	
}

//fade
spd -= 0.001;

if (life < 30) {

	image_alpha -= .014;
	
}

if (life < 1) instance_destroy();

life--;

