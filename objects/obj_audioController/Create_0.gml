global.audioController = self;

audio_group_load(audiogroup_sfx);

music = noone;
ambience1 = noone;
ambience2 = noone;

musVolume = scr_data_getSetting("musicVolume", 1);

volumeCheck = 0;
volumeCheckFreq = 12;

audio_falloff_set_model(audio_falloff_linear_distance);