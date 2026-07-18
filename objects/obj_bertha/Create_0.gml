event_inherited();

name = "bertha";

bloodCol = c_red;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

var slash = new melee_berthaSlash(1, 1);

scr_weapons_collectWeapon(self, slash, true);

thornsDamage = new damageProfile();
thornsDamage.kin = 8;

sprites = {

	left: spr_bertha,
	right: spr_bertha,
	up: spr_bertha,
	down: spr_bertha,
	death: spr_bertha
	
}

targetMinDist = 30;
targetMaxDist = 60;
targetReaquireDist = 90;

baseStats.maxHp = 80;
baseStats.spd += 0.5;