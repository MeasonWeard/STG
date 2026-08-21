// Inherit the parent event
event_inherited();

canMove = false;
blockLos = true;
image_speed = 0;

charDist = 150;

open = false;
prevOpen = false;

openSound = snd_dooropen1;
closeSound = snd_doorclose1;

charHash = global.stageController.charHash;

var cell = scr_hash_getCellAt(x, y);
var xx = cell.xx;
var yy = cell.yy;

charHashKeys = [];

scr_hash_updateHashKeys(charHashKeys, xx, yy);

charCheckTick = irandom_range(0, 8);