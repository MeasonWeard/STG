depth = layers.physical -y;

movedThisStep = false;
canMove = true;
confineToBounds = true;

xspd = 0;
yspd = 0;

colLeft = bbox_left;
colRight = bbox_right - 1;
colTop = bbox_top + 1;
colBottom = bbox_bottom - 1;
colMiddle = (colTop + colBottom) * 0.5;