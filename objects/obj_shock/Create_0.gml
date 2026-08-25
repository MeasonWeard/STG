owner = noone;
depth = layers.effects;
faction = undefined;

image_angle = irandom_range(0, 359);
image_blend = c_aqua;

image_xscale = 0.75;
image_xscale = 0.75;

targets = 4;
range = 460;

life = 60;

//pulse = sin(current_time * 0.03) * 2;

damage = undefined;

targetList = [];

setup = true;

jitter = 2;
jitterTick = 0;

lightningPoints = [];

scr_audio_playSoundAt(snd_zap, x, y);