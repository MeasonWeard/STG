// Inherit the parent event
event_inherited();

name = "Spider Drone";

bulletHitSounds = global.data.soundProfiles.bulletHitMetalHigh;

//deathFunc = scr_char_fleshExplosion;

sprites.death = spr_spiderDroneDeath;
deathSounds = [snd_droneDeath1, snd_droneDeath2];

gun1 = new gun_spiderGun(1, 1);

scr_weapons_collectWeapon(self, gun1, true);

baseStats.maxHp = 40;
baseStats.spd = 6;

gunYoffset = -32;