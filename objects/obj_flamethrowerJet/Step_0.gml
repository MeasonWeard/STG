event_inherited();

if (!instance_exists(controller)) {
	instance_destroy();
	exit;
}

var ang = controller.orbitAngle + angleOffset;

// Anchor the blade's sprite origin to the orbit circle
x = controller.x + lengthdir_x(controller.orbitRadius, ang);
y = controller.y + lengthdir_y(controller.orbitRadius, ang);

scr_movement_updateCollisionHitBox(self);

// Point outward from the centre
image_angle = ang;

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
				
			scr_char_damage(char, damage, undefined, false);
				
			var snd = scr_audio_randomSoundFromProfile(damageSounds);
			if (snd != undefined) scr_audio_playSoundAt(snd, x, y); 
			
		}
		
	}

	
}