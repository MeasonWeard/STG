sr = global.startRun;
portrait = spr_missing;
name = "";

x = room_width * 0.5;

top = y;
bottom = y + sprite_height;

centreX = x;
centreY = (top + bottom) * 0.5;

portrait = sr.portrait;
name = sr.zoneName;

setScale = true;

//formatting
scale = 0;
portraitX = 0;
portraitY = 0;
pad = 12;
titleH = 36;
borderLeft = 0;
borderRight = 0;
borderTop = 0;
borderBottom = 0;