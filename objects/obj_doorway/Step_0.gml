// Inherit the parent event
event_inherited();

if (charCheckTick > 0) {

	charCheckTick--;
	
} else {
	
	open = false;
	
	charCheckTick = 8;
	
	for (var k = 0; k < 9 and !open; k++) {
	
		var key = charHashKeys[k];
	
		if (!variable_struct_exists(charHash, key)) continue;
	
		var nearby = charHash[$ key];
		var len = array_length(nearby);
	
		for (var i = 0; i < len; i++) {
	
			var char = nearby[i];
		
			if (!instance_exists(char)) continue;
		
			var dist = point_distance(x, y, char.x, char.y);
			
			if (dist <= charDist) {
			
				open = true;
				break;
			
			}
	
		}
		
	}
	
	
}

if (open) {

	projCollision = false;
	movementCollision = false;
	blockLos = false;
	
} else {
	
	projCollision = true;
	movementCollision = true;
	blockLos = true;
	
}

if (prevOpen != open) {


	if (open == true and openSound != undefined)  audio_play_sound_at(openSound, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT * 0.5, false, 0);	
	if (open == false and closeSound != undefined) audio_play_sound_at(closeSound, x, y, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT * 0.5, false, 0);	
	
}

prevOpen = open;