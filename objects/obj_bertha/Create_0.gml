event_inherited();

name = "Bertha";
tags = ["bio"];
bloodCol = c_red;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

var slash = new melee_berthaSlash(1, 1);

scr_weapons_collectWeapon(self, slash, true);

sprites = {

	left: spr_bertha,
	right: spr_bertha,
	up: spr_bertha,
	down: spr_bertha,
	death: spr_bertha,
	spawn: spr_bertha
	
}

targetMinDist = 30;
targetMaxDist = 60;
targetReaquireDist = 90;

//stats
baseStats.maxHp = 80;
baseStats.spd += 0.5;
baseStats.radRes = 3;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 2;
			baseStats.radRes += 2;
	}
	
	baseStats.kinDamPerc += 10;
	
	if (level > 5) baseStats.spd += 0.02;
	
	baseStats.oa ++;
	baseStats.da ++;
	
}

//evolveLevel = 8;
//evolveChanceMin = 3;
//evolveChanceMax = 12;
//evolutions = [obj_fourGuns];