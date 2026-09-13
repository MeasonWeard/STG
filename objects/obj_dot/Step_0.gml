if (!instance_exists(owner)) {

	instance_destroy();
	exit;
	
} 

x = owner.x;
y = owner.y - owner.sprite_height * 0.5;
depth = owner.depth - 1;

if (t > 0) {

	t--;
	
} else {

	t = 60;
	ticks --;
	
	scr_char_damage(owner, damage, damageTypes.dot, true);
	
	var snd = scr_audio_randomSoundFromProfile(sounds);
	scr_audio_playSoundAt(snd, x, y);
	
}

if (ticks <= 0) instance_destroy();