owner = noone;
heal = 0;
ticks = 0;
range = 100;

faction = undefined;

t = 60;

charHash = global.stageController.charHash;

alpha = 0.3;

emitter = audio_emitter_create();

audio_emitter_position(emitter, x, y, 0);
audio_emitter_falloff(emitter, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR);

sound = audio_play_sound_on(emitter, snd_exosomes, true, 0);