event_inherited();

charName = "enemy";
faction = "enemy";
boss = false;

target = global.player;

ghost = instance_create_layer(x, y, "Instances", obj_ghost);
ghost.owner = self;

dropOnDestroy = true;

//drops
minData = 8;
maxData = 16;

lootMaxRarity = 3;
lootImproveChance = 10;
lootChance = 2;
lootAmount = 1;

showHealthBar = true;

levelUp = true;
levelUpFunc = undefined;
level = 0;

//ai
scr_ai_setup();