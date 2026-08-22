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

//drops
minData = 32;
maxData = 64;

lootChance = 6;
lootImproveChance = 20;
lootAmount = 2;

//stats
baseStats.maxHp = 400;
baseStats.chemRes = 5;
baseStats.radRes = 5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 1;
			baseStats.chemDam += 2;
			baseStats.chemRes += 4;
			baseStats.radRes += 4;
	}

	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
}