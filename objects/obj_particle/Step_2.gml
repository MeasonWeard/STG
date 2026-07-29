if (!active) exit;

if (playSound) {
	
	playSound = false;
	
	var snd = scr_audio_randomSoundFromProfile(sounds);
	scr_audio_playSoundAt(snd, x, y);
	
}

if (canDamage) {

	var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
	var len = array_length(nearby);

	for (var i = 0; i < len; i++) {
		
		var char = nearby[i];
		if (!instance_exists(char)) continue;
		if (char.faction == faction) continue;
		
		var col = (point_in_rectangle(x, y, char.colLeft, char.colTop, char.colRight, char.colBottom));
			
		if (col) {
		
			scr_char_damage(char, damage, undefined, false);
			
			var snd = scr_audio_randomSoundFromProfile(char.bulletHitSounds);
			scr_audio_playSoundAt(snd, x, y);
			
			canDamage = false;
			break;
		
		}
		
	}

}

if (tick >= maxLife) active = false;

tick ++;