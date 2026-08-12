player = global.player;

key = "item";
type = "item";
val = 0;

pickupRange = 300;
depth = layers.physical - y;

setup = true;

hashCellX = -1;
hashCellY = -1;

pullX = undefined;
pullY = undefined;
pullSpd = 0;

prevX = x;
prevY = y;

col = c_white;

collectRequirements = undefined;

collectFunc = undefined;
collectSounds = global.data.soundProfiles.collect;

burstVel = 0;
burstDir = 0;

collectDelay = 32;