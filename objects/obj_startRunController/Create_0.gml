global.startRun = self;
selectedZone = global.selectedZone;

if (instance_exists(global.player)) instance_destroy(global.player);
scr_char_removeAllPets();


rc = global.runController;

if (instance_exists(rc)) instance_destroy(rc);

modVals = [0,1,3,7,12,18,25];
modValsLen = array_length(modVals);

intensityMod = 0;
intensityIndex = 0;

runLevel = 0;

var tempZone = new global.selectedZone();

zoneName = tempZone.name;
portrait = tempZone.portrait;
baseLevel = tempZone.baseLevel;

start = false;