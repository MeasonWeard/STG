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

calculateData = true;

lootMaxRarity = 3;
lootImproveChance = 10;
lootChance = 2;
lootAmount = 1;

showHealthBar = true;

enemySetup = true;
levelUp = true;
levelUpFunc = undefined;
level = 0;

evolutions = [];
evolveChanceMin = 10;
evolveChanceMax = 50;
evolveLevel = undefined;

//ai
scr_ai_setup();