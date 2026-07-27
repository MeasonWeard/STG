// Inherit the parent event
event_inherited();

name = "celia";
tags = ["bio"];
baseStats.maxHp = 400;

sprites = {

	left: spr_celia,
	right: spr_celia,
	up: spr_celia,
	down: spr_celia,
	death: spr_death,
	spawn: spr_celia
	
}

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_alienOrb2(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

aimOnReload = true;
aimAngle = 50;
aimBias = 1.2;

thornsDamage = new damageProfile();
thornsDamage.chem = 8;

minData = 32;
maxData = 64;

lootChance = 25;
lootImproveChance = 35;
lootAmount = 2;