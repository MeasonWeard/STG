event_inherited();

tags = ["mech"];

level = 1;
life = undefined;

mechSetup = true;

bloodCol = c_green;
bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

getOwnerDamBonuses = true;
getOwnerBulletFuncs = true;
getOwnerOA = true;

level = 1;

target = noone;

customGunOffset = true;
gunYoffset = -sprite_height + 16;

sprites = {

	left: spr_mech,
	right: spr_mech,
	up: spr_mech,
	down: spr_mech,
	death: spr_mech,
	spawn: spr_mechSpawn
	
}

deathFunc = function() {
	
	var ex = scr_effects_explosion(x, y, 8);
	ex.damage = new damageProfile();
	ex.damage.kin = 90;
	ex.faction = faction;
	
}

var gun1 = new gun_mechPulseRifle (1, 1);
scr_weapons_collectWeapon(self, gun1, false);

findTargetIndex = scr_timeSlicing_assignTurnIndex("findTarget");
aimIndex = scr_timeSlicing_assignTurnIndex("aim");
reTargetDist = 1400;

//ai
scr_ai_setup();
ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;


//if (!variable_instance_exists(self, "targetMinDist")) targetMinDist = 180;
//if (!variable_instance_exists(self, "targetMaxDist")) targetMaxDist = 360;
//if (!variable_instance_exists(self, "targetReaquireDist")) targetReaquireDist = 450;
targetMinDist = 200;
targetMaxDist = 420;
targetReaquireDist = 650;

deathSounds = [snd_droneDeath1, snd_droneDeath2];
bulletHitSounds = global.data.soundProfiles.bulletHitMetal;