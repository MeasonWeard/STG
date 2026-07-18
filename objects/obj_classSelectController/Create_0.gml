global.classSelectController = self;

playerData = global.gameData.playerData;
selectedLabel = noone;
headingLabel = noone;
descLabel = noone;
instructionLabel = noone;

if (instance_exists(global.player)) instance_destroy(global.player);

setup = true;

showBackButton = true;

classNum = is_undefined(playerData.class1) ? 1 : 2;

selectedClass = undefined;

physicsTxt = scr_file_getTextFromFile("physics");
chemistryTxt = scr_file_getTextFromFile("chemistry");
biologyTxt = scr_file_getTextFromFile("biology");
engineeringTxt = scr_file_getTextFromFile("engineering");

heading = "";
description = "";

hoverHeading = undefined;
hoverDescription = undefined;