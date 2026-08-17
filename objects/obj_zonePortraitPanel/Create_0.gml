sr = global.startRun;
portrait = spr_missing;
name = "";

left = x;
top = y;
right = left + sprite_width;
bottom = top + sprite_height;

centreX = (left + right) * 0.5;
centreY = (top + bottom) * 0.5;

portrait = sr.portrait;
name = sr.zoneName;

setScale = true;

//formatting
scale = 0;
portraitX = 0;
portraitY = 0;
pad = 12;