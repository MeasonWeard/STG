event_inherited();

charName = "enemy";
faction = "enemy";

target = global.player;

ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;
firstGhostCheck = true;

//ai
aiSetup = true;
detectionIndex = -1;
ghostCheckIndex = -1;
targetMinDist = 180;
targetMaxDist = 360;
targetReaquireDist = 450;

//drops
minData = 8;
maxData = 16;

lootMaxRarity = 3;
lootImproveChance = 10;
lootChance = 2;
lootAmount = 1;

dropOnDestroy = true;