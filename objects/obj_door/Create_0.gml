rc = scr_data_getRunController();
sc = global.stageController;
player = global.player;
depth = layers.decorations;

image_index = image_number - 1;

open = false;
side = "top";
initialiseArea = true;
initialiseDoors = true;
playerinArea = false;

areaTop = 0;
areaBottom = 0;
areaLeft = 0;
areaRight = 0;
yMid = 0;
xMid = 0;

textX = 0;
textY = 0;

areaDist = 64;


//hub stuff
openDist = 400;
displayTagDist = 1450;
stageName = "";
displayTag = false;
