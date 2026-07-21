event_inherited();

name = "alien";

bloodCol = c_purple;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_alienOrb(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

baseStats.maxHp = 60;

thornsDamage = new damageProfile();

thornsDamage.kin = 4;

sprites = {

	up: spr_alien,
	down: spr_alien,
	left: spr_alien,
	right: spr_alien,
	death: spr_alien,
	spawn: spr_alien
	
}