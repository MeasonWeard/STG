event_inherited();

faction = "enemy";

target = global.player;
targetMinDist = 180;
targetMaxDist = 360;
targetReaquireDist = 540;

ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;
firstGhostCheck = true;

aiSetup = true;
ghostCheckIndex = -1;