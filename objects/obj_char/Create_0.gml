// Inherit the parent event
event_inherited();

setup = true;

sc = global.stageController;

faction = undefined;
setup = true;

maxHp = 100;
hp = 100;
armour = 0;
maxArmour = 0;
prevHp = hp;
damageFlash = 0;

thornsDamage = 0;
thornsAttackRate = 1;
thornsTurnIndex = -1;
thornsSounds = global.data.soundProfiles.burn;

activationTurnIndex = -1;

thornsImmunity = 0;

liquidDamageImmunity = 0;

walkSpeed = 4;
runSpeed = 8;

meleeHitList = [];

sprites = {

	left: spr_player,
	right: spr_player,
	up: spr_player,
	down: spr_player,
	death: spr_death
	
}

bloodCol = c_red;
bulletHitSounds = "bulletHitFlesh";
deathSounds = global.data.soundProfiles.fleshExplod;

deathFunc = undefined;
bulletHitFunc = undefined;//scr_effects_bulletHitFlesh;

gunXoffset = 0;
gunYoffset = 0;

gunDist = 32;

dir = choose(0, 1, 2, 3);

gunCentred = false;
customGunOffset = false;

centreX = x + gunXoffset * dir;
centreY = y - gunYoffset;

gunX = centreX;
gunY = centreY;

aimX = x;
aimY = y;

meleeCooldown = 0;

gun = undefined;
melee = undefined;

guns = [];
gunIndex = 0;

active = false;