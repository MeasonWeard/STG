// Inherit the parent event
event_inherited();

name = "Celia";
tags = ["bio"];


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

//drops
minData = 32;
maxData = 64;

lootChance = 25;
lootImproveChance = 20;
lootAmount = 2;

//stats
baseStats.maxHp = 400;

levelUpFunc = function() {

	baseStats.maxHp += 20;
	
	baseStats.chemDamPerc += 5;
	baseStats.kinDamPerc += 10;
	
}