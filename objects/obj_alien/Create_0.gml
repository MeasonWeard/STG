event_inherited();

name = "Alien";
tags = ["bio"];
bloodCol = c_purple;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_alienSpit(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

sprites = {

	up: spr_alien,
	down: spr_alien,
	left: spr_alien,
	right: spr_alien,
	death: spr_alien,
	spawn: spr_alien
	
}

//stats
baseStats.maxHp = 60;
baseStats.radRes = 5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.chemDam += 2;
	}

	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
	baseStats.oa ++;
	baseStats.da ++;
	
}