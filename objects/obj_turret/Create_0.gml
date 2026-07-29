event_inherited();

level = 1;
life = undefined;
clips = 2;
ammoPerClip = 18;
newClip = false;

tags = ["mech"];

turretSetup = true;

bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;
deathSounds = [snd_turretDeath];

level = 1;
gunDamMult = 1;

target = noone;

customGunOffset = true;
gunYoffset = -sprite_height + 8;

sprites = {

	left: spr_turretLeft,
	right: spr_turretRight,
	up: spr_turretUp,
	down: spr_turretDown,
	death: spr_turretDeath,
	spawn: spr_turretDeploy
	
}

kinDam = 8;

getOwnerDamBonuses = true;
getOwnerBulletFuncs = true;
getOwnerOA = true;

findTargetIndex = scr_timeSlicing_assignTurnIndex("findTarget");
aimIndex = scr_timeSlicing_assignTurnIndex("aim");
reTargetDist = 800;

scr_ai_setup();

aimBias = 1.85;