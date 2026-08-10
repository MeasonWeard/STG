selectedZone = global.selectedZone;

if (instance_exists(global.player)) instance_destroy(global.player);
scr_char_removeAllPets();


rc = global.runController;

if (instance_exists(rc)) instance_destroy(rc);

global.startRun = self;

modVals = [0,3,7,12,18,25];
modValsLen = array_length(modVals);

intensityMod = 0;
intensityIndex = 0;

runLevel = 0;