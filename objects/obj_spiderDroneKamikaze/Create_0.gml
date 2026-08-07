// Inherit the parent event
event_inherited();

name = "Kamikaze Spider Drone";
tags = ["mech"];
bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

sprites = {

	up: spr_kamikazeDrone,
	down: spr_kamikazeDrone,
	left: spr_kamikazeDrone,
	right: spr_kamikazeDrone,
	death: spr_kamikazeDrone,
	spawn: spr_kamikazeDrone
	
}

sprites.death = spr_spiderDroneDeath;
deathSounds = [snd_droneDeath1, snd_droneDeath2];

explosionPower = 4;
explodeDist = 40;

deathFunc = function() {

	scr_effects_explosion(x, y, explosionPower);
	
}

gunYoffset = -32;

targetMinDist = 10;
targetMaxDist = 30;
targetReaquireDist = 40;

//stats
baseStats.maxHp = 40;
baseStats.spd = 7;
baseStats.da = 115;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	explosionPower += 0.05;
	
	baseStats.da += 1;
	
	if (level > 6) baseStats.maxShield = 1;
	if (level > 12) baseStats.maxShield = 2;
	
}