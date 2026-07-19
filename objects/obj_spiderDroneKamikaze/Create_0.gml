// Inherit the parent event
event_inherited();

name = "Kamikaze Spider Drone";

bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

//deathFunc = scr_char_fleshExplosion;

sprites.death = spr_spiderDroneDeath;
deathSounds = [snd_droneDeath1, snd_droneDeath2];

explosionPower = 4;
explodeDist = 40;

deathFunc = function() {

	scr_effects_explosion(x, y, explosionPower);
	
}

baseStats.maxHp = 40;
baseStats.spd = 7;

gunYoffset = -32;

targetMinDist = 10;
targetMaxDist = 30;
targetReaquireDist = 40;