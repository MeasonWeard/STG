event_inherited();
cursor = global.cursor;

name = "player";
faction = "player";
damageDestructibles = true;
sprites.death = spr_playerDeath;

attackDelay = 12;
shootingCooldown = 12;
shootingTick = 0;

audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1, 0, -1, 0);

gunCentred = false;
meleeRangeOffset = 16;

//EQUIPMENT

gear = scr_data_loadEquippedGear();

var weapons = scr_data_loadEquippedWeapons();
weapons.weapon1 = new melee_cleaver(1, 1);
weapons.weapon2 = new melee_hammer(1, 1);

scr_weapons_collectWeapon(self, weapons.weapon1, true);
scr_weapons_collectWeapon(self, weapons.weapon2, false);

//var gun = new gun_blaster(1, 1);
//var gun2 = new gun_shotgun (1, 1);

//gun.damage.fire = 6;
//gun.bonusStats.fireRate = 1;

//scr_weapons_collectWeapon(self, gun, false);
//scr_weapons_collectWeapon(self, gun2, false);

//scr_weapons_collectWeapon(self, melee1, false);

//gear.device1 = scr_genDevices_powerBank(6, 5);
//gear.device2 = scr_genDevices_watch(6, 5);
//gear.tie = new tieInst(1, 1);
//gear.headgear = new headgearInst(1, 1);


//gunYoffset = 64;

//STATS
baseStats.maxHp = 300;
baseStats.maxEnergy = 300;
baseStats.spd = 6;
baseStats.maxDashes = 2;
baseStats.hpRegen = 1;
baseStats.energyRegen = 5;

baseStats.maxStimPacks = 2;
baseStats.maxEnergyPacks = 1;

//SKILLS
skills.skill1 = new skill_chainLightning();
skills.skill2 = new skill_antimatterBlast();
skills.skill4 = new skill_test();

skills.skill1.level = 3;
skills.skill2.level = 3;