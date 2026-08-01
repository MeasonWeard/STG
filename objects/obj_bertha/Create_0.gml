event_inherited();

name = "Bertha";
tags = ["bio"];
bloodCol = c_red;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

var slash = new melee_berthaSlash(1, 1);

scr_weapons_collectWeapon(self, slash, true);

thornsDamage = new damageProfile();
thornsDamage.kin = 4;

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

levelUpFunc = function() {

	baseStats.maxHp += 4;
	baseStats.kinDamPerc += 10;
	
	if (level > 5) baseStats.spd += 0.02;
	
}