event_inherited();

name = "Alien";
tags = ["bio"];
bloodCol = c_purple;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_bigAlienSpit(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

mw = new melee_alienSlap(1, 1);
scr_weapons_collectWeapon(self, mw, false);


sprites = {

	up: spr_bigAlien,
	down: spr_bigAlien,
	left: spr_bigAlien,
	right: spr_bigAlien,
	death: spr_bigAlien,
	spawn: spr_bigAlien
	
}

//stats
baseStats.maxHp = 200;
baseStats.radRes = 10;
baseStats.da += 5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.chemDam += 2;
	}

	baseStats.maxEnergy += 4;
	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 10;
	baseStats.radResPerc += 4;
	
	baseStats.oa ++;
	baseStats.da ++;
	
}

evolveLevel = 8;
evolveChanceMin = 12;
evolveChanceMax = 42;
evolutions = [obj_bigAlienToxic, obj_bigAlienRad];