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
baseStats.hpRegen = 2;
baseStats.fireRes = -20;
baseStats.chemRes = 5;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 2;
			baseStats.chemDam += 1;
			baseStats.chemRes += 4;
	}
	
	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
	baseStats.hpRegen += 0.2;

}