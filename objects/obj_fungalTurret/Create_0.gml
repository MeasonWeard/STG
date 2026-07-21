event_inherited();

level = 1;
life = 10;

fungalSetup = true;

bloodCol = #A1FF99;
bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

level = 1;
gunDamMult = 1;

target = noone;

gunYoffset = -sprite_height + 16;

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

aimBias = 1.85;
//aimAngle = 30;