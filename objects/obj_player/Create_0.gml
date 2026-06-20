event_inherited();

charName = "player";
faction = "player";

cursor = global.cursor;

audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1, 0, -1, 0);

var gun = new gun_blaster();
var gun2 = new gun_pistol();

scr_weapons_collectWeapon(self, gun, false);
scr_weapons_collectWeapon(self, gun2, false);

var melee1 = new meleeInst();

scr_weapons_collectWeapon(self, melee1, false);

gunCentred = false;
//gunYoffset = 64;

stats.maxHp = 300;
stats.maxEnergy = 100;
stats.spd = 6;
stats.maxDashes = 2;
stats.hpRegen = 1;
stats.energyRegen = 5;

stats.maxStimPacks = 2;
stats.maxEnergyPacks = 2;

stats.elecDamPerc = 35;
stats.kinDamPerc = 20;
stats.kinDam = 4;

skills.skill1 = new skill_chainLightning();
skills.skill2 = new skill_test();