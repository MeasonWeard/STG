owner = noone;
timer = 360;

posHistory = [];

storeTime = 1;
storeTick = 0;

maxHistory = 8;

maxAlpha = 0.35;

emitter = audio_emitter_create();

audio_emitter_position(emitter, x, y, 0);
audio_emitter_falloff(emitter, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR);

scr_audio_playSoundAt(snd_stimPac, x, y);
sound = audio_play_sound_on(emitter, snd_combatStimulant, true, 0);