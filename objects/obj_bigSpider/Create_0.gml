// Inherit the parent event
event_inherited();

name = "Big Spider";
tags = ["mech"];
bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

sprites = {

	up: spr_bigSpider,
	down: spr_bigSpider,
	left: spr_bigSpider,
	right: spr_bigSpider,
	death: spr_bigSpiderDeath,
	spawn: spr_bigSpider
	
}

deathSounds = [snd_bigSpiderDeath];

gun1 = new gun_bigSpiderGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

gunYoffset = -32;

//stats
baseStats.maxHp = 120;
baseStats.spd = 5;
baseStats.elecRes = -10;
baseStats.kinRes = 10;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.radDam += 1;
			baseStats.kinRes += 5;
	}
	
	baseStats.kinDamPerc += 10;
	
	if (level > 6) baseStats.maxShield = 1;
	if (level > 9) baseStats.maxShield = 2;
	if (level > 12) baseStats.maxShield = 3;
	if (level > 18) baseStats.maxShield = 4;
	if (level > 24) baseStats.maxShield = 5;
	
}

evolveLevel = 8;
evolveChanceMin = 10;
evolveChanceMax = 60;
evolutions = [obj_bigSpiderFire, obj_bigSpiderElectric];

minData = 32;
maxData = 64;

lootChance = 6;
lootImproveChance = 20;
lootAmount = 2;