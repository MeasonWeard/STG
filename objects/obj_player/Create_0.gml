event_inherited();
cursor = global.cursor;

charName = "player";
faction = "player";
damageDestructibles = true;

audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1, 0, -1, 0);

var gun = new gun_blaster(1, 1);
var gun2 = new gun_shotgun (1, 1);

gun.damage.fire = 6;
gun.bonusStats.fireRate = 1;

scr_weapons_collectWeapon(self, gun, false);
scr_weapons_collectWeapon(self, gun2, false);

var melee1 = new meleeInst(1, 1);

scr_weapons_collectWeapon(self, melee1, false);

gunCentred = false;
//gunYoffset = 64;

stats.maxHp = 300;
stats.maxEnergy = 300;
stats.spd = 6;
stats.maxDashes = 2;
stats.hpRegen = 1;
stats.energyRegen = 5;

stats.maxStimPacks = 2;
stats.maxEnergyPacks = 1;

stats.elecDamPerc = 50;
stats.kinDamPerc = 20;
stats.kinDam = 4;

stats.oa = 100;

gear.device1 = scr_devices_powerBank(6, 5);
gear.device2 = scr_devices_watch(6, 5);
gear.tie = new tieInst(1, 1);
gear.headgear = new headgearInst(1, 1);

skills.skill1 = new skill_chainLightning();
skills.skill2 = new skill_antimatterBlast();
skills.skill4 = new skill_test();

skills.skill1.level = 3;
skills.skill2.level = 3;