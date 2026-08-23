// Inherit the parent event
event_inherited();

name = "Snonk";
tags = ["bio"];
baseStats.maxHp = 3200;
baseStats.spd = 1;
boss = true;

sprites = {

	left: spr_snonk,
	right: spr_snonk,
	up: spr_snonk,
	down: spr_snonk,
	death: spr_snonk,
	spawn: spr_snonk
	
}

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_celiaGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

aimOnReload = true;
aimAngle = 50;
aimBias = 1.2;

minData = 1024;
maxData = 1280;

lootChance = 100;
lootAmount = 4;
lootMaxRarity = 6;
lootImproveChance = 45;