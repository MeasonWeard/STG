projectiles = 10;
damage = new damageProfile();

depth = layers.effects;
image_alpha = 0.85;


setup = true;

delay = 28;
shootDelay = 4;
shootTick = 0;

spinSpeed = 10;

scale = 1;

owner = noone;

equippedWeapon = new gunInst();

dir = 0;
spd = 18;
range = 1600;

explosionRadius = 60;

scr_audio_playSoundAt(snd_antimatterCharge, x, y);