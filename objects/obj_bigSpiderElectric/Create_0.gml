// Inherit the parent event
event_inherited();

name = "Fire Spider";
tags = ["mech"];
bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

sprites = {

	up: spr_bigSpiderElectric,
	down: spr_bigSpiderElectric,
	left: spr_bigSpiderElectric,
	right: spr_bigSpiderElectric,
	death: spr_bigSpiderDeath,
	spawn: spr_bigSpider
	
}

deathSounds = [snd_bigSpiderDeath];

gun1 = new gun_bigSpiderElectricGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

gunYoffset = -32;

//stats
baseStats.maxHp = 120;
baseStats.maxEnergy = 100;
baseStats.spd = 5;
baseStats.elecRes = -10;

levelUpFunc = function() {

	if (level > 2) {
		baseStats.maxHpPerc += 10;
		baseStats.maxEnergyPerc += 5;
	}
	
	if (level > 8 and level mod 4 == 0) {
	
		scr_skills_increaseLevel(self, skills.skill1);
	
	}
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.elecDam += 1;
	}
	
	baseStats.elecDamPerc += 10;
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

//skills
skills.skill1 = new skill_EMP();

skillCheckIndex = scr_timeSlicing_assignTurnIndex("skillCheck");

warning = instance_create_layer(x, y, "Instances", obj_warning);

warning.owner = self;
warning.radius = 150;
warning.timerMax = 46;
warning.useAim = false;