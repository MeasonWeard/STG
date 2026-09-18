rc = global.researchController;
rc.panel = self;
gameData = global.gameData;

delay = 2;

viewedNode = noone;
viewedProject = undefined;

currentProject = undefined;
prevCurrentProject = undefined;

iconX = x + 20;
iconY = y + 20;

descX = iconX;
descY = iconY + sprite_get_height(spr_icon_blank) + 20;

progX = descX + 580;
progY = descY;

currentProgress = undefined;
currentIcon = undefined;

currentIconX = x + 1080;
currentIconY = y + 20;
currentTextX = currentIconX;
currentTextY = currentIconY + sprite_get_height(spr_icon_blank) + 20;
currentCostsX = currentIconX + 80;
currentCostsY = currentIconY;