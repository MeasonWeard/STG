owner = noone;

life = 3;
lifeTick = 0;

jetCount = 4;

faction = undefined;
damage = undefined;

orbitRadius = 40;
orbitAngle = 0;
orbitSpd = -1.6;

jets = [];

createJets = true;

yOffset = - 64;

damTime = 1;

emitter = audio_emitter_create();

audio_emitter_position(emitter, x, y, 0);
audio_emitter_falloff(emitter, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR);

sound = audio_play_sound_on(emitter, snd_flamethrower, true, 0);
