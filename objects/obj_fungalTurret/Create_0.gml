event_inherited();

tags = ["bio"];

level = 1;
life = 10;

fungalSetup = true;

bloodCol = #A1FF99;
bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

level = 1;
gunDamMult = 1;

target = noone;

customGunOffset = true;
gunYoffset = -sprite_height + 16;

sprites = {

	left: spr_fungalTurret,
	right: spr_fungalTurret,
	up: spr_fungalTurret,
	down: spr_fungalTurret,
	death: spr_fungalTurret,
	spawn: spr_fungalTurretSpawn
	
}

kinDam = 2;
chemDam = 4;

findTargetIndex = scr_timeSlicing_assignTurnIndex("findTarget");
aimIndex = scr_timeSlicing_assignTurnIndex("aim");
reTargetDist = 800;

scr_ai_setup();

aimBias = 1.85;
//aimAngle = 30;