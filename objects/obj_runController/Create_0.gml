global.runController = self;

sc = noone;

gameState = "running";
runLevel = 1;
extraLevel = 0;

zoneConstructor = undefined;
generateMap = true;
generateWeights = true;
levelWeights = [];

zoneInst = undefined;
map = undefined;
startPos = undefined;

startX = 0;
startY = 0;

posX = 0;
posY = 0;

miniMap = undefined;

currentCell = undefined;

firstStage = true;

resources = {};
loot = {};
uniqueLoot = [];