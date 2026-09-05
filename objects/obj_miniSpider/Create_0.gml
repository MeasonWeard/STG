// Inherit the parent event
event_inherited();

name = "Pet Spider";
tags = ["mech"];
bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;
target = noone;

findTargetIndex = scr_timeSlicing_assignTurnIndex("findTarget");

sprites = {

	up: spr_miniSpider,
	down: spr_miniSpider,
	left: spr_miniSpider,
	right: spr_miniSpider,
	death: spr_miniSpider,
	spawn: spr_miniSpider
	
}

sprites.death = spr_spiderDroneDeath;
deathSounds = [snd_droneDeath1, snd_droneDeath2];

explosionPower = 3;
explodeDist = 15;
expEl = "kin";

deathFunc = function() {

	var ex = scr_effects_explosion(x, y, explosionPower);
	ex.sounds = global.data.soundProfiles.smallExplosion;
	
	var extraDam = explosionPower * 0.5;

	switch (expEl) {

		case "kinDamPerc":
			ex.damage.kin += extraDam;
			break;

		case "fireDamPerc":
			ex.damage.fire += extraDam;
			ex.col = global.data.elementCols.fire;
			break;

		case "chemDamPerc":
			ex.damage.chem += extraDam;
			ex.col = global.data.elementCols.chem;
			break;

		case "elecDamPerc":
			ex.damage.elec += extraDam;
			ex.col = global.data.elementCols.elec;
			break;

		case "radDamPerc":
			ex.damage.rad += extraDam;
			ex.col = global.data.elementCols.rad;
			break;

	}
	
}

gunYoffset = -32;

targetMinDist = 1;
targetMaxDist = 5;
targetReaquireDist = 20;

scr_ai_setup();
ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;
reTargetDist = 400;

//stats
baseStats.maxHp = 30;
baseStats.spd = 8.5;
baseStats.da = 250;