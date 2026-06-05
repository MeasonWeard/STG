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
thornsSounds = undefined;//global.data.soundProfiles.burn;

activationTurnIndex = -1;

thornsImmunity = 0;

liquidDamageImmunity = 0;

walkSpeed = 4;
runSpeed = 8;

meleeHitList = [];

sprites = {

	//left: spr_playerLeft,
	//right: spr_playerRight,
	//proneLeft: spr_playerProneLeft,
	//proneRight: spr_playerProneRight,
	//climbLeft: spr_playerClimbLeft,
	//climbRight: spr_playerClimbRight,
	//death: spr_berthaDeath
	
}

bloodCol = c_red;
bulletHitSounds = "bulletHitFlesh";
deathSounds = undefined;//global.data.soundProfiles.fleshExplod;

deathFunc = undefined;
bulletHitFunc = undefined;//scr_effects_bulletHitFlesh;

gunXoffset = 0;
gunYoffset = 0;

gunDist = 32;

dir = choose(0, 1, 2, 3);

gunCentred = false;

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