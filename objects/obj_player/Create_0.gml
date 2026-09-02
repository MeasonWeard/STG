event_inherited();
cursor = global.cursor;

name = "Player";
faction = "player";
damageDestructibles = true;
tags = ["bio"];

attackDelay = 12;
shootingCooldown = 12;
shootingTick = 0;

charData = global.gameData.playerData;

level = charData.level;
xp = charData.xp;
xpEarned = 0;
xpRequired = scr_progression_xpRequired(level);

audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1, 0, -1, 0);

gunCentred = false;
meleeRangeOffset = 16;

moveToSide = undefined;

setMaxCharges = true;

pullItemTick = 0;

getNearbyEnv = true;
teleport = false;

sprites = {

	left: spr_playerM_l,
	right: spr_playerM_r,
	up: spr_playerM_u,
	down: spr_playerM_d,
	spawn: spr_playerM_d,
	death: spr_playerM_death
	
}

//EQUIPMENT

gear = scr_data_loadEquippedGear();

var weaponsData = scr_data_loadEquippedWeapons();

//randomise();
//weaponsData.weapon1 = scr_genMelee_aspisAndBaton(8, 2);
//weaponsData.weapon2 = scr_genMelee_electricHammer(10, 3);
scr_weapons_collectWeapon(self, weaponsData.weapon1, true);
scr_weapons_collectWeapon(self, weaponsData.weapon2, false);

//randomise();
//var dev = scr_genDevices_thermos(15, 1);
//gear.device1 = dev;
//dev = scr_genDevices_thermos(15, 5);
//gear.device2 = dev;

//var hg = new headgearInst(1, 1);
//hg.stats.radDamPerc = 1000;
//gear.headgear = hg;

//STATS
baseStats.maxHp = 250;
baseStats.maxEnergy = 200;
baseStats.spd = 6;
baseStats.maxDashes = 2;
baseStats.hpRegen = 1;
baseStats.energyRegen = 5;

baseStats.maxStimPacks = 2;
baseStats.maxEnergyPacks = 1;

baseStats.maxShield = 0;

//SKILLS
//skills.skill1 = new skill_chainLightning();
//skills.skill2 = new skill_antimatterBlast();

//skills.skill1.level = 3;
//skills.skill2.level = 3;