event_inherited();

bloodCol = c_red;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

var slash = new melee_berthaSlash();

scr_weapons_collectWeapon(self, slash, true);

stats.maxHp = 80;

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

stats.spd += 0.5;