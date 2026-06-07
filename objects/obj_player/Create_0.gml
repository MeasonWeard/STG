event_inherited();

faction = "player";

cursor = global.cursor;

audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1, 0, -1, 0);

spd = 10;

var gun = scr_guns_createGun("test");
var gun2 = scr_guns_createGun("test2");
//guns = [gun];

scr_guns_collectGun(self, gun, false);
scr_guns_collectGun(self, gun2, false);

melee = scr_melee_createWeapon("test");

gunCentred = false;
//gunYoffset = 64;