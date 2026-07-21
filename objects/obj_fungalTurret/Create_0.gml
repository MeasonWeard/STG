event_inherited();

level = 1;

bloodCol = #A1FF99;
bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

target = noone;

sprites = {

	left: spr_fungalTurret,
	right: spr_fungalTurret,
	up: spr_fungalTurret,
	down: spr_fungalTurret,
	death: spr_fungalTurret,
	spawn: spr_fungalTurretSpawn
	
}

var gun1 = new gun_fungalGun (1, 1);
scr_weapons_collectWeapon(self, gun1, false);

findTargetIndex = scr_timeSlicing_assignTurnIndex("findTarget");
aimIndex = scr_timeSlicing_assignTurnIndex("aim");
reTargetDist = 800;