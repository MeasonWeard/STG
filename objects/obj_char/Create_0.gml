// Inherit the parent event
event_inherited();

step = 0;

name = "none";
owner = noone;
spawnTime = current_time;
spawning = false;

tags = [];

charData = undefined;

setup = true;
setupStats = true;
setupBasics = true;

sc = global.stageController;
rc = scr_data_getRunController();

faction = undefined;
setup = true;
firstEquip = true;

//appearance, sound, behaviour
bloodCol = c_red;
bulletHitSounds = "bulletHitFlesh";
deathSounds = global.data.soundProfiles.fleshExplod;

deathFunc = undefined;
bulletHitFunc = undefined;//scr_effects_bulletHitFlesh;
gibDisappears = true;

hpRegenCounter = 0;
energyRegenCounter = 0;
shieldRegenCounter = 0;
shieldRegenDelay = 240;
hurtTick = 0;

pet = false;
life = undefined;

getOwnerDamBonuses = false;
getOwnerDamMults = true;
getOwnerResBonuses = true;
getOwnerResMults = true;

sprites = {

	left: spr_player,
	right: spr_player,
	up: spr_player,
	down: spr_player,
	spawn: spr_player,
	death: spr_death
	
}

damageFlash = 0;
shieldFlash = 0;

//stats
maxHp = 100;
hp = 100;
maxShield = 0;
shield = 0;
prevHp = hp;
prevShield = shield;
maxEnergy = 200;
energy = 200;

stimPacks = 0;
energyPacks = 0;

stimPackRecharge = 0;
energyPackRecharge = 0;

baseStats = scr_stats_blankCharStats();

stats = scr_stats_blankCharStats();

gear = {

	device1: undefined,
	device2: undefined,
	tie: undefined,
	headgear: undefined
	
};

finalStats = {

	//health and shields
	maxHp: 100,
	maxShield: 0,
	hpRegen: 0,
	shieldRegen: 0,
	energyRegen: 0,
	
	//movement
	spd: 4,
	dashCoolTime: 3,
	maxDashes: 1,

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
	
};

skills = {

	skill1: undefined,
	skill2: undefined,
	skill3: undefined,
	skill4: undefined
	
};

//thorns
thornsDamage = undefined;
thornsAttackRate = 1;
thornsTurnIndex = -1;
thornsSounds = global.data.soundProfiles.burn;

activationTurnIndex = -1;

thornsImmunity = 0;

liquidDamageImmunity = 0;

//movement
spd = 4;

dash = 0;
dashTime = 32;

dashX = 0;
dashY = 0;
dashMult = 2.5;
dashCool = 0;
dashes = 0;

dashing = false;

//attack
customGunOffset = false;
gunCentred = false;
gunXoffset = 0;
gunYoffset = 0;

gunDist = 32;

dir = choose(0, 1, 2, 3);

centreX = x;
centreY = y;

gunX = centreX;
gunY = centreY;

aimX = x;
aimY = y;

meleeRangeOffset = 0;

meleeCooldown = 0;

equippedWeapon = undefined;
equippedWeaponStats = undefined;
prevWeapon = undefined;

damageDestructibles = false;

weapons = [];
weaponIndex = 0;

meleeHitList = [];

bulletFuncs = [];
constantFuncs = [];
mostRecentDamage = undefined;

//ai
hurt = false;
alert = false;