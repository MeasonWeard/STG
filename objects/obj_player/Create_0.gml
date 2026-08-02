event_inherited();
cursor = global.cursor;

name = "player";
faction = "player";
damageDestructibles = true;
sprites.death = spr_playerDeath;
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

sprites = {

	left: spr_player_1,
	right: spr_player_1,
	up: spr_player_1,
	down: spr_player_1,
	spawn: spr_player_1,
	death: spr_player_death
	
}

//EQUIPMENT

gear = scr_data_loadEquippedGear();

var weaponsData = scr_data_loadEquippedWeapons();

weaponsData.weapon1 = scr_genGuns_arcPulseRifle(25, 6);
weaponsData.weapon2 = scr_genGuns_sniperPulseRifle(25, 6);
scr_weapons_collectWeapon(self, weaponsData.weapon1, true);
scr_weapons_collectWeapon(self, weaponsData.weapon2, false);

//var hg = new headgearInst(1, 1);
//hg.stats.radDamPerc = 1000;
//gear.headgear = hg;

//STATS
baseStats.maxHp = 200;
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