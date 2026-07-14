event_inherited();

charName = "enemy";
faction = "enemy";

target = global.player;
targetMinDist = 180;
targetMaxDist = 360;
targetReaquireDist = 450;

ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;
firstGhostCheck = true;

aiSetup = true;
ghostCheckIndex = -1;

detectionIndex = -1;

minData = 8;
maxData = 16;

lootMaxRarity = 3;
lootImproveChance = 10;
lootChance = 2;
lootAmount = 1;