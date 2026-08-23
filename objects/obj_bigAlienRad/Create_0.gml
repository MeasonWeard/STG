event_inherited();

name = "Alien";
tags = ["bio"];
bloodCol = c_navy;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_bigRadAlienSpit(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

mw = new melee_alienSlap(1, 1);
scr_weapons_collectWeapon(self, mw, false);

mw.damage.chem = 0;
mw.damage.rad = 3;


sprites = {

	up: spr_bigAlienRad,
	down: spr_bigAlienRad,
	left: spr_bigAlienRad,
	right: spr_bigAlienRad,
	death: spr_bigAlienRad,
	spawn: spr_bigAlienRad
	
}

//stats
baseStats.maxHp = 200;
baseStats.maxEnergy = 60;
baseStats.radRes = 15;
baseStats.chemRes = 10;
baseStats.da += 5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.chemDam += 1;
			baseStats.radDam += 2;
			scr_skills_increaseLevel(self, skills.skill1);
			baseStats.energyRegen += 1;
	}

	baseStats.maxEnergy += 4;
	baseStats.chemDamPerc += 10;
	baseStats.radDamPerc += 10;
	baseStats.radResPerc += 4;
	baseStats.chemResPerc += 4;
	
	baseStats.oa ++;
	baseStats.da ++;
	
}

skillCheckIndex = scr_timeSlicing_assignTurnIndex("skillCheck");
skills.skill1 = new skill_particleShower();
skills.skill1.level = 2;

//warning = instance_create_layer(x, y, "Instances", obj_warning);
//warning.owner = self;
//warning.timerMax = 18;
//warning.useAim = true;
//warning.