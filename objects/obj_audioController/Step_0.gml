if (settingsVersion != global.settingsVersion) {

	settingsVersion = global.settingsVersion;

	var newMusVol = scr_data_getSetting("musicVolume", 1);
	var newSfxVol = scr_data_getSetting("sfxVolume", 1);

	musVolume = newMusVol;

	if (music != noone and music != undefined) audio_sound_gain(music, musVolume, 1);

	audio_group_set_gain(audiogroup_sfx, newSfxVol, 0);

}