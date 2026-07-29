event_inherited();

tags = ["bio"];

level = 1;
life = 10;

symbiontSetup = true;

//lifeStealForSelf = false;
lifeStealForOwner = true;

bloodCol = #D8EA8A;
bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

level = 1;

target = noone;

baseStats.spd = 7;
baseStats.meleeLifeSteal = 5;

kinDam = 0;

meleeRangeOffset = 8;

sprites = {

	left: spr_symbiont,
	right: spr_symbiont,
	up: spr_symbiont,
	down: spr_symbiont,
	death: spr_symbiont,
	spawn: spr_symbiont
	
}

//var melee1 = new melee_symbiontSlash(1, 1);
//scr_weapons_collectWeapon(self, melee1, false);

findTargetIndex = scr_timeSlicing_assignTurnIndex("findTarget");
aimIndex = scr_timeSlicing_assignTurnIndex("aim");
reTargetDist = 400;

//ai
scr_ai_setup();
ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;

targetMinDist = 85;
targetMaxDist = 105;
targetReaquireDist = 115;

deathSounds = global.data.soundProfiles.fleshExplod;

teleportToOwner = false;