var newMusVol = scr_data_getUpdatedSetting("musicVolume", 1);
var newSfxVol = scr_data_getUpdatedSetting("sfxVolume", 1);

if (newMusVol != undefined) {

	musVolume = newMusVol;
	if (music != noone and music != undefined) audio_sound_gain(music, musVolume, 1);
	
}

if (newSfxVol != undefined) {

	audio_group_set_gain(audiogroup_sfx, newSfxVol, 0);
	
}