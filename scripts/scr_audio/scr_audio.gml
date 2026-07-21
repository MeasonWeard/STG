function scr_audio_randomSound(array) {

	var snd = scr_randomElement(array);
	
	if (snd == undefined) return snd_silence;
	
	return snd;
	
}

function scr_audio_randomSoundFromProfile(profile) {

	static profiles = global.data.soundProfiles;
	
	var arr = [];
	
	if (is_array(profile)) {
		
		arr = profile;
		
	} else {
		
		if (!variable_struct_exists(profiles, profile)) return undefined;
		arr = variable_struct_get(profiles, profile);
		
	}
	
	var snd = scr_audio_randomSound(arr);
	
	return snd;
	
}

function scr_audio_setMusic(sound, loop, restartSame) {
	
	if (sound == noone or sound == undefined) exit;
	
	var controller = global.audioController;

	var volume = scr_data_getSetting("musicVolume", 1);

	if (!instance_exists(controller)) exit;

	if (!restartSame) {
	
		if (controller.music != noone) {
		
			if (controller.musicAsset == sound) {
				exit;	
			}
		
		}
	
	}

	if (controller.music != noone) {

		if (audio_is_playing(controller.music)) {
			audio_stop_sound(controller.music);
		}
	}


	controller.music = audio_play_sound(sound, 10, loop);
	controller.musicAsset = sound;
	
	audio_sound_gain(controller.music, volume, 0);
	
}

function scr_audio_setAmbience(track, sound, loop) {
	
	if (sound == noone or sound == undefined) exit;
	
	var controller = global.audioController;
	
	if (!instance_exists(controller)) exit;
		
		if (track == 1) {
		
			if (controller.ambience1 != noone) {
			
				if (audio_is_playing(controller.ambience1)) {
					audio_stop_sound(controller.ambience1);
				}
			}

			controller.ambience1 = audio_play_sound(sound, 10, loop);
		

		}

		if (track >= 2) {

			if (controller.ambience2 != noone) {
			
				if (audio_is_playing(controller.ambience2)) {
					audio_stop_sound(controller.ambience2);
				}
			}

			controller.ambience2 = audio_play_sound(sound, 10, loop);
		}
	
}

function scr_audio_stopAmbience(track) {
	
	var controller = global.audioController;
	
	if (!instance_exists(controller)) exit;
	
	if (track == 1) {
		if (controller.ambience1 != noone) {
			
			if (audio_is_playing(controller.ambience1)) {
				audio_stop_sound(controller.ambience1);
			}
			
			controller.ambience1 = noone;
			
		}
	}
	
	if (track >= 2) {
		if (controller.ambience2 != noone) {
			
			if (audio_is_playing(controller.ambience2)) {
				audio_stop_sound(controller.ambience2);
			}
			
			controller.ambience2 = noone;
			
		}
	}
	
}

function scr_audio_stopMusic() {
	
	var controller = global.audioController;

	if (!instance_exists(controller)) exit;

	if (controller.music != noone) {

		if (audio_is_playing(controller.music)) {
			audio_stop_sound(controller.music);
		}
		
		controller.music = noone;
		controller.musicAsset = undefined;
		
	}
	
}

function scr_audio_playSoundAt(snd, xx, yy) {

	audio_play_sound_at(snd, xx, yy, 0, MIN_FALLOFF_BULLETHIT, MAX_FALLOFF_BULLETHIT, FALLOFF_FACTOR_BULLETHIT, false, 0);	
	
}