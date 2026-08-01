event_inherited();

name = "alien";
tags = ["bio"];
bloodCol = c_purple;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_alienOrb(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

thornsDamage = new damageProfile();

thornsDamage.kin = 2;

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

levelUpFunc = function() {

	if (level > 2) baseStats.maxHp += 5;
	
	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 5;

}