if (!active) exit;

xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

var nextX = x + xspd;
var nextY = y + yspd;

//char collison
var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
var len = array_length(nearby);

for (var i = 0; i < len; i++) {
	
	var char = nearby[i];
	
	if (!instance_exists(char)) continue;
	if (char.id == source.id) continue;
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
	
		scr_char_damage(char, damage, undefined, false);
		//char.hp -= damage;
		var profile = char.bulletHitSounds;
		var snd = scr_audio_randomSoundFromProfile(profile);
		if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	
		if (charHitReport) audio_play_sound(snd_hitMarker, 0, false);
		if (instance_exists(global.player) and char == global.player) audio_play_sound(snd_playerHit, 0, false);

		
		active = false;
	
		var eff = instance_create_layer(safeX, safeY, "Instances", obj_bulletEffect);
		eff.sprite_index = destroyEffect;
		if (is_callable(collisionFunc)) collisionFunc(self);
		if (is_callable(char.bulletHitFunc)) char.bulletHitFunc(self, char);
	
		exit;
		
	}
	
}

x = nextX;
y = nextY;

image_angle = dir;

rangeLeft -= spd;

if (rangeLeft <= 0) active = false;

if (x <= global.roomLeft or x >= global.roomRight or y <= global.projectileTop or y >= global.roomBottom) {
	
	x = clamp(x, global.roomLeft, global.roomRight);
	y = clamp(y, global.projectileTop, global.roomBottom);
	
	var eff = instance_create_layer(x, y, "Instances", obj_bulletEffect);
	eff.sprite_index = destroyEffect;
	if (is_callable(collisionFunc)) collisionFunc(self);
	active = false;
	
}