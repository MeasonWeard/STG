event_inherited();

name = "Alien";
tags = ["bio"];
bloodCol = c_lime;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_bigAlienSpit(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

mw = new melee_alienSlap(1, 1);
scr_weapons_collectWeapon(self, mw, false);


sprites = {

	up: spr_bigToxicAlien,
	down: spr_bigToxicAlien,
	left: spr_bigToxicAlien,
	right: spr_bigToxicAlien,
	death: spr_bigToxicAlien,
	spawn: spr_bigToxicAlien
	
}

//stats
baseStats.maxHp = 200;
baseStats.maxEnergy = 60;
baseStats.radRes = 10;
baseStats.chemRes = 10;
baseStats.da += 5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.chemDam += 2;
			scr_skills_increaseLevel(self, skills.skill1);
			baseStats.energyRegen += 1;
	}

	baseStats.maxEnergy += 4;
	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 10;
	baseStats.radResPerc += 4;
	baseStats.chemResPerc += 4;
	
	baseStats.oa ++;
	baseStats.da ++;
	
}

skillCheckIndex = scr_timeSlicing_assignTurnIndex("skillCheck");
skills.skill1 = new skill_acidFlasks();
skills.skill1.spr = spr_alienAcid;