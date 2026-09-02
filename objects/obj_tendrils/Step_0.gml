event_inherited();

if (delay > 0) {
	
	delay --;
	
} else if (delay == 0) {

	image_speed = 1;

	var snd = scr_audio_randomSoundFromProfile(global.data.soundProfiles.cleaverSwing);

	scr_audio_playSoundAt(snd, x, y);
	
	delay = -1;
	
} 

if (image_index >= image_number - 1) instance_destroy();