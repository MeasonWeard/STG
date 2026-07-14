global.runController = self;

sc = noone;

gameState = "running";
runLevel = 4;

mapW = 12;
mapH = 12;

map = scr_mapGen_createBlankMap(mapW, mapH);
stages = ["engComputerRoom", "engHall1"];
endStages = ["engBoss1"];

var startPos = scr_mapGen_randomStartingLocation(mapW, mapH, 1);
startX = startPos.xx;
startY = startPos.yy;
posX = startX;
posY = startY;

scr_mapGen_randomWalk(map, stages, startX, startY, 15);
scr_mapGen_makeFurthestEndCell(map, startX, startY, endStages);

miniMap = scr_mapGen_createMiniMap(map, true);

currentCell = map[posX][posY];
currentCell.discovered = true;

scr_stages_discoverAdjacentCells();

resources = {};
loot = {};