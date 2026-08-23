event_inherited();

name = "Four Guns";
tags = ["bio","mech"];
bloodCol = c_red;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

var gun1 = new gun_bigMutantPulseGun(1, 1);

scr_weapons_collectWeapon(self, gun1, true);

sprites = {

	left: spr_fourGunsPulse,
	right: spr_fourGunsPulse,
	up: spr_fourGunsPulse,
	down: spr_fourGunsPulse,
	death: spr_fourGunsPulse,
	spawn: spr_fourGunsPulse
	
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
baseStats.kinRes = 4;
baseStats.fireRes = 4;
baseStats.chemRes = 4;
baseStats.radRes = 4;
baseStats.spd += 1.5;
baseStats.da += 15;
baseStats.oa += 5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
		
			baseStats.kinDam += 2;
			
			baseStats.kinRes += 3;
			baseStats.fireRes += 3;
			baseStats.chemRes += 3;
			baseStats.elecRes += 2;
			baseStats.radRes += 3;
			
			baseStats.oa += 2;
				
	}
	
	baseStats.kinDamPerc += 10;
	
	if (level > 5) baseStats.spd += 0.02;
	
	baseStats.oa ++;
	baseStats.da ++;
	
	if (level mod 2 == 0) {
		baseStats.da ++;
		baseStats.oa ++;
	}
	
}

minData = 32;
maxData = 64;