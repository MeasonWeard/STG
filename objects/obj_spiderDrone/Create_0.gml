// Inherit the parent event
event_inherited();

name = "Spider Drone";
tags = ["mech"];
bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

sprites = {

	up: spr_spiderDrone,
	down: spr_spiderDrone,
	left: spr_spiderDrone,
	right: spr_spiderDrone,
	death: spr_spiderDrone,
	spawn: spr_spiderDrone
	
}

sprites.death = spr_spiderDroneDeath;
deathSounds = [snd_droneDeath1, snd_droneDeath2];

gun1 = new gun_spiderGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

gunYoffset = -32;

//stats
baseStats.maxHp = 40;
baseStats.spd = 6;
baseStats.da = 110;
baseStats.elecRes = -10;
baseStats.kinRes = 2;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.radDam += 1;
	}
	
	baseStats.da += 1;
	
	baseStats.radDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
	if (level > 6) baseStats.maxShield = 1;
	if (level > 12) baseStats.maxShield = 2;
	
}

//evolveLevel = 8;
//evolveChanceMin = 4;
//evolveChanceMax = 18;
//evolutions = [obj_bigSpider];