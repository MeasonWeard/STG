event_inherited();

name = "Plant";
tags = ["bio","plant"];
bloodCol = #325412;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathSounds = global.data.soundProfiles.plantDeath;

w1 = new melee_tree(1, 1);
scr_weapons_collectWeapon(self, w1, true);
w2 = new gun_treeGun(1, 1);
scr_weapons_collectWeapon(self, w2, false);

sprites = {

	up: spr_treeGuyHealer,
	down: spr_treeGuyHealer,
	left: spr_treeGuyHealer,
	right: spr_treeGuyHealer,
	death: spr_treeGuyDeath,
	spawn: spr_treeGuyHealer
	
}

baseStats.maxHp = 280;
baseStats.hpRegen = 4;
baseStats.maxEnergy = 100;

baseStats.fireRes = -20;
baseStats.kinRes = 6;
baseStats.chemRes = 6;
baseStats.elecRes = 12;
baseStats.da += 10;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
		
			baseStats.kinDam += 2;
			baseStats.chemDam += 1;
			
			baseStats.kinRes += 3;
			baseStats.chemRes += 3;
			baseStats.elecRes += 6;
			
	}
	
	if (level mod 4 == 0) {
	
		scr_skills_increaseLevel(self, 1);
	
	}
	
	baseStats.healingPerc += 2;
	
	baseStats.chemDamPerc += 5;
	baseStats.kinDamPerc += 5;
	
	baseStats.hpRegen += 0.25;
	baseStats.energyRegen += 0.2;
	
	baseStats.oa ++;
	baseStats.da ++;
	if (level mod 3 == 0) baseStats.da ++;

}

targetMinDist = 30;
targetMaxDist = 60;
targetReaquireDist = 90;

minData = 32;
maxData = 64;

lootChance = 6;
lootImproveChance = 20;
lootAmount = 2;

skillCheckIndex = scr_timeSlicing_assignTurnIndex("skillCheck");
skills.skill1 = new skill_medicalExosomes();

charHash = global.stageController.charHash;