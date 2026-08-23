damage = undefined;
owner = noone;
pullRange = 0;
minPullRange = 35;
maxPullStrength = 16;
charHash = global.stageController.charHash;
faction = undefined;

size = 25;
sizeDir = 1;

tick = 110;

movLeft = x - 25;
movRight = x + 25;
movTop = y - 25;
movBottom = y + 25;

chars = [];

getCharsTick = 0;

scr_audio_playSoundAt(snd_singularity, x, y, false);