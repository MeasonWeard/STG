event_inherited();

cursor = global.cursor;

audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1, 0, -1, 0);

spd = 10;

var gun = scr_guns_createGun("test");

guns = [gun];

melee = scr_melee_createWeapon("test");