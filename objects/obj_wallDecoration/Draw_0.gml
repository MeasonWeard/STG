draw_self();

if (smashable) {

	image_speed = 0;

	if (smashed) {
		
		image_index = 1;
		
		if (prevSmashed == false) scr_audio_playSoundAt(smashSound, x, y, false);
		
	} else {
		image_index = 0;	
	}
	
}

prevSmashed = smashed;