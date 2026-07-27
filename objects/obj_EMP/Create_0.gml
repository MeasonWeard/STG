owner = noone;
damage = undefined;
radius = 100
mechBonus = 10;

jitterTick = 0;
jitter = 2;

life = 90;

var snd = scr_audio_randomSoundFromProfile("emp");
scr_audio_playSoundAt(snd, x, y);

flashAlpha = 1;
jitterAlpha = 3;

doDamage = true;

depth = layers.effects;