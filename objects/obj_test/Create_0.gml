// Inherit the parent event
event_inherited();

maxHp = 400;

sprites = {

	left: spr_test,
	right: spr_test,
	up: spr_test,
	down: spr_test,
	death: spr_death
	
}

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = scr_gunArsenal_alienOrb2();
scr_guns_collectGun(self, gun1, true);

aimOnReload = true;
aimRadius = 240;
aimBias = 1.2;