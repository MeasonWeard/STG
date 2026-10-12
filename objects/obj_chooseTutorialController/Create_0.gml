if (instance_exists(global.player)) instance_destroy(global.player);
scr_char_removeAllPets();

var rc = global.runController;

if (instance_exists(rc)) instance_destroy(rc);
	
scr_zones_startZone(zone_intro, 0);
	
rc = global.runController;