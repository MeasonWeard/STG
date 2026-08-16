event_inherited();

name = "Four Guns";
tags = ["bio"];
bloodCol = c_red;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

var gun1 = new gun_bigMutantGun(1, 1);

scr_weapons_collectWeapon(self, gun1, true);

sprites = {

	left: spr_fourGuns,
	right: spr_fourGuns,
	up: spr_fourGuns,
	down: spr_fourGuns,
	death: spr_fourGuns,
	spawn: spr_fourGuns
	
}

//targetMinDist = 30;
//targetMaxDist = 60;
//targetReaquireDist = 90;

//targetMinDist = 180;
//targetMaxDist = 360;
//targetReaquireDist = 450;

targetMinDist = 120;
targetMaxDist = 240;
targetReaquireDist = 320;

gunDist = 80;

//stats
baseStats.maxHp = 300;
baseStats.kinRes = 6;
baseStats.fireRes = 6;
baseStats.chemRes = 6;
baseStats.radRes = 6;
baseStats.spd += 1.5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
		
			baseStats.kinDam += 2;
			
			baseStats.kinRes += 5;
			baseStats.fireRes += 5;
			baseStats.chemRes += 5;
			baseStats.elecRes += 3;
			baseStats.radRes += 5;
			
	}
	
	baseStats.kinDamPerc += 10;
	
	if (level > 5) baseStats.spd += 0.02;
	
}

minData = 32;
maxData = 64;