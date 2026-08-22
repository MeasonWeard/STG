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

	up: spr_treeGuy,
	down: spr_treeGuy,
	left: spr_treeGuy,
	right: spr_treeGuy,
	death: spr_treeGuyDeath,
	spawn: spr_treeGuy
	
}

baseStats.maxHp = 280;
baseStats.hpRegen = 4;

baseStats.fireRes = -20;
baseStats.kinRes = 6;
baseStats.chemRes = 6;
baseStats.elecRes = 12;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
		
			baseStats.kinDam += 2;
			baseStats.chemDam += 1;
			
			baseStats.kinRes += 3;
			baseStats.chemRes += 3;
			baseStats.elecRes += 6;
			
	}
	
	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
	baseStats.hpRegen += 0.25;

}

targetMinDist = 30;
targetMaxDist = 60;
targetReaquireDist = 90;

minData = 32;
maxData = 64;

lootChance = 6;
lootImproveChance = 20;
lootAmount = 2;