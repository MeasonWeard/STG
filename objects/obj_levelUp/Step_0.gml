if (instance_exists(owner)) {

	x = owner.x;
	y = owner.y - owner.sprite_height * 0.5;
	
}

soundDelay --;

if (soundDelay == 0) audio_play_sound(snd_levelUp, 0, false);