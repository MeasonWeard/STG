event_inherited();

name = "Plant";
tags = ["bio","plant"];
bloodCol = #C3D9B6;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathSounds = global.data.soundProfiles.plantDeath;

gun1 = new gun_plantGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);



thornsDamage = new damageProfile();

thornsDamage.kin = 2;

sprites = {

	up: spr_plant,
	down: spr_plant,
	left: spr_plant,
	right: spr_plant,
	death: spr_plantDeath,
	spawn: spr_alien
	
}

baseStats.maxHp = 60;

levelUpFunc = function() {

	baseStats.maxHp += 3;
	
	baseStats.chemDamPerc += 5;
	baseStats.kinDamPerc += 10;
	

}