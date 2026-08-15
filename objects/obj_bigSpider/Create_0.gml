// Inherit the parent event
event_inherited();

name = "Spider Drone";
tags = ["mech"];
bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

sprites = {

	up: spr_bigSpider,
	down: spr_bigSpider,
	left: spr_bigSpider,
	right: spr_bigSpider,
	death: spr_bigSpider,
	spawn: spr_bigSpider
	
}

//sprites.death = spr_spiderDroneDeath;
deathSounds = [snd_droneDeath1, snd_droneDeath2];

gun1 = new gun_bigSpiderGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

gunYoffset = -32;

//stats
baseStats.maxHp = 120;
baseStats.spd = 4;
baseStats.elecRes = -10;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.radDam += 1;
	}
	
	baseStats.fireDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
	if (level > 3) baseStats.maxShield = 1;
	if (level > 9) baseStats.maxShield = 2;
	if (level > 12) baseStats.maxShield = 3;
	
}