// Inherit the parent event
event_inherited();

charName = "none";

setup = true;

sc = global.stageController;

faction = undefined;
setup = true;

maxHp = 100;
hp = 100;
maxShield = 0;
shield = 0;
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

stats = {

	//flat health and shields
	maxHp: 100,
	maxShield: 0,
	hpRegen: 0,
	shieldRegen: 0,

	//health and shields percent increase
	maxHpPerc: 0,
	maxShieldPerc: 0,
	hpRegenPerc: 0,
	shieldRegenPerc: 0,
	
	//flat damage
	kinDam: 0,
	fireDam: 0,
	chemDam: 0,
	elecDam: 0,
	radDam: 0,

	//damage percent increase
	kinDamPerc: 0,
	fireDamPerc: 0,
	chemDamPerc: 0,
	elecDamPerc: 0,
	radDamPerc: 0,
	
	//flat resistances
	kinRes: 0,
	fireRes: 0,
	chemRes: 0,
	elecRes: 0,
	radRes: 0,
	
	//resistance percent increase
	kinResPerc: 0,
	fireResPerc: 0,
	chemResPerc: 0,
	elecResPerc: 0,
	radResPerc: 0
	
}

finalStats = {

	//health and shields
	maxHp: 100,
	maxShield: 0,
	hpRegen: 0,
	shieldRegen: 0,

	//damage
	kinDam: 0,
	fireDam: 0,
	chemDam: 0,
	elecDam: 0,
	radDam: 0,
	
	//resistances
	kinRes: 0,
	fireRes: 0,
	chemRes: 0,
	elecRes: 0,
	radRes: 0,
	
}

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

shootDelayMin = 8;
shootDelayMax = 16;
shootDelayTick = 0;
aimRadius = 360;
aimBias = 1.5; // 1 = equal chance across radius, < 1 baised towards edges, > 1 baised towards centre
firstShot = true;
aimIndex = -1;
aimOnReload = false;

meleeCooldown = 0;

gun = undefined;
melee = undefined;

guns = [];
gunIndex = 0;

gunStats = undefined;

active = false;
alert = false;
detectionDist = 800;
hurt = false;
avoidDist = 48;