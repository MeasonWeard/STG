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