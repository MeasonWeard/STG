event_inherited();

level = 1;
life = 10;

blobSetup = true;

bloodCol = c_green;
bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

level = 1;

target = noone;

customGunOffset = true;
gunYoffset = -sprite_height + 16;

sprites = {

	left: spr_blob,
	right: spr_blob,
	up: spr_blob,
	down: spr_blob,
	death: spr_blob,
	spawn: spr_blob
	
}

var gun1 = new gun_blobGun (1, 1);
scr_weapons_collectWeapon(self, gun1, false);

findTargetIndex = scr_timeSlicing_assignTurnIndex("findTarget");
aimIndex = scr_timeSlicing_assignTurnIndex("aim");
reTargetDist = 800;

//ai
scr_ai_setup();
ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;

targetMinDist = 80;
targetMaxDist = 100;
targetReaquireDist = 110;

fleshExplodeForce = 6;
deathSounds = global.data.soundProfiles.fungusBlast;