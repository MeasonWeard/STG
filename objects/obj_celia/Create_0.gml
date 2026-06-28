// Inherit the parent event
event_inherited();

maxHp = 400;

sprites = {

	left: spr_celia,
	right: spr_celia,
	up: spr_celia,
	down: spr_celia,
	death: spr_death
	
}

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_alienOrb2();
scr_weapons_collectWeapon(self, gun1, true);

aimOnReload = true;
aimRadius = 240;
aimBias = 1.2;

thornsDamage = new damageProfile();
thornsDamage.chem = 16;

minData = 32;
maxData = 64;

lootChance = 100;
lootLevel = 4;