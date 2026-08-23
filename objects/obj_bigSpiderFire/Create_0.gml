// Inherit the parent event
event_inherited();

name = "Electric Spider";
tags = ["mech"];
bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

sprites = {

	up: spr_bigSpiderFire,
	down: spr_bigSpiderFire,
	left: spr_bigSpiderFire,
	right: spr_bigSpiderFire,
	death: spr_bigSpiderDeath,
	spawn: spr_bigSpider
	
}

deathSounds = [snd_bigSpiderDeath];

gun1 = new gun_bigSpiderFireGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

gunYoffset = -32;

//stats
baseStats.maxHp = 120;
baseStats.maxEnergy = 100;
baseStats.spd = 5;
baseStats.elecRes = -10;

skills.skill1 = new skill_flamethrower();

levelUpFunc = function() {

	if (level > 2) {
		baseStats.maxHpPerc += 10;
		baseStats.maxEnergyPerc += 5;
	}
	
	if (level > 8 and level mod 4 == 0) {
	
		skills.skill1.level ++;
	
	}
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.fireDam += 1;
	}
	
	baseStats.fireDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
	if (level > 6) baseStats.maxShield = 1;
	if (level > 9) baseStats.maxShield = 2;
	if (level > 12) baseStats.maxShield = 3;
	if (level > 18) baseStats.maxShield = 4;
	if (level > 24) baseStats.maxShield = 5;
	
}

minData = 32;
maxData = 64;

lootChance = 6;
lootImproveChance = 20;
lootAmount = 2;

skillCheckIndex = scr_timeSlicing_assignTurnIndex("skillCheck");