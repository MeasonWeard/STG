event_inherited();

charName = "player";
faction = "player";

cursor = global.cursor;

audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1, 0, -1, 0);

spd = 10;

var gun = scr_gunArsenal_blaster();

scr_guns_collectGun(self, gun, false);

var melee1 = scr_melee_createWeapon("test");

scr_melee_equipMelee(self, melee1);

gunCentred = false;
//gunYoffset = 64;

stats.maxHp = 500;
//stats.fireDam = 30;
//stats.kinDam = 5;
//stats.kinDamPerc = 500;
//stats.fireDamPerc = 50;