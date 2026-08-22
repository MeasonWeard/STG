event_inherited();

name = "Plant";
tags = ["bio","plant"];
bloodCol = #C3D9B6;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathSounds = global.data.soundProfiles.plantDeath;

gun1 = new gun_plantGun(1, 1);
scr_weapons_collectWeapon(self, gun1, true);

sprites = {

	up: spr_plantGuy,
	down: spr_plantGuy,
	left: spr_plantGuy,
	right: spr_plantGuy,
	death: spr_plantGuyDeath,
	spawn: spr_plantGuy
	
}

baseStats.maxHp = 60;
baseStats.hpRegen = 2;
baseStats.fireRes = -20;
baseStats.chemRes = 4;
baseStats.elecRes = 8;

levelUpFunc = function() {

	if (level > 2) baseStats.maxHpPerc += 10;
	
	if (level mod 10 == 0) {
			baseStats.kinDam += 2;
			baseStats.chemDam += 1;
			baseStats.chemRes += 2;
			baseStats.elecRes += 4;
	}
	
	baseStats.chemDamPerc += 10;
	baseStats.kinDamPerc += 10;
	
	baseStats.hpRegen += 0.15;

}