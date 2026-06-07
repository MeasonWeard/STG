depth = layers.physical -y;

movedThisStep = false;
canMove = true;
confineToBounds = true;
blockedByEnv = true;

xspd = 0;
yspd = 0;

colLeft = 0;
colRight = 0;
colTop = 0;
colBottom = 0;
colMiddle = 0;

movLeft = 0;
movRight = 0;
movBottom = 0;
movTop = 0;

scr_movement_updateCollisionHitBox();
scr_movement_updateMovementHitBox();